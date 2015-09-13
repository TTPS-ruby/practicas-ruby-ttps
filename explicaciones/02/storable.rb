require_relative 'storage'

# Este módulo es la implementación de nuestro Mixin: nos permite encapsular la lógica que queremos compartir en las
# distintas clases que deben poder persistirse en el `Storage` sin necesidad de crear una jerarquía de clases que en
# realidad no lo es por el simple hecho de que las clases compartan cierta parte de su comportamiento.
module Storable
  # Este módulo contiene los métodos que terminarán siendo de clase en aquellas que incluyan `Storable`.
  # @see Storable.included
  module ClassMethods
    def find(key)
      storage[type_for_storage, key]
    end

    def find!(key)
      find(key) || raise("No element found for key #{key} of type #{type_for_storage}")
    end

    # Implementación básica del método #type que `Storage` requiere que los objetos a guardar en éste respondan.
    # Por defecto, utilizamos el nombre de la clase como tipo.
    def type_for_storage
      name
    end

    # Definir un método para encapsular el backend de storage que vamos a usar nos facilitaría cambiarlo si así lo
    # quisiéramos, con solo modificar o reimplementar este método.
    def storage
      Storage
    end
  end

  # Delegamos el método #type que requiere `Storage` en el método de clase .type_for_storage.
  def type
    self.class.type_for_storage
  end

  # Método que permite almacenar un objeto en el storage.
  def store
    self.class.storage[store_id] = self
  end

  # Implementación básica del método #store_id utilizado internamente por este módulo para almacenar los objetos en el
  # `Storage`. Si el objeto responde a `#id`, se utiliza ese valor como clave, caso contrario se utiliza el `object_id`
  # del objeto.
  def store_id
    if respond_to? :id
      id
    else
      object_id
    end
  end

  # Este método se invocará cuando este módulo sea incluido, recibiendo como parámetro `base` la clase (o el módulo) que
  # está incluyendo nuestro módulo.
  def self.included(base)
    # Acá se muestra el uso del módulo interno `ClassMethods`: encapsula en un _submódulo_ los métodos que serán de
    # clase, de manera tal que al incluir nuestro módulo seamos nosotros los encargados de extender `base` y agregar
    # como métodos de clase aquellos contenidos por el submódulo `ClassMethods`. Esto libera al usuario de nuestro
    # módulo de tener que hacer el `extend` explícitamente y beneficia el encapsulamiento de la lógica, al no ser
    # necesario que nuestro usuario conozca la implementación interna del módulo para utilizarlo, sólo debe conocer la
    # interfaz pública (API externa) del mismo.
    base.extend(ClassMethods)
  end
end

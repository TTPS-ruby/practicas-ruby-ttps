# Este módulo funciona como un _namespace_ para las clases que nos son provistas por la compañía ACME.
module ACME
  # Esta sentencia nos ahorra tener que incluir tanto este archivo (`acme.rb`) como también cualquier archivo donde se
  # definan clases dentro de este módulo.
  # El funcionamiento de `autoload` es el siguiente: nosotros declaramos en este módulo que existe una constante llamada
  # `:Storage` e indicamos dónde está definida. De esa forma, la primera vez que se la referencie, se irá a cargar la
  # definición que existe en el archivo que indicamos antes, evitando tener que requerir explícitamente esos archivos
  # en cada lugar que vayamos a utilizar las clases (o cualquier elemento) de este módulo.
  autoload :Storage, './acme/storage.rb'
end

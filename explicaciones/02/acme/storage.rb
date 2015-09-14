# Esta clase implementa un almacenamiento en memoria de valores identificados por una clave, agrupados por un tipo que
# se obtiene enviando el método `#type` al valor cuando se lo guarda.
#
# Por ejemplo, para guardar el objeto `my_object` puede utilizarse el siguiente código:
#
#     class Country
#       attr_accessor :iso_code, :name
#
#       def initialize(iso_code, name)
#         self.iso_code = iso_code
#         self.name = name
#       end
#
#       def type
#         :country
#       end
#     end
#
#     argentina = Country.new(:ar, 'Argentina')
#     ACME::Storage[argentina.iso_code] = argentina
#
# Y luego, puede volver a obtenerse ese valor del almacenamiento de la siguiente manera:
#
#     ACME::Storage[:country, :ar].name
#     # => "Argentina"
#
# O pueden obtenerse todos los valores almacenados para un tipo particular:
#
#     ACME::Storage[:country].keys
#     # => [:ar]
module ACME
  class Storage
    def self.[]=(key, value)
      store[value.type][key] = value
    rescue NoMethodError
      raise "Unable to store object of class #{value.class} as it doesn't respond to #type"
    end

    def self.[](type, key = nil)
      scope = store[type]
      scope = scope[key] unless key.nil?
      scope
    end

    def self.types
      store.keys
    end

    def self.store
      @store ||= Hash.new do |hash, key|
        hash[key] = {}
      end
    end
    private_class_method :store
  end
end

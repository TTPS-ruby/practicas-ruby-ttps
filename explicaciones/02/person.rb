require_relative 'storable'

class Person
  include Storable

  attr_accessor :id, :name, :phone_number

  # Definimos un constructor básico para poder establecer los atributos de la nueva instancia en el mismo `new`.
  def initialize(id, name, phone_number = nil)
    self.id = id
    self.name = name
    self.phone_number = phone_number
  end
end

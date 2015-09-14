require_relative 'storable'

class Building
  include Storable

  attr_accessor :id, :name, :address

  # Definimos un constructor básico para poder establecer los atributos de la nueva instancia en el mismo `new`.
  def initialize(id, name, address)
    self.id = id
    self.name = name
    self.address = address
  end
end

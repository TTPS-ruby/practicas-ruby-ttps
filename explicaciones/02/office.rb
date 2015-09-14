require_relative 'storable'
require_relative 'building'

class Office
  include Storable

  attr_accessor :id, :number, :floor, :building_id

  # Definimos un constructor básico para poder establecer los atributos de la nueva instancia en el mismo `new`.
  def initialize(id, number, floor, building)
    self.id = id
    self.number = number
    self.floor = floor
    self.building_id = building.id
  end

  # Este método permite obtener el objeto `Building` identificado por el valor que tenemos almacenado en el atributo
  # `building_id`.
  def building
    Building.find(building_id)
  end
end

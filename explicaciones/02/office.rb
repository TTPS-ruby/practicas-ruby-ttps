require_relative 'storable'
require_relative 'building'

class Office
  include Storable

  attr_accessor :id, :number, :floor, :building_id

  def initialize(id, number, floor, building)
    self.id = id
    self.number = number
    self.floor = floor
    self.building_id = building.id
  end

  def building
    Building.find(building_id)
  end
end

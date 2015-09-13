require_relative 'storable'

class Building
  include Storable

  attr_accessor :id, :name, :address

  def initialize(id, name, address)
    self.id = id
    self.name = name
    self.address = address
  end
end

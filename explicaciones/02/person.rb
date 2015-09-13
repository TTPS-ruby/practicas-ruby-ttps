require_relative 'storable'

class Person
  include Storable

  attr_accessor :id, :name, :phone_number

  def initialize(id, name, phone_number = nil)
    self.id = id
    self.name = name
    self.phone_number = phone_number
  end
end

require_relative 'person'
require_relative 'employee'

class Client < Person
  attr_accessor :representative_id

  # @see Employee.type_for_storage
  def self.type_for_storage
    superclass.name
  end

  def assigned_representative
    Employee.find(representative_id)
  end
end

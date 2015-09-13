require_relative 'person'
require_relative 'employee'

class Guest < Person
  attr_accessor :grants, :inviter_id

  def inviter
    Employee.find!(inviter_id)
  end
end

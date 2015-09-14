require_relative 'person'
require_relative 'employee'

class Guest < Person
  attr_accessor :grants, :inviter_id

  # Este método permite obtener el objeto `Employee` identificado por el valor que tenemos almacenado en el atributo
  # `inviter_id`.
  def inviter
    Employee.find!(inviter_id)
  end
end

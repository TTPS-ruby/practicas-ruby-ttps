require_relative 'person'
require_relative 'employee'

class Client < Person
  attr_accessor :representative_id

  # @see Employee.type_for_storage
  def self.type_for_storage
    superclass.name
  end

  # Este método permite obtener el objeto `Employee` identificado por el valor que tenemos almacenado en el atributo
  # `representative_id`.
  def assigned_representative
    Employee.find(representative_id)
  end
end

require_relative 'person'
require_relative 'office'

# Notá que esta y las demás clases que heredan de `Person` no necesitan incluir el módulo `Storable` porque ya se lo
# incluyó en la superclase.
class Employee < Person
  attr_accessor :file_number, :office_id

  # Definimos un constructor básico para poder establecer los atributos de la nueva instancia en el mismo `new`.
  def initialize(id, name, phone_number = nil, file_number = nil, office = nil)
    super(id, name, phone_number)
    self.file_number = file_number
    self.office_id = office.id unless office.nil?
  end

  # Como queremos que las instancias de la clase `Employee` se guarden junto con las de `Person`, sobreescribimos la
  # implementación genérica que Storable.type_for_storage provee con una específica a nuestro caso: devolvemos el nombre
  # de la superclase.
  def self.type_for_storage
    superclass.name
  end

  # Este método permite obtener el objeto `Office` identificado por el valor que tenemos almacenado en el atributo
  # `office_id`.
  def office
    Office.find(office_id)
  end
end

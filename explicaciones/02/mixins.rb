# Ejemplo de uso de módulos como Mixins para el Taller de Producción de Software - Opción Ruby - Cursada 2015.
#
# Este script muestra _una_ forma de utilizar módulos en Ruby como interfaces con comportamiento o, lo que es similar,
# como un mecanismo de herencia horizontal entre clases de diferentes jerarquías (también conocida como "herencia
# múltiple").
#
# En este ejemplo demostraremos, además, un patrón común para definir métodos de instancia y de clase en un mismo Mixin
# mediante el uso del módulo `ClassMethods` (el nombre no es obligatorio).
#
# Motivación
# ==========
#
# Se nos pide implementar un módulo que permita almacenar en memoria instancias de distintas clases, permitiendo
# utilizar así un mecanismo muy sencillo de caching de objetos. Ya disponemos de una clase `Storage` para utilizar que
# mantiene un diccionario de claves y valores, agrupados por el _tipo_ de cada valor que se obtiene mediante el envío
# del mensaje `type` al objeto que se intenta guardar.
#
# Las clases que utilizarán este mecanismo de persistencia son 6:
# * `Person`
# * `Employee` (subclase de `Person`)
# * `Client` (subclase de `Person`)
# * `Guest` (subclase de `Person`)
# * `Building`
# * `Office`
#
# Cada una de estas clases posee sus propios atributos y lógica que exceden el alcance de este ejemplo, por lo que vamos
# a obviarlos, simplemente agregando algunos atributos como para que las pruebas tengan sentido.
#
# Referencias
# ===========
#
# * Modules, "The Pragmatic Programmer's Guide", David Thomas & Andrew Hunt.
#   http://ruby-doc.com/docs/ProgrammingRuby/html/tut_modules.html

# Estos archivos que incluimos son la implementación del ejemplo. En este archivo únicamente haremos uso de lo que se
# define en ellos, a modo de ensayo y prueba de cómo podrían utilizarse esas clases y módulos.
require_relative 'storage'
require_relative 'storable'
require_relative 'person'
require_relative 'employee'
require_relative 'client'
require_relative 'guest'
require_relative 'building'
require_relative 'office'

def find_and_compare(v)
  v == v.class.find(v.id) ? '✓' : ''
end

puts "Al iniciar, el storage está vacío. Tiene #{Storage.types.count} tipos almacenados."
puts "Entonces creamos y almacenamos algunos objetos..."
tato = Person.new(1, 'Tato').store
tota = Person.new(2, 'Tota').store
rectorado = Building.new(1, 'Rectorado UNLP', 'Avenida 7 nro 776').store
oficina = Office.new(10, 101, 1, rectorado).store
empleado = Employee.new(3, 'Empleado del mes', nil, '1238/2', oficina).store
puts "Luego, el storage tiene valores de los siguientes tipos: #{Storage.types.join(', ')}."
puts "Podemos chequear si lo que el Storage tiene en su store interno coincide con lo que guardamos en él:"
puts "  - Tato: #{find_and_compare(tato)}"
puts "  - Tota: #{find_and_compare(tota)}"
puts "  - Rectorado: #{find_and_compare(rectorado)}"
puts "  - Oficina: #{find_and_compare(oficina)}"
puts "  - Empleado: #{find_and_compare(empleado)}"

begin
  no_existe = Person.find!(9)
  puts "Si llegamos hasta acá, alguien guardó una persona con id = 9."
rescue RuntimeError => e
  puts "No hay una persona con id = 9, por eso obtuvimos una excepción que dice \"#{e.message}\"."
end

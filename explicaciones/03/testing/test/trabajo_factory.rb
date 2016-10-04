require 'trabajo'

class TrabajoFactory
  class << self
    def build(fecha_entrega: fecha_entrega_default, originalidad: originalidad_default, simplicidad: simplicidad_default,
              prolijidad: prolijidad_default, desarrollo: desarrollo_default, asistencia: asistencia_default)
      Trabajo.new(fecha_entrega, originalidad, simplicidad, prolijidad, desarrollo, asistencia)
    end

    protected

    def fecha_entrega_default
      Date.today
    end

    def originalidad_default
      0
    end

    def simplicidad_default
      0
    end

    def prolijidad_default
      0
    end

    def desarrollo_default
      0
    end

    def asistencia_default
      0
    end
  end
end
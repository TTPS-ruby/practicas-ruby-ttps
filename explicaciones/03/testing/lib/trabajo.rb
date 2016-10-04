class Trabajo
  attr_accessor :fecha_entrega, :originalidad, :simplicidad, :prolijidad, :desarrollo, :asistencia, :nota

  def initialize(fecha_entrega, originalidad, simplicidad, prolijidad, desarrollo, asistencia)
    self.fecha_entrega = fecha_entrega
    self.originalidad = originalidad
    self.simplicidad = simplicidad
    self.prolijidad = prolijidad
    self.desarrollo = desarrollo
    self.asistencia = asistencia
  end

  def es_prolijo?
    prolijidad >= 4
  end

  def entregado_a_termino?(fecha_limite)
    fecha_entrega <= fecha_limite
  end

  def buen_desarrollo?
    desarrollo >= 5
  end

  def aplica_bonus_asistencia?
    asistencia >= 5
  end
end
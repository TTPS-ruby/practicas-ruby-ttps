class Calificador
  attr_reader :trabajo, :fecha_limite

  def initialize(trabajo, fecha_limite = nil)
    @trabajo = trabajo
    @fecha_limite = fecha_limite || Date.today
  end

  def calificar
    trabajo.nota = originalidad + simplicidad + prolijidad + entrega_a_termino + desarrollo + bonus_asistencia
  end

  def aprobado?
    calificar if trabajo.nota.nil?
    trabajo.nota > porcentaje_aprobacion
  end

  def porcentajes
    {
      originalidad:       10,
      simplicidad:        25,
      prolijidad:         15,
      entrega_a_termino:  10,
      desarrollo:         35,
      bonus_asistencia:    5
    }
  end

  def porcentaje_aprobacion
    40
  end

  protected

  def originalidad
    (trabajo.originalidad / 10.0) * porcentajes[:originalidad]
  end

  def simplicidad
    (trabajo.simplicidad / 10.0) * porcentajes[:simplicidad]
  end

  def prolijidad
    trabajo.es_prolijo? ? porcentajes[:prolijidad] : 0
  end

  def entrega_a_termino
    trabajo.entregado_a_termino?(fecha_limite) ? porcentajes[:entrega_a_termino] : 0
  end

  def desarrollo
    trabajo.buen_desarrollo? ? porcentajes[:desarrollo] : 0
  end

  def bonus_asistencia
    trabajo.aplica_bonus_asistencia? ? porcentajes[:bonus_asistencia] : 0
  end
end
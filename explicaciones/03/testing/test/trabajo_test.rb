require 'minitest/autorun'
require 'date'
require 'trabajo_factory'
require 'trabajo'

class TestTrabajo < Minitest::Test
  # #initialize
  def test_initialize_stores_values
    fecha_entrega = Date.new(2016, 10, 3)
    originalidad = 1
    simplicidad = 2
    prolijidad = 3
    desarrollo = 4
    asistencia = 5
    sut = trabajo(fecha_entrega: fecha_entrega, originalidad: originalidad, simplicidad: simplicidad, prolijidad: prolijidad, desarrollo: desarrollo, asistencia: asistencia)
    assert_equal fecha_entrega, sut.fecha_entrega
    assert_equal originalidad, sut.originalidad
    assert_equal simplicidad, sut.simplicidad
    assert_equal prolijidad, sut.prolijidad
    assert_equal desarrollo, sut.desarrollo
    assert_equal asistencia, sut.asistencia
  end

  # #es_prolijo?
  def test_es_prolijo_si_menor
    refute trabajo(prolijidad: 3).es_prolijo?
  end

  def test_es_prolijo_si_igual
    assert trabajo(prolijidad: 4).es_prolijo?
  end

  def test_es_prolijo_si_mayor
    assert trabajo(prolijidad: 9).es_prolijo?
  end

  # #entregado_a_termino?
  def test_entregado_a_termino_si_anterior
    fecha_entrega = Date.new(2016, 10, 3)
    fecha_limite = Date.new(2016, 10, 10)
    assert trabajo(fecha_entrega: fecha_entrega).entregado_a_termino?(fecha_limite)
  end

  def test_entregado_a_termino_si_el_mismo_dia
    fecha_limite = fecha_entrega = Date.new(2016, 10, 3)
    assert trabajo(fecha_entrega: fecha_entrega).entregado_a_termino?(fecha_limite)
  end

  def test_entregado_a_termino_si_posterior
    fecha_entrega = Date.new(2016, 10, 3)
    fecha_limite = Date.new(2016, 10, 1)
    refute trabajo(fecha_entrega: fecha_entrega).entregado_a_termino?(fecha_limite)
  end

  # #buen_desarrollo?
  def test_buen_desarrollo_si_menor
    refute trabajo(desarrollo: 3).buen_desarrollo?
  end

  def test_buen_desarrollo_si_igual
    assert trabajo(desarrollo: 5).buen_desarrollo?
  end

  def test_buen_desarrollo_si_mayor
    assert trabajo(desarrollo: 9).buen_desarrollo?
  end

  # #aplica_bonus_asistencia?
  def test_aplica_bonus_asistencia_si_menor
    refute trabajo(asistencia: 3).aplica_bonus_asistencia?
  end

  def test_aplica_bonus_asistencia_si_igual
    assert trabajo(asistencia: 5).aplica_bonus_asistencia?
  end

  def test_aplica_bonus_asistencia_si_mayor
    assert trabajo(asistencia: 9).aplica_bonus_asistencia?
  end

  protected

  # Método factory para SUTs
  def trabajo(fecha_entrega: nil, originalidad: nil, simplicidad: nil, prolijidad: nil, desarrollo: nil, asistencia: nil)
    TrabajoFactory.build(fecha_entrega: fecha_entrega, originalidad: originalidad, simplicidad: simplicidad, prolijidad: prolijidad, desarrollo: desarrollo, asistencia: asistencia)
  end
end
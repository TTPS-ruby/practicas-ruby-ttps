require 'simplecov'
require 'minitest/autorun'
require 'calculadora'

class CalculadoraTest < Minitest::Test
  def setup
    @calculadora = Calculadora.new
  end

  def test_suma_ceros
    assert_equal 0, @calculadora.sumar(0, 0)
  end

  def test_suma_positivos
    assert_equal 1, @calculadora.sumar(1, 0)
    assert_equal 2, @calculadora.sumar(1, 1)
  end

  def test_suma_positivos_negativos
    assert_equal 1, @calculadora.sumar(2, -1)
  end

  def test_suma_negativos
    assert_equal (-2), @calculadora.sumar(-1, -1)
    assert_equal (-1), @calculadora.sumar(-1, 0)
  end

  def test_suma_no_importa_orden
    assert_equal @calculadora.sumar(10, 2), @calculadora.sumar(2, 10)
  end
end

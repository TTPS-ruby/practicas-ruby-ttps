require 'simplecov'
require 'minitest/autorun'
require 'calculadora'

describe Calculadora do
  before do
    @calculadora = Calculadora.new
  end

  describe 'Suma' do
    it 'correctamente ceros' do
      _(@calculadora.sumar(0, 0)).must_equal 0
    end

    it 'correctamente valores positivos' do
      _(@calculadora.sumar(1, 0)).must_equal 1
      _(@calculadora.sumar(1, 1)).must_equal 2
    end

    it 'correctamente valores positivos y negativos' do
      _(@calculadora.sumar(2, -1)).must_equal 1
    end

    it 'correctamente negativos' do
      _(@calculadora.sumar(-1, -1)).must_equal(-2)
      _(@calculadora.sumar(-1, 0)).must_equal(-1)
    end

    it 'es indiferente al orden de los sumandos' do
      _(@calculadora.sumar(10, 2)).must_equal @calculadora.sumar(2, 10)
    end
  end
end


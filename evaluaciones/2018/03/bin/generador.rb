#!/usr/bin/env ruby

# Script para generar datos de prueba en formato CSV para el ejercicio entregable
# de la práctica 3 de TTPS Opción Ruby - Cursada 2018.
#
# Uso:
#     $ bin/generador.rb
#     # ^ genera un archivo CSV con el número por defecto de días de datos (100)
#     #   y lo guarda como "data-<fecha de hoy>.csv" en el directorio actual.
#     $ bin/generador.rb 20
#     # ^ genera un archivo CSV con 20 días de datos y lo guarda como
#     #   "data-<fecha de hoy>.csv" en el directorio actual.
#
# Los archivos CSV generados por este script incluirán una primera línea adicional
# con los encabezados describiendo el contenido de cada campo del CSV.

require 'csv'

DEFAULT_DAYS_COUNT = 100
HEADER_LINE = [
  'Año', 'Mes', 'Día', 'Hora', 'Minuto',
  'Temperatura (ºC)', 'Sensación térmica (ºC)', 'Precipitaciones (mm)', 'Humedad (hPa)'
]
RANDOM_FAILURE_RATE = 0.2
FAILED_STRINGS = ['-', 'NaN']

def unstable_random(values)
  # Agrega un cierto nivel de fallas aleatorias a los valores a procesar
  return FAILED_STRINGS.shuffle.first if rand(100) < 100 * RANDOM_FAILURE_RATE

  rand(values)
end

def generate_day(date, csv)
  base = [date.year, date.month, date.day]
  hourly_time = DateTime.new(date.year, date.month, date.day, 0, 0, 0, date.send(:zone))
  24.times do |hour|
    60.times do |minute|
      csv << [
        hourly_time.year, hourly_time.month, hourly_time.day, hourly_time.hour, hourly_time.min,
        unstable_random(-1.5..40.5), unstable_random(-2.0..41.7), unstable_random(0.0..400.0), unstable_random(0..1010)
      ]
      hourly_time += Rational(1, 24 * 60)
    end
  end
end

outfile = "data-#{Date.today.strftime('%Y%m%d')}.csv"
days_count = Integer(ARGV[0]) rescue DEFAULT_DAYS_COUNT

print "Generando un historial de #{days_count} días en el archivo #{outfile} del directorio actual... "

CSV.open(outfile, 'w') do |csv|
  csv << HEADER_LINE
  pivot_date = Date.today - days_count + 1
  days_count.times do |i|
    generate_day(pivot_date, csv)
    pivot_date += 1
  end
end

puts "Listo."
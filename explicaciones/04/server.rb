require 'sinatra'
require_relative 'day_checker'
require_relative 'smiley'

set :public_folder, 'public'

# Utilizar middleware Smiley
use Smiley

# GET /
# Chequea si el día actual es el día por defecto chequeado por `DayChecker`
get '/' do
  DayChecker.is?(Date.today)
end

# GET /lunes o GET /1
# Chequea si el día actual es el día recibido como parámetro
get '/:day' do
  DayChecker.is? Date.today, params[:day]
end

puts "Server iniciado. Ahora podés acceder a http://localhost:#{settings.port}/ y probar"

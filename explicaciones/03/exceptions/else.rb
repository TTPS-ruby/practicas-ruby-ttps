begin
  raise 'Oops'

rescue RuntimeError
  puts $!.inspect
  puts 'todo mal...'
else
  puts $!.inspect
  puts 'todo bien'
end

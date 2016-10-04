begin
  #raise 'a'

rescue SystemExit
  puts 'no'
else
  puts $!.inspect
  puts 'todo mal'
end



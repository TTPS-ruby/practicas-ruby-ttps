  puts "Welcome to REPLica!"

  HISTORY_FILE = 'history.txt'

  def h
    puts File.read(HISTORY_FILE)
  end

begin
  history = File.open(HISTORY_FILE, 'r+')
rescue Errno::ENOENT
  history = File.open(HISTORY_FILE, 'w')
rescue Errno::EACCES
  $stderr.puts "No tengo permisos!"
  exit 1
end
  ln = 0

  while true
    print "[#{ln += 1}]> "
    script = gets
    history << script
    begin
      eval script
    rescue SystemExit
      break
    rescue Exception => e
      $stderr.puts e.message
    end
  end



  history.close

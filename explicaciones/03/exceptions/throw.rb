def inicio
  $l = 0
  catch(:stop) do
    while true
      metodo_a
    end
  end
  puts "Terminamos!"
end

def ll(metodo)
  $l += 1
  puts "#{' ' * $l}#{metodo}"
end

def metodo_a
  ll __method__
  if rand(0..1) == 0
    metodo_b
  else
    metodo_c
  end
end

def metodo_b
  ll __method__
  metodo_d
end

def metodo_c
  ll __method__
  metodo_i
end

def metodo_d
  ll __method__
  case rand(0..4)
    when 0
      throw :stop
    when 1
      metodo_e
    when 2
      metodo_f
    when 3
      metodo_g
    when 4
      metodo_h
  end
end

def metodo_e
  ll __method__
  metodo_a
end

def metodo_f
  ll __method__
  metodo_i
end

def metodo_g
  ll __method__
  metodo_d
end

def metodo_h
  ll __method__
  metodo_g
end

def metodo_i
  ll __method__
  metodo_d
end

inicio
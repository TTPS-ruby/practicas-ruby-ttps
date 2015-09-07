# TTPS opción Ruby

# Práctica 2

En esta segunda práctica del taller aplicaremos lo visto sobre el lenguaje Ruby, analizando distintas situaciones con
los elementos fundamentales del mismo: los métodos, las clases y los módulos, los bloques, y los enumeradores.

## Métodos

1. Implementá un método que reciba como parámetro un arreglo de números, los ordene y devuelva el resultado. Por
   ejemplo:

   ```ruby
   ordenar_arreglo([1, 4, 6, 2, 3, 0, 10])
   # => [0, 1, 2, 3, 4, 6, 10]
   ```

2. Modificá el método anterior para que en lugar de recibir un arreglo como único parámetro, reciba todos los números
   como parámetros separados. Por ejemplo:

   ```ruby
   ordenar(1, 4, 6, 2, 3, 5, 0, 10, 9)
   # => [0, 1, 2, 4, 5, 6, 9, 10]
   ```

3. Suponé que se te da el método que implementaste en el ejercicio anterior para que lo uses a fin de ordenar un arreglo
   de números que te son provistos en forma de arreglo. ¿Cómo podrías invocar el método? Por ejemplo, teniendo la
   siguiente variable con los números a ordenar:

   ```ruby
   entrada = [10, 9, 1, 2, 3, 5, 7, 8]
   # Dada `entrada', invocar a #ordenar utilizando sus valores para ordenarlos
   ```

4. Escribí un método que dado un número variable de parámetros que pueden ser de cualquier tipo, imprima en pantalla
   la cantidad de caracteres que tiene su representación como `String` y la representación que se utilizó para contarla.

   > Nota: Para convertir cada parámetro a string utilizá el método #to_s presente en todos los objetos.

   Por ejemplo:

   ```ruby
   longitud(9, Time.now, 'Hola', {un: 'hash'}, :ruby)
   # Debe imprimir:
   # "9" --> 1
   # "2015-09-07 21:04:10 +0000" --> 25
   # "Hola" --> 4
   # {:un=>"hash"} --> 13
   # ruby --> 4
   ```

5. Implementá el método `cuanto_falta?` que opcionalmente reciba como parámetro un objeto `Time` y que calcule la
   cantidad de minutos que faltan para ese momento. Si el parámetro de fecha no es provisto, asumí que la consulta es
   para la medianoche de hoy.

   Por ejemplo:

   ```ruby
   cuanto_falta? Date.new(2015, 12, 31, 23, 59, 59)
   # Debe retornar la cantidad de minutos que faltan para las 23:59:59 del 31/12/2015
   cuanto_falta?
   # Debe retornar la cantidad de minutos que faltan para la medianoche de hoy
   ```

6. Analizá el siguiente código e indicá qué problema(s) puede tener.

   ```ruby
   # Tira un dado virtual de 6 caras
   def tirar_dado
     rand 1..6
   end

   # Mueve la ficha de un jugador tantos casilleros como indique el dado en un tablero virtual de 40 posiciones.
   # Si no se recibe la cantidad de casilleros, aprovecho el valor por defecto para ese parámetro para evitar tener que
   # llamar a #tirar_dado dentro del cuerpo del método.
   def mover_ficha(fichas, jugador, casilleros = tirar_dado)
     fichas[jugador] += casilleros
     if fichas[jugador] > 40
       puts "Ganó #{jugador}!!"
       true
     else
       puts "#{jugador} ahora está en el casillero #{fichas[jugador]}"
       fichas[jugador]
     end
   end

   posiciones = { azul: 0, rojo: 0, verde: 0 }

   finalizado = false
   until finalizado
     ['azul', 'rojo', 'verde'].shuffle.each do |jugador|
       finalizado = mover_ficha(posiciones, jugador)
     end
   end
   ```

7. Modificá el código anterior para, acorde a tu análisis, corregir los problemas que pueda tener.

   > Nota: asumí que el juego debe terminar al momento que el primer jugador supera la posición 40 en el tablero.

## Clases y módulos

8. Modelá con clases

9. ¿Qué diferencia hay entre el uso de `include` y `extend` a la hora de incorporar un módulo en una clase?
  1. Si quisieras usar un módulo para agregar métodos de instancia a una clase, ¿qué forma usarías a la hora de
     incluirlo en la clase?
  2. Si en cambio quisieras usar un módulo para agregar métodos de clase, ¿qué forma usarías a la hora de incluir el
     módulo en la clase?

10. Implementá el módulo `Reverso` para utilizar como _Mixin_ e incluilo en alguna clase para probarlo. `Reverso` debe
    contener los siguientes métodos:
  1. `#di_tcejbo`: Imprime el `object_id` del receptor en espejo (en orden inverso).
  2. `#ssalc`: Imprime el nombre de la clase del receptor en espejo.

11. Analizá el siguiente código e indicá qué retornaría cada invocación

12. Implementá el Mixin `Countable` que te permita hacer que cualquier clase cuente la cantidad de veces que los
    métodos de instancia definidos en ella es invocado. Utilizalo en distintas clases, tanto desarrolladas por vos como
    clases de la librería standard de Ruby, y chequeá los resultados. El Mixin debe tener los siguientes métodos:
  1. `count_invocations_of(sym)`: método de clase que al invocarse realiza las tareas necesarias para contabilizar las
     invocaciones al método de instancia cuyo nombre es `sym` (un símbolo).
  2. `invoked?(sym)`: método de instancia que devuelve un valor booleano indicando si el método llamado `sym` fue
     invocado al menos una vez en la instancia receptora.
  3. `invoked(sym)`: método de instancia que devuelve la cantidad de veces que el método identificado por `sym` fue
     invocado en la instancia receptora.

  Por ejemplo:

    ```ruby
    # Ejemplo de uso de Countable
    class Greeter
      # Incluyo el Mixin
      include Countable

      def hi
        puts 'Hey!'
      end

      def bye
        puts 'See you!'
      end

      # Indico que quiero llevar la cuenta de veces que se invoca el método #hi
      count_invocations_of :hi
    end

    a = Greeter.new
    b = Greeter.new

    a.invoked? :hi
    # => false
    b.invoked? :hi
    # => false

    a.hi
    # Imprime "Hey!"

    a.invoked :hi
    # => 1
    b.invoked :hi
    # => 0
    ```

    > Nota: para simplificar el ejercicio, asumí que los métodos a contabilizar no reciben parámetros.

    > Tips: investigá `Module#alias_method` y `Module#included`.

13. **TODO**

14. **TODO**

15. Extendé las clases `TrueClass` y `FalseClass` para que ambas respondan al método de instancia `opposite`, el cual en
    cada caso debe retornar el valor opuesto al que recibe la invocación al método. Por ejemplo:

    ```ruby
    false.opposite
    # => true
    true.opposite
    # => false
    true.opposite.opposite
    # => true
    ```

## Bloques

16. Escribí un método `da_nil?` que reciba un bloque, lo invoque y retorne si el valor de retorno del bloque fue `nil`.
    Por ejemplo:

    ```ruby
    da_nil? { }
    # => true
    da_nil? do
      'Algo distinto de nil'
    end
    # => false
    ```

17. **TODO**

18. **TODO**

19. **TODO**

## Enumeradores

20. Si no lo hiciste de esa forma en la práctica 1, escribí un enumerador que calcule la serie de Fibonacci.

21. ¿Qué son los _lazy enumerators_? ¿Qué ventajas les ves con respecto al uso de los enumeradores que no son _lazy_?
    > Analizalo pensando en grandes conjuntos de datos.

22. **TODO**

23. **TODO**

24. **TODO**

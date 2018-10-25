# TTPS Opción Ruby 2018
## Ejercicio entregable TP 3

Implementá en Ruby un programa que se utilice para procesar un conjunto de archivos en formato CSV (_Comma-Separated Values_) que se encuentran almacenados en un directorio particular
del sistema (cuya ruta se recibe como argumento al momento de ejecutar el programa), a fin de obtener totalizaciones, promedios y otros valores (más adelante definidos) a partir de la información obtenida de los archivos.

Los archivos CSV a procesar contienen registros del clima en la ciudad de La Plata con información obtenida cada 1 (un) minuto a lo largo de un periodo temporal, y tienen la siguiente estructura:

```
ENCABEZADO
DATOS
```

Donde:

* `ENCABEZADO` es una única línea que contiene los rótulos de los campos del archivo, y
* `DATOS` es una o más líneas de datos.

Los campos de datos que se manejan son:

* **Año:** Año en que se tomó la medición indicada en una línea de datos.
* **Mes:** Mes en que se tomó la medición indicada en una línea de datos.
* **Día:** Día en que se tomó la medición indicada en una línea de datos.
* **Hora:** Hora en que se tomó la medición indicada en una línea de datos.
* **Minuto:** Minuto en que se tomó la medición indicada en una línea de datos.
* **Temperatura:** Temperatura (en grados Celsius) obtenida en la medición.
* **Sensación Térmica:** Sensación Térmica (en grados Celsius) obtenida en la medición.
* **Precipitaciones:** Precipitaciones (en milímetros) registradas al momento de la medición.
* **Humedad:** Humedad (en hectopascales) registrada al momento de la medición.

Los campos que conforman la fecha (los primeros 5) se garantiza que siempre tendrán valores adecuados (es decir, no puede ocurrir que la fecha sea día 35 del mes 15). Por el contrario, debido a posibles fallas aleatorias en el instrumental de medición, el resto de los campos (las mediciones) pueden tener valores faltantes, los cuales se representan con `-` (un caracter guión) o `NaN` en lugar del valor numérico.

A continuación tenés un extracto de un archivo CSV de ejemplo:

```csv
Año,Mes,Día,Hora,Minuto,Temperatura (ºC),Sensación térmica (ºC),Precipitaciones (mm),Humedad (hPa)
2018,7,18,0,0,-0.47155192756709763,30.200061663009606,178.08681183977515,-
2018,7,18,0,1,5.5675916076800895,7.905993186097383,69.64445749366467,18
2018,7,18,0,2,NaN,24.029432122140864,353.5206970511477,863
2018,7,18,0,3,4.5494899464336,25.4432104949894,22.38290725345715,NaN
```

Con la información que se procese, se necesitan obtener los siguientes valores:

* Promedio de temperatura diaria.
* Promedio de temperatura mensual.
* Amplitud térmica diaria (diferencia entre la temperatura mínima y la máxima en un día).
* Día más cálido del mes.
* Día más frío del mes.
* Promedio de precipitaciones mensual.
* Tasa de falla de los instrumentos de medición, por unidad. La tasa de falla es una proporción `fallas / mediciones_totales` por cada instrumento de medición (este valor se toma considerando todo el archivo procesado, sin cortes temporales).
* El instrumento que más ha fallado en sus mediciones (basándose en la métrica anterior).

> _Nota 1: Los valores "diarios" se entienden para cada día que esté presente en el archivo de datos, así como los "mensuales" son para cada mes presente en el archivo._

> _Nota 2: los valores que indican falla de una medición no deben contarse para los promedios; es decir que si se tienen 50 mediciones de temperatura, de las cuales 5 tuvieron error, el total de mediciones a considerar para el promedio de temperatura será de 45._ 

Adicionalmente, tenés que implementar los tests de unidad con los casos necesarios para garantizar el correcto funcionamiento de todas las métricas que se te pide que implementes.

### Ejemplos de uso del programa

> _Nota: en los ejemplos se asume que el punto de entrada al programa implementado está en el archivo `main.rb`._

Procesar los archivos almacenados en el directorio `data` dentro del directorio actual:

```
$ ruby main.rb ./data
```

Procesar los archivos almacenados en el directorio `/tmp/clima`:

```
$ ruby main.rb /tmp/clima
```

> _Aclaración: podés asumir que los archivos a procesar dentro del directorio recibido como parámetro son todos aquellos cuya extensión sea `.csv`._

- - -

Para facilitar las pruebas, se provee un script generador de datos en el formato esperado (con la tasa de fallos aleatoria incluida) para que puedas generar archivos CSV para realizar las pruebas que necesites.

El mismo está incluido en el subdirectorio `bin/` del [directorio donde está el archivo fuente de este enunciado](https://github.com/TTPS-ruby/practicas-ruby-ttps/tree/master/evaluaciones/2018/03) en el repositorio de prácticas de la materia, y contiene las instrucciones para utilizarlo en el mismo código.

- - -

La entrega deberá realizarse **de manera individual** mediante el curso de la materia [la plataforma de Cátedras](https://catedras.info.unlp.edu.ar/), en una tarea destinada a tal fin, y deberá incluir todo el código fuente necesario para el correcto funcionamiento del programa. **No incluir archivos CSV de pruebas**, ya que los mismos se generarán al momento de la corrección utilizando el script generador de datos antes mencionado.

> _Además del análisis humano que realizaremos, todos los trabajos se compararán entre sí con métodos de análisis estático de código para encontrar si hay trabajos copiados entre sí, en cuyo caso se considerarán desaprobados todos los que se encuentren en esa situación._

## Fecha límite para la entrega: **Viernes 9 de noviembre de 2018 a las 12:00hs** (al mediodía).
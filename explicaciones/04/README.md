# TTPS opción Ruby

# Explicación de Práctica 4

Este proyecto demuestra un caso sencillo de uso de las siguientes herramientas:

* Bundler
* Rack
* Sinatra

La aplicación web basada en Sinatra es una implementación muy sencilla del típico "¿Ya es viernes?". La misma provee los
siguientes puntos de consulta:

* `GET /`  
  Contesta sí o no, en función de si la fecha actual es viernes.
* `GET /:day`  
  Contesta sí o no, acorde a si la fecha actual es `:day`, donde éste parámetro puede ser:
  * Un número (`0..6`) indicando el índice del día de semana con el cual comparar, basado en `0` y comenzando a contar
    desde el domingo.
  * Un string (`domingo`, `lunes`, `martes`, `miercoles`, `jueves`, `viernes`, `sabado`) indicando el nombre en español
    del día de la semana con el cual comparar.

Esta aplicación utiliza Bundler para manejar sus dependencias, Sinatra para definir el comportamiento del server web, e
implementa un *middleware* Rack que agrega *smileys* a la respuesta en función de su contenido, a modo de ejemplo de las
posibilidades que brindan estos elementos.

## Cómo probarlo

```console
$ bundle
$ bundle exec ruby server.rb
```

Y luego acceder en el navegador a la URL que sugiere la salida del comando.

Algunas URLs para probar:

* `/`
* `/1`
* `/lunes`
* `/miercoles`
* `/viernes`
* `/osvaldo`
* `/7`

> `curl http://localhost:4567/lunes`

# TTPS Opción Ruby 2018
## Ejercicio entregable TP 4

Implementá una API (basada en los principios [REST](https://en.wikipedia.org/wiki/Representational_state_transfer)) para un sistema on-line de ventas de la empresa Minimarket LLC, que comprenda los siguientes servicios:

| Ruta del endpoint | Descripción |
| ----------------- | ----------- |
| `GET /items.json` | Devuelve un arreglo con los ítems disponibles. Para cada item se debe incluir su ID, [SKU](https://es.wikipedia.org/wiki/Stock-keeping_unit) y descripción. |
| `GET /items/:id.json` | Devuelve la información completa de un item: ID, SKU, descripción, stock y precio. |
| `POST /items.json` | Agrega un item a los disponibles en el sistema. Recibe como parámetros en el cuerpo de la petición el SKU, la descripción, el stock inicial y el precio. |
| `PUT /items/:id.json` | Actualiza la información de un item de disponibles en el sistema. Puede recibir como parámetros en el cuerpo de la petición el SKU, la descripción, el stock y/o el precio (se debe validar que se reciba al menos uno). |
| `GET /cart/:username.json` | Devuelve los ítems en el carrito de compras del usuario identificado por el parámetro `:username`, el monto total que lleva sumado para su compra, y la fecha en que se creó. Si no existiese, se debe inicializar un nuevo carrito vacío para ese usuario y retornar la información del carrito vacío. |
| `PUT /cart/:username.json` | Agrega un item al carrito de compras del usuario identificado por el parámetro `:username`. En el cuerpo de la petición se debe incluir el ID del item y la cantidad a agregar. Si el carrito de compras no existiese para el usuario solicitado, se debe crear un carrito vacío antes de agregar el item. |
| `DELETE /cart/:username/:item_id.json` | Borra un item (identificado por el parámetro `:item_id`) del carrito de compras del usuario identificado por el parámetro `:username`. Si el carrito de compras no existiese para el usuario solicitado, se debe crear un carrito vacío y no hacer nada. |

La implementación debés realizarla utilizando Rack, Sinatra y un Gemfile para declarar las dependencias del proyecto.

Algunas aclaraciones:
* Toda la información que es maneje puede estar en memoria, ya que no se solicita persistencia de ninguna otra forma (bases de datos o archivos, por ejemplo). Esto quiere decir que cada vez que se termine el proceso que corre el servidor de la aplicación Sinatra, los datos que se tengan se descartarán. En caso de implementarse la persistencia, será considerada como puntaje extra sobre lo que el trabajo requiere para su aprobación.
* Es obligatorio que valides los parámetros recibidos para asegurarte que sean los esperados.
* Los endpoints deben retornar respuestas HTTP con códigos acorde a lo ocurrido (podés ver en [httpstatus.es](https://httpstatuses.com) la referencia completa de estados posibles con sus descripciones): de éxito en caso de ejecución satisfactoria, de error en caso de que no se pueda realizar la operación solicitada, etc.
* El formato de las respuestas debe ser JSON, y se debe responder indicando la cabecera `content-type` adecuada para ese tipo de contenidos.
* El Gemfile del proyecto debe incluir todas las dependencias que el mismo posea para funcionar. No se considerará incluida una dependencia si debe ser instalada externamente con `gem install`.

### Ejemplos de uso

Para probar la API podés usar un navegador web, un entorno de desarrollo de APIs como [Postman](https://www.getpostman.com) o simplemente herramientas de consola como [cURL](https://curl.haxx.se/) y [jq](https://stedolan.github.io/jq/). A continuación tenés ejemplos de lo que debería responder, aproximadamente, cada endpoint probándolos con cURL.

> En estos ejemplos se asume que la API está ejecutándose en `http://localhost:4567`, los comandos muestran cómo hacer una petición utilizando cURL de manera que se puedan visualizar las cabeceras y el cuerpo de la respuesta.
> Para simplificar los ejempos, se omiten cabeceras de la respuesta que no resultan significativas para los mismos.
> Los ejemplos aquí presentados son una parte de los endpoints que deben implementarse, y son para que los utilices a modo ilustrativo.

#### Obtención de un listado de ítems (vacío)

##### Petición

```console
$ curl -sSL -D - http://localhost:4567/items.json
```

##### Respuesta

```
HTTP/1.1 200 OK
Content-Type: application/json

[]
```

#### Obtención de un listado de ítems (con elementos)

##### Petición

```console
$ curl -sSL -D - http://localhost:4567/items.json
```

##### Respuesta

```
HTTP/1.1 200 OK
Content-Type: application/json

[
  {
    "id": 1,
    "sku": "12345-WH-XS",
    "description": "Women hoodie - White - XS"
  }
]
```

#### Obtención de un item (inexistente)

##### Petición

```console
$ curl -sSL -D - http://localhost:4567/items/1000.json
```

##### Respuesta

```
HTTP/1.1 404 Not Found
Content-Type: application/json
Content-Length: 0
```

#### Obtención de un item (existente)

##### Petición

```console
$ curl -sSL -D - http://localhost:4567/items/1.json
```

##### Respuesta

```
HTTP/1.1 200 OK
Content-Type: application/json

{
  "id": 1,
  "sku": "12345-WH-XS",
  "description": "Women hoodie - White - XS",
  "price": 23.48,
  "stock": 8
}

```

#### Creación de un ítem (incorrecta)

##### Petición

```console
$ curl -sSL -D - -X POST http://localhost:4567/items.json -H 'Content-Type: application/json' -d '{"sku": "XXX"}'
```

##### Respuesta

```
HTTP/1.1 422 Unprocessable Entity
Content-Type: application/json
Content-Length: 0
```

#### Creación de un ítem (correcta)

##### Petición

```console
$ curl -sSL -D - -X POST http://localhost:4567/items.json -H 'Content-Type: application/json' -d '{"sku": "12345-WH-XS", "description": "Women hoodie - White - XS", "price": 23.48, "stock": 8}'
```

##### Respuesta

```
HTTP/1.1 201 Created
Content-Type: application/json

{
  "id": 1,
  "sku": "12345-WH-XS",
  "description": "Women hoodie - White - XS",
  "stock": 8,
  "price": 23.48
}
```

- - -

La entrega deberá realizarse **de manera individual** mediante el curso de la materia en [la plataforma de Cátedras](https://catedras.info.unlp.edu.ar/), en una tarea destinada a tal fin, y se hará incluyendo la URL de un repositorio git disponible on-line. En el repositorio se deberá incluir todo el código fuente necesario para el correcto funcionamiento de la API, junto con los archivos de dependencias y un archivo `README` con indicaciones claras sobre cómo se puede poner en funcionamiento la aplicación Sinatra.

> _Tener en cuenta que el repositorio debe poder se accedido por cualquiera de los docentes de la cátedra._

## Fecha límite para la entrega: **Domingo 2 de diciembre de 2018 a las 23:55hs**.

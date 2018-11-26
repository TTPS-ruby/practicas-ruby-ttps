# TTPS Opción Ruby 2018
## Trabajo Práctico Integrador

Te contactaron para implementar el conjunto de servicios backend que alimentan una aplicación de preguntas y respuestas estilo foro y de muy buena gana aceptaste el desafío.

La aplicación pública (frontend) ya se encuentra desarrollada, por lo que el formato y la estructura de las respuestas que implementes para los servicios que se te solicitan deberán adecuarse a las respuestas esperadas por el frontend.

Como primer requisito, se te solicita que los servicios deben seguir el estándar [JSON:API](https://jsonapi.org/) aunque no deben hacierlo estrictamente en todo sentido, sino que sólo deben respetar las generalidades de estructura de las respuestas, tipo(s) MIME y los documentos compuestos (_Compound documents_).

El segundo requisito que tenés es que todas las peticiones deben ser autenticadas mediante el uso tokens temporales para evitar que un usuario realice peticiones en nombre de otro. Para esto, el token obtenido mediante el servicio de inicio de sesión (`login`, más adelante detallado) debe enviarse en todas las peticiones subsiguientes en la cabecera `X-QA-Key` de las mismas. De esta manera, toda petición recibida que requiera que el usuario se encuentre identificado obtendrá qué usuario está realizando la petición mediante el token recibido por la cabecera.

Luego, se te pide que realices tests de unidad de todos los modelos que implementes para cubrir las funcionalidades más importantes. Al menos debés tener implementados 10 tests **no triviales**.

Los servicios que tenés que implementar son los siguientes:

| Endpoint | Descripción | ¿Requiere token? |
| -------- | ----------- | ---------------- |
| `POST /users` | Crea un nuevo usuario con los datos provistos en la petición. Los atributos que se reciben son los correspondientes al modelo `User`. | No |
| `POST /sessions` | Inicia sesión con un usuario, cuyos nombre de usuario y clave se reciben en el cuerpo de la petición en los parámetros `username` y `password`. De ser correctos el nombre de usuario y contraseña, se debe generar un token temporal para el usuario y retornarlo, junto con los datos del usuario autenticado, en un atributo `token` para que el frontend lo guarde y lo utilice en las peticiones a servicios que requieran dicho token. La validez del token es de 30 minutos, pasados los cuales se deberá volver a identificar el usuario (mediante este mismo servicio) para así generarle un nuevo token. | No |
| `GET /questions/:sort` | Retorna un listado de las últimas 50 preguntas ordenadas el criterio especificado mediante el parámetro `:sort`, que puede ser `latest` (ordena por fecha de creación, de más a menos reciente, valor por defecto en caso de no incluirse el parámetro `:sort`), `pending_first` (ordena priorizando las que no estén resueltas por sobre las que sí lo están, y luego por fecha de creación de más a menos recientes), `needing_help` (sólo se incluyen las preguntas que no estén resueltas, y las ordena por cantidad de respuestas de forma ascendente). Para cada pregunta se debe retornar el título, la descripción acortada a 120 caracteres (de exceder esa cantidad de caracteres, rellenar con elipsis: `...`), la cantidad de respuestas que tiene y si está resuelta o no. | No |
| `GET /questions/:id` | Retorna toda la información que se tiene de la pregunta identificada por el `id` recibido en el parámetro `:id`. Opcionalmente puede solicitarse que en la respuesta a esta petición se incluyan las respuestas (modelo `Answer`) a la pregunta, utilizando un _Compound document_. | No |

La estructura visible de los modelos debe ser, mínimamente, la siguiente:

* `User`
  * `username` (no puede repetirse)
  * `password` (debe almacenarse hasheada, no puede ser almacenada en plano)
  * `screen_name`
  * `email` (no puede repetirse)
  * `score` (reputación dentro de la aplicación, valor numérico que se incrementa al preguntar y responder)
  * `created_at`
  * `updated_at`
* `Question`
  * `title`
  * `description`
  * `status` (si está resuelta o no)
  * `user_id` (referencia a quién publicó la pregunta)
  * `answer_id` (referencia a la respuesta que se marcó como correcta, en caso de estar resuelta)
  * `created_at`
  * `updated_at`
* `Answer`
  * `question_id` (referencia a la pregunta que intenta responder)
  * `content`
  * `user_id` (referencia a quién publicó la respuesta)
  * `created_at`
  * `updated_at`

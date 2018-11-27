# TTPS Opción Ruby 2018
## Trabajo Práctico Integrador

Te contactaron para implementar el conjunto de servicios backend que alimentan una aplicación de preguntas y respuestas estilo foro y de muy buena gana aceptaste el desafío. Como sos un hábil desarrollador en Ruby on Rails, decidiste implementar la API utilizando ese framework, creando una aplicación nueva en [modo API](https://guides.rubyonrails.org/api_app.html).

La aplicación pública (frontend) ya se encuentra desarrollada, por lo que el formato y la estructura de las respuestas que implementes para los servicios que se te solicitan deberán adecuarse a las respuestas esperadas por el frontend.

Como primer requisito, se te solicita que los servicios deben seguir el estándar [JSON:API](https://jsonapi.org/) aunque no deben hacierlo estrictamente en todo sentido, sino que sólo deben respetar las generalidades de estructura de las respuestas, tipo(s) MIME y los documentos compuestos (_Compound documents_).

El segundo requisito que tenés es que todas las peticiones deben ser autenticadas mediante el uso tokens temporales para evitar que un usuario realice peticiones en nombre de otro. Para esto, el token obtenido mediante el servicio de inicio de sesión (`login`, más adelante detallado) debe enviarse en todas las peticiones subsiguientes en la cabecera `X-QA-Key` de las mismas. De esta manera, toda petición recibida que requiera que el usuario se encuentre identificado obtendrá qué usuario está realizando la petición mediante el token recibido por la cabecera.

El tercero es que la persistencia la realices en alguna base de datos relacional (`MySQL` o `PostgreSQL` van a estar bien).

Luego, se te pide que realices tests de unidad de todos los modelos que implementes para cubrir las funcionalidades más importantes. Al menos debés tener implementados 10 tests **no triviales**.

Los servicios que tenés que implementar son los siguientes:

| Endpoint | Descripción | ¿Requiere token? |
| -------- | ----------- | ---------------- |
| `POST /users` | Crea un nuevo usuario con los datos provistos en la petición. Los atributos que se reciben son los correspondientes al modelo `User`. | No |
| `POST /sessions` | Inicia sesión con un usuario, cuyos nombre de usuario y clave se reciben en el cuerpo de la petición en los parámetros `username` y `password`. De ser correctos el nombre de usuario y contraseña, se debe generar un token temporal para el usuario y retornarlo, junto con los datos del usuario autenticado, en un atributo `token` para que el frontend lo guarde y lo utilice en las peticiones a servicios que requieran dicho token. La validez del token es de 30 minutos, pasados los cuales se deberá volver a identificar el usuario (mediante este mismo servicio) para así generarle un nuevo token. | No |
| `GET /questions/:sort` | Retorna un listado de las últimas 50 preguntas ordenadas el criterio especificado mediante el parámetro `:sort`, que puede ser `latest` (ordena por fecha de creación, de más a menos reciente, valor por defecto en caso de no incluirse el parámetro `:sort`), `pending_first` (ordena priorizando las que no estén resueltas por sobre las que sí lo están, y luego por fecha de creación de más a menos recientes), `needing_help` (sólo se incluyen las preguntas que no estén resueltas, y las ordena por cantidad de respuestas de forma ascendente). Para cada pregunta se debe retornar el título, la descripción acortada a 120 caracteres (de exceder esa cantidad de caracteres, rellenar con elipsis: `...`), la cantidad de respuestas que tiene y si está resuelta o no. | No |
| `GET /questions/:id` | Retorna toda la información que se tiene de la pregunta identificada por el `id` recibido en el parámetro `:id`. Opcionalmente puede solicitarse que en la respuesta a esta petición se incluyan las respuestas (modelo `Answer`) a la pregunta, utilizando un _Compound document_. | No |
| `POST /questions` | Crea una nueva pregunta con los atributos que se reciban en la petición (título y descripción). Al crearla, se registra que el usuario que realiza la petición (identificado por su token) es el que publicó la pregunta. | Sí |
| `PUT /questions/:id` | Actualiza la pregunta existente identificada por el `id` recibido en el parámetro `:id`. Este endpoint permite cambiar el título o la descripción de la pregunta. Sólo debe permitirse realizar las modificaciones si el usuario que se identifica mediante el token de la petición es el que publicó la pregunta. | Sí |
| `DELETE /questions/:id` | Borra la pregunta existente identificada por el parámetro `:id`. No se debe permitir el borrado si la pregunta tiene al menos una respuesta, o si la petición no es realizada por el usuario que publicó la pregunta. | Sí |
| `PUT /questions/:id/resolve` | Marca la pregunta identificada por `:id` como resuelta, marcando la respuesta identificada por el parámetro `:answer_id` como respuesta correcta. Se debe validar que la respuesta esté asociada a la pregunta, y que el usuario que realiza la petición sea el que publicó la pregunta. | Sí |
| `GET /questions/:question_id/answers` | Retorna todas las respuestas para la pregunta identificada por el `id` recibido en el parámetro `:question_id`. | No |
| `POST /questions/:question_id/answers` | Crea una nueva respuesta asociada a la pregunta identificada por el parámetro `:question_id` con el parámetro `content` recibido en la petición. Al crearla, se registra que el usuario que realiza la petición (identificado por su token) es el que publicó la respuesta. Si la pregunta está resuelta, no se debe admitir la creación de más respuestas, retornando un código HTTP `422 Unprocessable entity`. | Sí |
| `DELETE /questions/:question_id/answers/:id` | Borra la respuesta existente, identificada por el parámetro `:id` y asociada a la pregunta identificada por el parámetro `:question_id`. No se debe permitir el borrado si la respuesta está marcada como respuesta correcta de la pregunta, o si la petición no es realizada por el usuario que publicó la respuesta. | Sí |

La estructura visible de los modelos básicos debe ser, mínimamente, la siguiente:

* `User`
  * `username` (no puede repetirse)
  * `password` (debe almacenarse hasheada, no puede ser almacenada en plano)
  * `screen_name`
  * `email` (no puede repetirse)
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

- - -

Para la primera entrega será opcional la subida del proyecto al PaaS [Heroku](https://heroku.com), pero esto será obligatorio para quienes deban presentarse a la reentrega del TPI. A tal fin, se podrá utilizar el _tier_ gratuito de esa plataforma (detallado en [su página de precios](https://www.heroku.com/pricing)).

La entrega deberá realizarse **de manera individual** mediante el curso de la materia en [la plataforma de Cátedras](https://catedras.info.unlp.edu.ar/), en una tarea destinada a tal fin, y se hará incluyendo la URL de un repositorio git disponible on-line y, en caso de haberse desplegado la API en Heroku, el link a la dirección pública de la aplicación Rails corriendo en Heroku. En el repositorio se deberá incluir todo el código fuente necesario para el correcto funcionamiento de la aplicación Rails desarrollada, entre los que deberá estar presente un archivo `README` con indicaciones claras sobre cómo se puede poner en funcionamiento la aplicación, inicializar la base de datos de ser necesario, etc.


> _Tener en cuenta que el repositorio debe poder se accedido por cualquiera de los docentes de la cátedra._


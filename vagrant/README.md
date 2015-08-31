# VM con Ruby 2.2.3

Este directorio contiene un archivo de configuración de [Vagrant](https://www.vagrantup.com) que genera una máquina
virtual con Ruby 2.2.3 instalado para facilitar la realización de los ejercicios de las prácticas.

## Prerequisitos

Se debe tener Vagrant instalado en la máquina donde se va a crear la VM.

## Uso

Para crear la máquina virtual o iniciarla, basta con situarse en este directorio y ejecutar el siguiente comando:

```console
$ vagrant up
```

Una vez hecho esto, para poder usar la VM deben ingresar a la misma ejecutando el comando

```console
$ vagrant ssh
```

Una vez finalizado el uso de la VM, se la puede apagar para que no ocupe recursos mediante el comando

```console
$ vagrant halt
```

(Recordar que la próxima vez se deberá ejecutar nuevamente `vagrant up` antes de hacer `vagrant ssh`)

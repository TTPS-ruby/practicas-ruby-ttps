# VM con Ruby 2.5.1

Este directorio contiene un archivo de configuración de [Vagrant](https://www.vagrantup.com) que genera una máquina
virtual con Ruby 2.5.1 instalado para facilitar la realización de los ejercicios de las prácticas.

> Nota: la versión de la imagen base utilizada de Ubuntu requiere utilizar Vagrant 2.1 o superior para funcionar.

## Prerequisitos

Se deben tener instalados [Vagrant](https://vagrantup.com) y [Virtualbox](https://virtualbox.org) instalados en la
máquina donde se va a crear la VM. Virtualbox es el software utilizado para correr las máquinas virtuales, mientras
que Vagrant es el encargado de preparar las VMs según el manifesto de configuración `Vagrantfile` (incluido en el
mismo directorio que este archivo `README`).

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

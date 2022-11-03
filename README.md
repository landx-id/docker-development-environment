# Docker for Development Environment

Vagrant is awesome, as isolated Development Environment. Unfortunately, we cannot use Vagrant in MacOs for severtal reason. Therefore, we use this Docker configuration as `Vagrant Replacement`. The Docker Image is based on Ubuntu Jammy (22.04.1 LTS).

Using this configuration, we finally have isolated environment for Development. We use it as *stateful* environment, means we rarely destroy any data inside the container.

## Usage

Clone this repository

```bash
~$ git@github.com:landx-id/docker-development-environment.git
```

Login to container

```bash
~$ make cli
```

If you want to install something inside container, then you should login as root

```bash
~$ docker exec -it dev-env /bin/bash
```

### Working with NodeJS

NodeJS can be installed with NVM 

```bash
~$ nvm install 16.14.1
~$ nvm use 16.14.1
~$ node --version
v16.14.1
```

### Working with Python

Python 3.9 will be installed during Docker Build.

```bash
~$ python3 --version
Python 3.9.15
```

### Working with Projects

If you want to work with your project, we recommend to place it in `projects` folder. This folder is mounted directly in the container, so you can work using your favorite IDE in your computer host.

## Troubleshooting


### Cannot login to container

Sometimes, there is a glitch that makes login to container fail when you execute `make cli`. If it happens, just retry to execute the command until you finally success to login into the container.
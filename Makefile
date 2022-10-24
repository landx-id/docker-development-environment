COMPOSE_PROJECT_NAME := dev-env
USERNAME := $(shell whoami)
USERID := $(shell id -u)
SERVICES := $(shell docker-compose ps --services)
RUNNING_SERVICES := $(shell docker-compose ps --services --filter "status=running")
USER_PWD := $(shell pwd)

export COMPOSE_PROJECT_NAME
export USERNAME 
export USERID
export SERVICES
export RUNNING_SERVICES
export USER_PWD

define waitport
	while ! nc -z localhost $(1); do sleep 0.2; done;
endef

define startcompose
	if [ -z  "$(RUNNING_SERVICES)" ] || [ "$(SERVICES)" = "$(RUNNING_SERVICES)" ]; then \
		docker-compose up --build -d; \
	fi
endef

# init docker compose
init:
	docker-compose up --build -d

# stop docker container
down:
	docker-compose down

# shell into docker container as user
cli:
	@$(call startcompose)
	@chmod u=rw,g=,o= docker/id_rsa
	@$(call waitport, 22222)
	@ssh \
		-A \
		-o StrictHostKeyChecking=no \
		-o UserKnownHostsFile=/dev/null \
		-tv \
		-p 22222 \
		-i docker/id_rsa \
		$(USERNAME)@localhost
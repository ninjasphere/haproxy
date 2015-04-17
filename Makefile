PROJECT ?= haproxy

SHA1 := $(shell git rev-parse --short HEAD | tr -d "\n")

all: build

build:
	docker ${DOCKER_ARGS} build -t "ninjablocks/${PROJECT}:${SHA1}" .

push:
	docker push "ninjablocks/${PROJECT}:${SHA1}"

local:
	docker run -t -i --rm -p 80:80 -p 443:443 -t "ninjablocks/${PROJECT}:${SHA1}"

.PHONY: all build local

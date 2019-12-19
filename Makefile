.PHONY: build package deploy-%

export APP_NAME := node-example
export COMMIT := $(shell git rev-parse --short HEAD)
export DOCKER_IMAGE = localhost:5000/$(APP_NAME)
export PROJECT := internal

build:
	@docker-compose run --rm jsbuilder ./scripts/build.sh

package:
	@./scripts/build_image.sh
	@./scripts/push_image.sh


deploy-%: env := staging

deploy-%:
	@ENVIRONMENT=$(env) ./scripts/deploy.sh

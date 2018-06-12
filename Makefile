.PHONY: build package deploy-%

export APP_NAME := skeleton-node-express
export AWS_ACCOUNT_PREFIX := common
export AWS_DEFAULT_REGION := ap-southeast-2
export COMMIT := $(shell git rev-parse --short HEAD)
export DOCKER_IMAGE = 106251776774.dkr.ecr.ap-southeast-2.amazonaws.com/$(APP_NAME):$(COMMIT)
export OWNER := delivery_engineering@blockchaintech.net.au
export PROJECT := internal

ecr-login:
	@eval `aws ecr get-login --no-include-email`


build: ecr-login
	@docker-compose run --rm jsbuilder ./scripts/build.sh

package:
	@./scripts/build_image.sh
	@./scripts/push_image.sh

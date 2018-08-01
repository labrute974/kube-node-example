.PHONY: build package deploy-%

export APP_NAME := skeleton-express
export AWS_ACCOUNT_PREFIX := sandbox
export AWS_DEFAULT_REGION := ap-southeast-2
export COMMIT := $(shell git rev-parse --short HEAD)
export DOCKER_IMAGE = 106251776774.dkr.ecr.ap-southeast-2.amazonaws.com/$(APP_NAME)
export OWNER := delivery_engineering@blockchaintech.net.au
export PROJECT := internal

ecr-login:
	@eval `aws ecr get-login --no-include-email`


build: ecr-login
	@docker-compose run --rm jsbuilder ./scripts/build.sh

package:
	@./scripts/download_artifact.sh target/app.tgz
	@./scripts/build_image.sh
	@./scripts/push_image.sh


%-testing: env := testing

deploy-background-%: project := background

deploy-%: ecr-login
	@ENVIRONMENT=$(env) PROJECT=$(project) ./scripts/deploy.sh

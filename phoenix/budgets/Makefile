# vim: filetype=make
.PHONY: help

APP_NAME ?= `grep 'app:' mix.exs | sed -e 's/\[//g' -e 's/ //g' -e 's/app://' -e 's/[:,]//g'`
APP_VSN ?= `grep 'version:' mix.exs | cut -d '"' -f2`
BUILD ?= `git rev-parse --short HEAD`
PROJECT-ID ?= "jackson-budget-1519498484201"

help:
	@echo "$(APP_NAME):$(APP_VSN)-$(BUILD)"
	@perl -nle'print $& if m{^[a-zA-Z_-]+:.*?## .*$$}' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'


build: ## Build the Docker image
	docker build --build-arg APP_NAME=$(APP_NAME) \
	--build-arg APP_VSN=$(APP_VSN) \
	-t $(APP_NAME):$(APP_VSN)-$(BUILD) \
	-t $(APP_NAME):latest .

run: ## Run the app in Docker
	docker run \
	--env PORT=8080 \
	--env SECRET_KEY_BASE="" \
	-p 8080:8080 \
	--rm -it $(APP_NAME):latest

publish: ## Send the docker image to gcloud
	docker tag ${APP_NAME}:latest gcr.io/${PROJECT-ID}/${APP_NAME}
	docker push gcr.io/${PROJECT-ID}/${APP_NAME}

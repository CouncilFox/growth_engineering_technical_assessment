# you are *not* required to use make - a task runner may be helpful and is left
# as an exercise to the reader.

help: ## Show this help.
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

.PHONY: help deploy teardown

deploy: ## Build, push, and deploy the application to K8s
	docker build -t ttl.sh/growth-engineering:2h ./app
	docker push ttl.sh/growth-engineering:2h
	kubectl apply -f ./app/manifest.yaml

teardown: ## Remove the deployed application from K8s
	kubectl delete -f ./app/manifest.yaml
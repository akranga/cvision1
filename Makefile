.DEFAULT_GOAL := deploy

DOCKER     := docker
SKAFFOLD   := skaffold

export SKAFFOLD_PROFILE   ?= incluster

export HUB_APP_NAME ?= opencvapp

clean: gen-delete
	@rm -rf $(VIRTUALENV) __pycache__

skaffold-%: 
	$(SKAFFOLD) $(lastword $(subst -, ,$@))

skaffold-delete: gen-delete

skaffold: gen skaffold-dev

gen-% src-%:
	$(MAKE) -C "$(firstword $(subst -, ,$@))" $(lastword $(subst -, ,$@))

gen: gen-apply

deploy: gen skaffold-run

.PHONY: clean deploy

.DEFAULT_GOAL := deploy

DOCKER     := docker
SKAFFOLD   := skaffold

export SKAFFOLD_PROFILE ?= incluster
export HUB_APP_NAME     ?= opencvapp

clean: gen-delete
	@rm -rf $(VIRTUALENV) __pycache__

skaffold-%: 
	$(SKAFFOLD) $(lastword $(subst -, ,$@))

skaffold: gen skaffold-dev

skaffold-delete: gen-delete

gen-% src-% hub-%:
	$(MAKE) -C "$(firstword $(subst -, ,$@))" $(lastword $(subst -, ,$@))

gen: gen-apply
hub: hub-deploy
deploy: gen skaffold-run

.PHONY: clean deploy

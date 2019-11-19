.DEFAULT_GOAL := gen skaffold-run

DOCKER     := docker
SKAFFOLD   := skaffold

export SKAFFOLD_PROFILE   ?= incluster
export SKAFFOLD_NAMESPACE ?= default

export HUB_APP_NAME ?= opencvapp

clean: gen-delete
	@rm -rf $(VIRTUALENV) __pycache__

skaffold-%: 
	$(SKAFFOLD) -p $(SKAFFOLD_PROFILE) $(lastword $(subst -, ,$@))

skaffold: gen skaffold-dev

gen-% src-%:
	$(MAKE) -C "$(firstword $(subst -, ,$@))" $(lastword $(subst -, ,$@))

gen: gen-apply

.PHONY: clean install lint pytest run gen

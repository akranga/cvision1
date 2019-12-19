.DEFAULT_GOAL := deploy

DOCKER     := docker
SKAFFOLD   := skaffold

export SKAFFOLD_PROFILE ?= incluster
export HUB_APP_NAME     ?= opencvapp

skaffold-%: 
	$(SKAFFOLD) $(lastword $(subst -, ,$@))

skaffold: gen skaffold-dev

src-% .hub-%:
	$(eval dir    := $(firstword $(subst -, ,$@)))
	$(eval target := $(word 2,$(subst -, ,$@)))
	$(MAKE) -C "$(dir)" $(target)

clean: .hub-clean src-clean
reconfigure generate: .hub-generate
dev: generate skaffold-dev
run deploy: generate skaffold-run
delete undeploy: skaffold-delete

.PHONY: clean generate hub dev run

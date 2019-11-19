.DEFAULT_GOAL := apply

aws     := aws
kubectl := kubectl

export AWS_ACCOUNT_ID ?= $(shell $(aws) sts get-caller-identity --query 'Account' --output text)

JSONNET_ARGS += -V AWS_ACCOUNT_ID
JSONNET_ARGS += $(shell awk 'BEGIN{for(v in ENVIRON) print "-V " v}' | grep " HUB_" | xargs)
jsonnet := jsonnet $(JSONNET_ARGS)

JSONNET := $(wildcard *.jsonnet)

define render_apply
	$(jsonnet) $(2) | $(kubectl) $(1) -f -;
endef

apply: $(JSONNET)
	$(foreach file,$^,$(call render_apply,$@,$(file)))

delete: $(JSONNET)
	$(foreach file,$^,$(call render_apply_noerror,$@,$(file)))

.PHONY: apply delete

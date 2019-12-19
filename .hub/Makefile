.DEFAULT_GOAL := generate

aws     := aws
kubectl := kubectl
yq      := yq
curl    := curl -sL

JSONNET_ARGS        += -V AWS_ACCOUNT_ID=$(shell $(aws) sts get-caller-identity --query 'Account' --output text)
JSONNET_ARGS        += $(shell awk 'BEGIN{for(v in ENVIRON) print "-V " v}' | grep " HUB_" | xargs)
JSONNET_ARGS        += -V KUBECONFIG
jsonnet             := jsonnet $(JSONNET_ARGS)

APP_DIR             := $(abspath $(CURDIR)/..)
TEMPLATES_DIR       := $(CURDIR)/templates
LIBSONNET_DIR       := $(CURDIR)/libs
LIBSONNET           := $(LIBSONNET_DIR)/k8s.libsonnet $(LIBSONNET_DIR)/dockerconfig.libsonnet
LIBSONNET_REMOTE    := https://raw.githubusercontent.com/agilestacks/jsonnet/master
YAML_MANIFESTS      := $(addprefix $(APP_DIR)/,$(addsuffix .yaml,$(basename $(wildcard *.jsonnet) $(wildcard **/*.jsonnet))))
JSON_MANIFESTS      := $(addprefix $(APP_DIR)/,$(addsuffix .json,$(basename $(wildcard .vscode/*.jsonnet))))
TEMPLATES           := $(addsuffix .json,$(basename $(wildcard $(TEMPLATES_DIR)/*.yaml)))

export JSONNET_PATH := $(TEMPLATES_DIR):$(LIBSONNET_DIR):$(APP_DIR)
export KUBECONFIG   ?= $(APP_DIR)/.kubeconfig

$(TEMPLATES):
	@ mkdir -p "$(dir $@)" 
	$(yq) r $(basename $@).yaml -j > $@

$(LIBSONNET):
	@ mkdir -p "$(dir $@)"
	$(curl) -o $@ $(LIBSONNET_REMOTE)/lib/$(notdir $@)

$(YAML_MANIFESTS): $(LIBSONNET) $(TEMPLATES)
	@ mkdir -p "$(dir $@)"
	$(jsonnet) $(CURDIR)/$(basename $(@:$(APP_DIR)/%=%)).jsonnet | $(yq) r - > $@

$(JSON_MANIFESTS):
	@ mkdir -p "$(dir $@)"
	$(jsonnet) $(CURDIR)/$(basename $(@:$(APP_DIR)/%=%)).jsonnet > $@

generate: $(YAML_MANIFESTS) $(JSON_MANIFESTS)

libs: $(LIBSONNET)

clean:
	rm -rf $(YAML_MANIFESTS) $(JSON_MANIFESTS) $(LIBSONNET) $(TEMPLATES) 

.PHONY: generate clean libs

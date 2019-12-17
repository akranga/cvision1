.DEFAULT_GOAL := all

aws     := aws
kubectl := kubectl
yq      := yq
curl    := curl -sL

JSONNET_ARGS += -V AWS_ACCOUNT_ID=$(shell $(aws) sts get-caller-identity --query 'Account' --output text)
JSONNET_ARGS += $(shell awk 'BEGIN{for(v in ENVIRON) print "-V " v}' | grep " HUB_" | xargs)
jsonnet := jsonnet $(JSONNET_ARGS)

LIBSONNET_REMOTE := https://raw.githubusercontent.com/agilestacks/jsonnet/master
LIBSONNET  := lib/k8s.libsonnet lib/dockerconfig.libsonnet
MANIFESTS  := $(addsuffix .yaml,$(basename $(wildcard *.jsonnet)))

$(LIBSONNET):
	mkdir -p "$(dir $@)"
	$(curl) -o $@ $(LIBSONNET_REMOTE)/$@

$(MANIFESTS): $(LIBSONNET)
	$(jsonnet) $(basename $@).jsonnet | $(yq) r - > $@

all: $(MANIFESTS)

clean:
	rm -rf $(MANIFESTS) $(LIBSONNET)

.PHONY: generate clean

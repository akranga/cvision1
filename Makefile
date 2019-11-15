.DEFAULT_GOAL := run

VIRTUALENV := .venv
PYTHON     := python3
PIP        := $(VIRTUALENV)/bin/activate; pip3
PYLINT     := $(VIRTUALENV)/bin/activate; pylint
PYTEST     := $(VIRTUALENV)/bin/activate; pytest
FLASK      := $(VIRTUALENV)/bin/activate; cd src && flask
DOCKER     := docker
SKAFFOLD   := skaffold

IMAGE      ?= agilestacks/opencvapp

$(VIRTUALENV):
	$(PYTHON) -m venv $(abspath $@)

install: $(VIRTUALENV)
	$(PIP) install -r requirements.txt

lint: $(VIRTUALENV)
	$(PYLINT) api

pytest: $(VIRTUALENV)
	$(PYTEST) --junitxml=junit.xml

flask: $(VIRTUALENV)
	$(FLASK) run --port=5000

clean: templates-clean
	@rm -rf $(VIRTUALENV) __pycache__

image:
	$(DOCKER) build -t $(IMAGE) $(CURDIR)

docker:
	test -e /dev/video0 \
	&& $(DOCKER) run --rm -it --device /dev/video0 -p 5000:5000 $(IMAGE) \
	|| $(DOCKER) run --rm -it -p 80:80 $(IMAGE)

gen-%:
	$(eval dir    := $(firstword $(subst -, ,$@)))
	$(eval target := $(lastword $(subst -, ,$@)))
	$(MAKE) -C $(dir) $(target)

skaffold-%: 
	$(SKAFFOLD) -p incluster $(lastword $(subst -, ,$@))

skaffold-run:
skaffold-dev: manifests
skaffold: skaffold-dev

manifests: gen-apply

.PHONY: clean install lint pytest run manifests

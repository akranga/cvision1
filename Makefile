.DEFAULT_GOAL := run

VIRTUALENV := .venv
PYTHON     := python3
PIP        := $(VIRTUALENV)/bin/activate; pip3
PYLINT     := $(VIRTUALENV)/bin/activate; pylint
PYTEST     := $(VIRTUALENV)/bin/activate; pytest
FLASK      := $(VIRTUALENV)/bin/activate; flask
DOCKER     := docker
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
	$(FLASK) run --port=80

clean:
	@rm -rf $(VIRTUALENV) __pycache__

image:
	$(DOCKER) build -t $(IMAGE) $(CURDIR)

docker:
	test -e /dev/video0 \
	&& $(DOCKER) run --rm -it --device /dev/video0 -p 5000:5000 $(IMAGE) \
	|| $(DOCKER) run --rm -it -p 5000:5000 $(IMAGE)


PHONY: clean install lint pytest run

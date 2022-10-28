DOCKER_IMAGE ?= jlrgraham/ha-shellies-discovery-gen2
DOCKER_TAG ?= latest

DOCKER_NAME := $(DOCKER_IMAGE):$(DOCKER_TAG)

build:
	docker build --tag $(DOCKER_NAME) .

push:
	docker push $(DOCKER_NAME)

run:
	docker run \
		-it \
		--rm \
		-e LOG_LEVEL=DEBUG \
		-e MQTT_BROKER \
		-e MQTT_USERNAME \
		-e MQTT_PASSWORD \
		-e HA_DISCOVERY_PREFIX \
		$(DOCKER_NAME)

black:
	docker run \
		-it \
		--rm \
		-v ${PWD}:/app \
		--workdir /app \
		python:3 \
		bash -c "pip install black && black run.py"

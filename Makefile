MAKEFLAGS += silent

SHELL = /bin/bash

.DEFAULT_GOAL := build
.PHONY: all stretch buster bullseye

stretch:
	DOCKER_BUILDKIT=1 \
	docker build \
		--build-arg DEBIAN_VERSION=9 \
		--build-arg BUILD_DATE=$(date -u +'%Y-%m-%dT%H:%M:%SZ') \
		-t tatsuryu/debian-systemd-molecule:9 .
	docker tag tatsuryu/debian-systemd-molecule:9 \
		tatsuryu/debian-systemd-molecule:stretch

buster:
	DOCKER_BUILDKIT=1 \
	docker build \
		--build-arg DEBIAN_VERSION=10 \
		--build-arg BUILD_DATE=$(date -u +'%Y-%m-%dT%H:%M:%SZ') \
		-t tatsuryu/debian-systemd-molecule:10 .
	docker tag tatsuryu/debian-systemd-molecule:10 \
		tatsuryu/debian-systemd-molecule:buster

bullseye:
	DOCKER_BUILDKIT=1 \
	docker build \
		--build-arg DEBIAN_VERSION=11 \
		--build-arg BUILD_DATE=$(date -u +'%Y-%m-%dT%H:%M:%SZ') \
		-t tatsuryu/debian-systemd-molecule:11 .
	docker tag tatsuryu/debian-systemd-molecule:11 \
		tatsuryu/debian-systemd-molecule:buster

.PHONY: push-stretch push-buster push-bullseye
push-stretch:
	docker push tatsuryu/debian-systemd-molecule:9
	docker push tatsuryu/debian-systemd-molecule:stretch

push-buster:
	docker push tatsuryu/debian-systemd-molecule:10
	docker push tatsuryu/debian-systemd-molecule:buster

push-bullseye:
	docker push tatsuryu/debian-systemd-molecule:11
	docker push tatsuryu/debian-systemd-molecule:bullseye

all: stretch buster bullseye push-stretch push-buster push-bullseye
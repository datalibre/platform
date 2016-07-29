SHELL := /bin/bash

all: build db run

run: build
	docker-compose up

build: .built

.built:
	docker-compose build
	touch .built

stop:
	docker-compose stop

restart: build
	docker-compose restart web

clean: stop
	docker-compose rm -f
	rm -f .built

logs:
	docker-compose logs

migrate: build
	docker-compose run web /usr/local/bin/python manage.py migrate

.PHONY: all run build stop restart mac-open clean test logs db production-build
up:
	docker-compose up -d

build:
	docker-compose up -d --build

down:
	docker-compose down

remove: 
	docker-compose down -v

dev:
	docker-compose -f ./docker-compose-development.yml up -d --build
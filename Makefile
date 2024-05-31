start:
	docker-compose up

start-d:
	docker-compose up -d

stop:
	docker-compose stop

down:
	docker-compose down

restart:
	docker-compose down
	docker-compose build
	docker-compose up

console:
	docker-compose exec web bundle exec rails c

init:
	docker-compose down
	docker-compose build
	docker-compose up -d
	docker-compose exec web bundle exec rails db:create
	docker-compose exec web bundle exec rails db:migrate
	docker-compose exec web bundle exec rails db:seed
	docker-compose stop
reset:
	docker-compose up -d
	docker-compose exec web bundle exec rails db:migrate:reset
	docker-compose exec web bundle exec rails db:seed

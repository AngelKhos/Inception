NAME = inception
DOCKER_COMPOSE_FILE = ./srcs/docker-compose.yml
DATA_PATH = /home/$(USER)/data

all: up

prepare:
	mkdir -p $(DATA_PATH)/wordpress
	mkdir -p $(DATA_PATH)/mariadb

up: prepare
	docker compose -f $(DOCKER_COMPOSE_FILE) up -d --build

down:
	docker compose -f $(DOCKER_COMPOSE_FILE) down

clean: down
	docker system prune -a --force

fclean: clean
	sudo rm -rf $(DATA_PATH)/wordpress
	sudo rm -rf $(DATA_PATH)/mariadb
	docker volume rm $$(docker volume ls -q) 2>/dev/null || true

re: fclean all

.PHONY: all prepare up down clean fclean re
.SILENT:
name = inception
all: configure_volumes
	@docker-compose -f ./srcs/docker-compose.yml up -d --build

build:
	@bash srcs/requirements/wordpress/tools/make_dir.sh
	@docker-compose -f ./srcs/docker-compose.yml up -d --build

down:
	@docker-compose -f ./srcs/docker-compose.yml down -v

re:
	@docker-compose -f ./srcs/docker-compose.yml up -d --build

clean:
	@docker kill $(docker ps -q) 2> /dev/null || true
	@docker rm $(docker ps -aq) 2> /dev/null || true

fclean: clean 
	@docker system prune -a

configure_volumes:
	@mkdir -p /home/armartir/data/wp_volume
	@mkdir -p /home/armartir/data/db_volume
	@mkdir -p /home/armartir/data/portainer_volume

.PHONY	: all build down re clean fclean volume_rm configure_volumes


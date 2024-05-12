all	:
	@ clear
	@ mkdir -p /home/absela/data
	@ mkdir -p /home/absela/data/vol_wordpress
	@ mkdir -p /home/absela/data/vol_mariadb
	@ docker-compose -f ./srcs/docker-compose.yml up -d
up :
	@ docker-compose -f ./srcs/docker-compose.yml up -d
down:
	@ docker-compose -f ./srcs/docker-compose.yml down

clean:down
	@clear
	@rm -rf /home/absela/data
	@docker rmi $(shell docker images -q)
	# @docker volume rm v_wordpress v_mariadb
	@docker volume rm $(shell docker volume ls -q)
	@docker system prune -fa
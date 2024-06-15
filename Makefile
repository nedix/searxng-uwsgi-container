up:
	@docker run --rm -p 1234:1234 --name searx -d searx

down:
	@-docker stop searx
	@-docker stop searx-test

shell:
	@docker exec searx

setup:
	@-make down
	@docker build . -t searx --progress plain

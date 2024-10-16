up:
	@docker run --rm -p 8080:80 --name searxng -d searxng

down:
	@-docker stop searx
	@-docker stop searx-test

shell:
	@docker exec searx

setup:
	@-make down
	@docker build . -t searx --progress plain

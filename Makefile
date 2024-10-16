setup:
	@-make down
	@docker build --progress plain -f Containerfile -t searxng .

up: PORT = 8080
up:
	@docker run --rm -p $(PORT):80 --name searxng -d searxng

down:
	@-docker stop searxng
	@-docker stop searxng-test

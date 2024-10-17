setup:
	@docker build --progress plain -f Containerfile -t searxng .

up: PORT = 8080
up:
	@docker run --rm -p $(PORT):80 --name searxng -d searxng

down:
	@-docker rm -fv searxng
	@-docker rm -fv searxng-test

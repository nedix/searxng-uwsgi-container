setup:
	@-make down
	@docker build --progress plain -f Containerfile -t searxng .

up:
	@docker run --rm -p 8080:80 --name searxng -d searxng

down:
	@-docker stop searxng
	@-docker stop searxng-test

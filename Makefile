setup:
	@make down
	@docker build . -t searx

up:
	@docker run --rm -p 1234:1234 --name searx -d searx

down:
	@-docker stop searx
	@-docker stop searx-test

test-setup:
	@make setup
	@docker build . -t searx-test --build-arg TARGET=testing
	@-docker network create searx-test

test: spec =
test:
	@make test-setup
	@docker run --rm -p 1234:1234 --net searx-test --name searx -d searx
	@docker run --rm --net searx-test --name searx-test searx-test run $(if ${spec},"--spec=${spec}",)

test-update:
	@make test-setup
	@docker run --rm -p 1234:1234 --net searx-test --name searx -d searx
	@docker run --rm --net searx-test --name searx-test -v ${CURDIR}/tests/e2e/snapshots/:/tests/e2e/snapshots searx-test run --env updateSnapshots=true

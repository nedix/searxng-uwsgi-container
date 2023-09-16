up:
	@docker run --rm -p 1234:1234 --name searx -d searx

down:
	@-docker stop searx
	@-docker stop searx-test

setup:
	@make down
	@docker build . -t searx --target app

test: spec =
test:
	@make test-setup
	@docker run --rm --net searx-test --name searx -d searx
	@-docker run --rm --net searx-test --name searx-test -v ${CURDIR}/tests/e2e/artifacts/:/tests/e2e/artifacts/ searx-test run $(if ${spec},"--spec=integration/${spec}",)
	@make down

test-native:
	@make test-setup
	@docker run --rm -p 1234:1234 --net searx-test --name searx -d searx
	@CYPRESS_BASE_URL=http://localhost:1234 npm exec cypress -- open --config-file tests/e2e/cypress.config.js

test-shell:
	@make test-setup
	@docker run --rm --net searx-test --name searx -d searx
	@docker run --rm -it --net searx-test --entrypoint /bin/sh -v ${CURDIR}/tests/e2e/:/tests/e2e/ searx-test

test-setup:
	@make setup
	@docker build . -t searx-test --target cypress
	@docker network rm searx-test
	@-docker network create searx-test

test-update:
	@make test-setup
	@docker run --rm --net searx-test --name searx -d searx
	@-docker run --rm --net searx-test --name searx-test -v ${CURDIR}/tests/e2e/snapshots/:/tests/e2e/snapshots searx-test run --env updateSnapshots=true
	@make down

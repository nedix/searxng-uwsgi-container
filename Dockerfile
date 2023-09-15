ARG TARGET=app

ARG PYTHON_VERSION=3.10
ARG CYPRESS_VERSION=13.2.0

FROM python:${PYTHON_VERSION}-alpine3.17 as target_app

ARG SEARXNG_REPO=https://github.com/searxng/searxng.git
ARG SEARXNG_VERSION=f182abd6f8f1eac20d19c3e4b4c9800115f2a705
ARG SEARXNG_PATH=/usr/local/searxng

RUN apk add --virtual .build-deps \
        build-base \
    && apk add \
        git \
        uwsgi-python3 \
    && git clone "$SEARXNG_REPO" "$SEARXNG_PATH" \
    && cd "$SEARXNG_PATH" \
    && git checkout "$SEARXNG_VERSION" \
    && pip install --upgrade pip \
    && pip install --no-cache -r requirements.txt

ARG ADVANCED_THEME_REPO=https://github.com/SatoshiGuacamole/searxng-advanced-theme.git
ARG ADVANCED_THEME_VERSION=0.1.3
ARG ADVANCED_THEME_PATH=${SEARXNG_PATH}/searx/templates/advanced

RUN git clone "$ADVANCED_THEME_REPO" "$ADVANCED_THEME_PATH" \
    && cd "$ADVANCED_THEME_PATH" \
    && git checkout "$ADVANCED_THEME_VERSION" \
    && rm -rf \
        "${ADVANCED_THEME_PATH}/.git" \
    && apk del .build-deps

ADD rootfs /

RUN chown -R nobody \
        "$SEARXNG_PATH" \
        /var/log/uwsgi/ \
    && chmod +x /entrypoint.sh

USER nobody

EXPOSE 1234

ENTRYPOINT ["/entrypoint.sh"]

FROM cypress/included:${CYPRESS_VERSION} as target_testing

RUN npm install -g \
        @simonsmith/cypress-image-snapshot

COPY tests/e2e /tests/e2e

WORKDIR /tests/e2e

RUN npm link \
        @simonsmith/cypress-image-snapshot

ENV CYPRESS_BASE_URL=http://searx:1234

ENTRYPOINT ["cypress"]

FROM target_${TARGET}

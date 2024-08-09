ARG ADVANCED_THEME_VERSION=0.1.3
ARG ALPINE_VERSION=3.18
ARG FIREFOX_VERSION=117.0.1-1
ARG PYTHON_VERSION=3.11
ARG SEARXNG_VERSION=f1c05e7c16e59a8d5d98640bc057958ea268cddf

FROM python:${PYTHON_VERSION}-alpine${ALPINE_VERSION}

ARG SEARXNG_PATH=/usr/local/searxng
ARG SEARXNG_REPO=https://github.com/searxng/searxng.git
ARG SEARXNG_VERSION

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

ARG ADVANCED_THEME_PATH=${SEARXNG_PATH}/searx/templates/advanced
ARG ADVANCED_THEME_REPO=https://github.com/SatoshiGuacamole/searxng-advanced-theme.git
ARG ADVANCED_THEME_VERSION

RUN git clone "$ADVANCED_THEME_REPO" "$ADVANCED_THEME_PATH" \
    && cd "$ADVANCED_THEME_PATH" \
    && git checkout "$ADVANCED_THEME_VERSION" \
    && rm -rf \
        "${ADVANCED_THEME_PATH}/.git" \
    && apk del .build-deps

COPY --link rootfs /

RUN chown -R nobody \
        "$SEARXNG_PATH" \
        /var/log/uwsgi/ \
    && chmod +x /entrypoint.sh

USER nobody

EXPOSE 1234

ENTRYPOINT ["/entrypoint.sh"]

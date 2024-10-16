ARG ADVANCED_THEME_VERSION=0.1.3
ARG ALPINE_VERSION=3.20
ARG FIREFOX_VERSION=117.0.1-1
ARG PYTHON_VERSION=3.11
ARG SEARXNG_VERSION=cf7627557ab29e31efbf4a0719d1083592e22242

FROM python:${PYTHON_VERSION}-alpine${ALPINE_VERSION}

ARG SEARXNG_VERSION

RUN apk add --virtual .build-deps \
        build-base \
    && apk add \
        git \
        uwsgi-python3 \
    && git clone https://github.com/searxng/searxng.git /usr/local/searxng \
    && cd /usr/local/searxng \
    && git checkout "$SEARXNG_VERSION" \
    && pip install --upgrade pip \
    && pip install --no-cache -r requirements.txt

COPY --link rootfs /

RUN chown -R nobody \
        "/usr/local/searxng" \
        /var/log/uwsgi/ \
    && chmod +x /entrypoint.sh

USER nobody

EXPOSE 80

ENTRYPOINT ["/entrypoint.sh"]

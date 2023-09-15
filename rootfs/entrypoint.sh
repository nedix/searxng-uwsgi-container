#!/usr/bin/env sh

export SEARXNG_SETTINGS_PATH="/etc/searxng/settings.yml"

exec uwsgi --http-socket 0.0.0.0:1234 \
    --ini /usr/local/searxng/dockerfiles/uwsgi.ini \
    --ini /etc/searxng/uwsgi.ini \
    --ini /usr/local/searxng/searx/templates/advanced/uwsgi.ini

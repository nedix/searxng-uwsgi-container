#!/usr/bin/env sh

set -e

: ${SEARXNG_SETTINGS_PATH:="/etc/searxng/settings.yml"}
: ${UWSGI_THREADS:="4"}
: ${UWSGI_WORKERS:="%k"}

PYTHON_PATH="$(python -c 'import site; print(site.getsitepackages()[0])')"

export SEARXNG_SETTINGS_PATH

sed -E \
    -e "s|(threads =).*|\1 ${UWSGI_THREADS}|" \
    -e "s|(workers =).*|\1 ${UWSGI_WORKERS}|" \
    -i /usr/local/searxng/dockerfiles/uwsgi.ini

sed -E \
    -e "s|(pythonpath =).*|\1 ${PYTHON_PATH}|" \
    -i /etc/searxng/uwsgi.ini

exec uwsgi --http-socket 0.0.0.0:80 \
    --ini /usr/local/searxng/dockerfiles/uwsgi.ini \
    --ini /etc/searxng/uwsgi.ini

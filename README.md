# [⚠️ Not for production ⚠️](https://github.com/nedix/searxng-uwsgi-docker/issues/30)

# [searxng]-uwsgi-docker

Automated builds of the SearxNG metasearch-engine. Tested to ensure that preferences do not change between builds.

## Usage

#### Start the server

This example command will start the server on port `80`.

```shell
docker run --pull always --rm --name searx \
    -p 80:1234 \
    -d ghcr.io/nedix/searxng-uwsgi-docker
```

<hr>

## Attribution

Powered by [SearxNG].

[SearxNG]: https://github.com/searxng/searxng

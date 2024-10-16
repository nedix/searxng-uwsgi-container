# [⚠️ Not ready for production ⚠️](https://github.com/nedix/searxng-uwsgi-docker/issues/30)

# [searxng-container](https://github.com/nedix/searxng-container)

SearxNG metasearch-engine.

## Usage

#### Start the server

This example command will start the server on port `8080`.

```shell
docker run --pull always --rm --name searxng \
    -p 8080:80 \
    -d nedix/searxng
```

<hr>

## Attribution

Powered by [SearxNG].

[SearxNG]: https://github.com/searxng/searxng

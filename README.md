# X-Accel-Redirect

## Memo

1. Create network

    ```sh
    docker network create x-accel-redirect_default
    ```

    ★ Delete network when you delete this apps.

    ```sh
    docker network remove x-accel-redirect_default
    ```

1. Create webapp (Rails)

    See ./web

1. Create proxy (Nginx)

    See ./proxy

1. Run

    ```sh
    docker-compose up
    ```

1. Test

    1. Top : http://localhost:8080
    1. 404 : http://localhost:8080/external_files?p=invalid-path.txt
    1. 404 : http://localhost:8080/internal_files?p=/ddd/eee/fff.txt
    1. 200 : http://localhost:8080/external_files?p=/aaa/bbb/ccc.txt
    1. 200 : Verify authorization token.

        ```sh
        curl localhost:8080/auth_verify -H 'Authorization: 012345' -v

        # > > Authorization: 012345
        # >
        # > < X-Authorization: 012345
        # > < X-User: user-012345
        # >
        # > {
        # >   "request_headers": {
        # >     "authorization": "012345"
        # >   },
        # >   "response_headers": {
        # >     "x_authorization": "012345",
        # >     "x_user":"user-012345"
        # >   }
        # > }
        ```

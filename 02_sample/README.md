# 3 steps

## MEMO

### Create test data

```ruby
require 'securerandom'
File.write('proxy/static/01_1k.txt', SecureRandom.alphanumeric(1_000 - 1) + "\n")
File.write('proxy/static/02_10k.txt', 10.times.map { SecureRandom.alphanumeric(1_000 - 1) }.join("\n") + "\n")
File.write('proxy/static/03_20k.txt', 20.times.map { SecureRandom.alphanumeric(1_000 - 1) }.join("\n") + "\n")
File.write('proxy/static/04_1m.txt', 1_000.times.map { SecureRandom.alphanumeric(1_000 - 1) }.join("\n") + "\n")
```

### GET Nginx static files

```sh
# 1sec OK
wget localhost:8080/proxy/static/01_1k.txt -O /dev/null
# 10sec OK
wget localhost:8080/proxy/static/02_10k.txt -O /dev/null
# 20sec OK
wget localhost:8080/proxy/static/03_20k.txt -O /dev/null
# 1000sec OK
wget localhost:8080/proxy/static/04_1m.txt -O /dev/null
```

### Rails

In devcontainer.

1. Setting up.

    ```sh
    gem install rails

        # Fetching concurrent-ruby-1.1.10.gem
        # Fetching zeitwerk-2.6.6.gem
        #     ...
        # Successfully installed rails-7.0.4
        # 36 gems installed

    rails new --api --skip-test --skip-bundle .

        # create  app
        # create  app/assets/config/manifest.js
        #     ...
        # remove  config/initializers/permissions_policy.rb
        # remove  config/initializers/new_framework_defaults_7_0.rb

    rm -rf .git
    ```

1. .gitignore

    ```diff
    + /vendor/bundle
    +
      # See https://help.github.com/articles/ignoring-files for more about ignoring files.
    ```

1. Install gems.

    ```sh
    bundle

        # Fetching gem metadata from https://rubygems.org/...........
        # Resolving dependencies...
        # Fetching rake 13.0.6
        #     ...
        # Installing rails 7.0.4
        # Bundle complete! 6 Gemfile dependencies, 54 gems now installed.
        # Bundled gems are installed into `./vendor/bundle`
    ```

1. Routes

    * Proxy (Nginx)
        * /web/download
        * /internal/download
        * /web/upload
        * /internal/upload
        * /internal/upload-next
    * Web (Rails)
        * /public/download
        * /public/upload
        * /private/upload
    * Storage (Mocked by Rails)
        * /storage/download
        * /storage/upload

    ```txt
    Client               Proxy                                       Web    Storage
      *                    .                                          .        .
      |-- /web/download -->|                                          .        .
      |                    |                                          .        .
      |                    |-- /public/download --------------------->|        .
      |                    |                                          |        .
      |                    |<== [DOWNLOAD URL] (/internal/download) ==|        .
      |                    |                                          .        .
      |                    |---+ [DOWNLOAD URL] (/internal/download)  .        .
      |                    |   |                                      .        .
      |                    |   |-- /storage/download ------------------------->|
      |                    |   |                                      .        |
      |<===================+<==+<============================== [LARGE DATA] ==|
      *                    .                                          .        .
    ```

    ```txt
    Client               Proxy                                                  Web   Storage
      *     [HEADER]       .                                                     .       .
      |-- /web/upload ---->|                                                     .       .
      |                    |                                                     .       .
      |                    |---+ /_auth_request                                  .       .
      |                    |   |                                                 .       .
      |                    |   |-- /public/upload ------------------------------>|       .
      |                    |   |                                                 |       .
      |                    |   |<============= [UPLOAD URL] (/internal/upload) ==|       .
      |                    |<==|                                                 .       .
      |                    |                                                     .       .
      |                    |-------------------------+ [UPLOAD URL]              .       .
      |                    |                         | (/internal/upload)        .       .
      |      [BODY]        |                         |                           .       .
      |-- /web/upload ---->+------------------------>+-- /storage/upload [LARGE DATA] -->|
      |                    |                         |                           .       |
      |                    |                         |<============ [AFTER UPLOAD URL] ==|
      |                    |                         |          (/internal/upload-next)  .
      |                    |<== [AFTER UPLOAD URL] ==|                           .       .
      |                    |  (/internal/upload-next)                            .       .
      |                    |                                                     .       .
      |                    |---+ [AFTER UPLOAD URL] (/internal/upload-next)      .       .
      |                    |   |                                                 .       .
      |                    |   |-- /private/upload ----------------------------->|       .
      |                    |   |                                                 |       .
      |                    |   |<================================================|       .
      |                    |   |                                                 .       .
      |                    |<==|                                                 .       .
      |                    |                                                     .       .
      |<===================|                                                     .       .
      *                    .                                                     .       .
    ```

### GET Rails files

```sh
# 1sec OK
wget localhost:8080/web/download?s=1k -O /dev/null
# 10sec OK
wget localhost:8080/web/download?s=10k -O /dev/null
# 20sec OK
wget localhost:8080/web/download?s=20k -O /dev/null
# 1000sec OK
wget localhost:8080/web/download?s=1m -O /dev/null
# 3sec NG (Timeout)
wget localhost:8080/web/download?s=timeout -O /dev/null
```

curl localhost:8080/storage/upload -F file=@02_sample/README.md
curl localhost:8080/storage/upload -F file=@02_sample/proxy/static/04_1m.txt

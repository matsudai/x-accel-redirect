# Rails

1. Add devcontainer settings.

    - .devcontainer/devcontainer.json
    - .devcontainer/Dockerfile

1. Prepare rails.

    ```sh
    gem install rails

    # > Fetching zeitwerk-2.6.1.gem
    # > Fetching thor-1.2.1.gem
    #
    #     ...
    #
    # > Successfully installed rails-7.0.4
    # > 35 gems installed
    ```

1. Rails new.

    ```sh
    rails new --api --minimal --skip-active-record --skip-test --skip-bundle .
    ```

    - .gitignore

    ```diff
    + /vendor/bundle
    +
      # See https://help.github.com/articles/ignoring-files for more about ignoring files.
    ```

    ```sh
    bundle install

    # > Fetching gem metadata from https://rubygems.org/...........
    # > Resolving dependencies...
    # > Fetching rake 13.0.6
    #
    #     ...
    #
    # > Installing rails 7.0.4
    # > Bundle complete! 4 Gemfile dependencies, 49 gems now installed.
    # > Bundled gems are installed into `./vendor/bundle`
    ```

1. Create public/private links

    ```sh
    rails g scaffold external_file
    rails g scaffold internal_file
    ```

    - app/controllers/external_files_controller.rb
    - app/controllers/internal_files_controller.rb
    - config/routes.rb

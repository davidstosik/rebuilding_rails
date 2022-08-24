# Zero to “It Works!”

`bundle gem` now asks for preferences!
- minitest
- GitHub Actions
- MIT licence
- no code of conduct
- no changelog
- Rubocop

`rulers.gemspec` template has changed quite a bit:

- I set `metadata["allowed_push_host"]` to an empty string, and all other `_uri` metadata to `spec.homepage`.
- There are no development dependencies anymore! Instead, they seem to be listed in `Gemfile` (rake, minitest, rubocop).
- Template recommends using `spec.add_dependency` and does not mention `spec.add_runtime_dependency`. Wonder if there's a difference. 🤔
    Turns out they're the same:
    ```rb
    alias add_dependency add_runtime_dependency
    ```
    (rubygems/specification.rb:1491)

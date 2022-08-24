# Zero to “It Works!”

## In the Rough

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

## Hello World, More or Less

Not entirely clear `best_quotes` should not be _within_ `rulers`.
Maybe I'll want to store the two "projects" (gem and app) in the same GitHub repository using subfolders?

Add a `Gemfile`: use `bundle init`?
I tried using `bundle install --local` as I'm on the plane writing this, and it failed with this error:

> Could not find gem 'rulers' in any of the gem sources listed in your Gemfile.

even though I have installed the `rulers` gem I just built in the previous step.

Update: it turns out, as I changed directory, `chruby` was not active anymore and I had reverted to a different version of Ruby for which I had not installed the gem. Switching back to the same Ruby version, I was able to run `bundle install --local` without an Internet connection.

Need to confirm: is there a risk of confusion where my `best_quotes` app might be using the local `rulers`, or might download the one on RubyGems? Is that what was meant in the previous chapter?
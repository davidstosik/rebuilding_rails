Rebuilding Rails
================

This repository includes both the `rulers` gem and the `best_quotes` application that I am building while reading [Rebuilding Rails](https://rebuilding-rails.com/), by [Noah Gibbs](https://github.com/noahgibbs).

I'll use this README.md file to collect my notes and questions.

## 1. Zero to "It Works!"

### In the Rough

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

### Hello World, More or Less

Not entirely clear `best_quotes` should not be _within_ `rulers`.
Maybe I'll want to store the two "projects" (gem and app) in the same GitHub repository using subfolders?

Add a `Gemfile`: use `bundle init`?
I tried using `bundle install --local` as I'm on the plane writing this, and it failed with this error:

> Could not find gem 'rulers' in any of the gem sources listed in your Gemfile.

even though I have installed the `rulers` gem I just built in the previous step.

Update: it turns out, as I changed directory, `chruby` was not active anymore and I had reverted to a different version of Ruby for which I had not installed the gem. Switching back to the same Ruby version, I was able to run `bundle install --local` without an Internet connection.

Need to confirm: is there a risk of confusion where my `best_quotes` app might be using the local `rulers`, or might download the one on RubyGems? Is that what was meant in the previous chapter?

### Exercise Two

> any application including Rulers will be able to write ["", ""].sum and get the sum of the array

Looks like this should be referencing `Array#deeply_empty?`

### Exercise Three

`bundle gem`'s default seems to have changed to having development dependecies in `Gemfile`. Has something changed?

`bundle gem` already set up minitest for me, so I already have `test_helper.rb`.

TIL about passing a string to `String#[]`.

### Exercise Four

It seems `rackup` now uses puma. `rackup -s webrick` can run WEBrick.
One might need to install Unicorn before being able to run `unicorn`.

### Exercise Five

Already done earlier, in commit a0a0911.
Question: should we ignore `Gemfile.lock` too?

## 2. Your First Controller

### Sidetrack: merging the two repositories

I wanted to gather both `rulers` and `best_quotes` repositories in a single one, so that I see a single repository on GitHub, and it was possible while keeping the Git history, following this article: [Combine Git repositories with unrelated histories](https://jeffkreeftmeijer.com/git-combine). Now back to chapter 2.

### On the Rack

The first routing implementation does not work for the root path (it requires the URL to have a controller and action). It broke a test, and writing a test that would pass instead was a bit difficult.

### It Almost Worked!

I decided to `rescue NameError` for a slightly less horrible hack handling both favicon.ico and other 404s.
I also learned that `NoMethodError` is a subclass of `NameError`, so I don't need to rescue both.
Update: turns out this was a bad idea. Raising a `RoutingError` from `#get_controller_and_action`.

### Exercise One: Debugging the Rack Environment

I wanted a prettier print but did not find any out-of-the-box solution except `JSON.pretty_generate`. Probably not even perfect...

Also forgot I had to restart rackup for every change in the application.

### Exercise Two: Debugging Exceptions

I decided to only return a 500 text error including the exception's inspect.

### Exercise Three: Roots and Routes

- Not sure how I'd read and return the content of `public/index.html`: will it just work?
- Wanted to redirect, but couldn't figure out where. So I decided to pick the first existing controller/action.

## 3. Rails Automatic Loading

Other debug tricks:

- `#p` and `#pp` (though don't exist on `STDERR`)
- `#pretty_inspect`
- adding an emoji to the beginning of a debug

I wish I could have something like this in my toolbox:
```rb
def ppp(obj, message=nil, out: STDERR, emoji: "⬇️")
  out.puts("#{emoji} #{message}")
  out << obj.pretty_inspect
  nil
end
```

### CamelCase and snake_case

I decided to monkey-patch `String` instead of writing a less OO util method.

### Reloading Means Convenience

When I run `bundle exec rackup`, it complains that it can't find any handler (`:puma`, `:thin`, `:falcon`, `:webrick`).
Adding any of those gems to my Gemfile seems to fix it.

Alternatively, it looks like Rack split `rackup` into [its own gem](https://github.com/rack/rackup), which I can also add to my Gemfile, and will add a webrick dependency.

Everything worked so far probably because I've had `puma` installed on my system, coming as a dependency of another project.

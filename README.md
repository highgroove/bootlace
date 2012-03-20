# Bootlace

A simple gem for getting your development (or other) environments setup quickly!  Efficiently bootstrap Ruby applications based upon the GitHub script/bootstrap model, but with a clean DSL on top.

Right now it's very lightweight, and the DSL is expected to change as we use it on more projects and find we need to revise
how we're doing things.

## Installation

Add this line to your application's Gemfile:

    gem 'bootlace', require: false

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bootlace

## Usage

You may use Bootlace stand-alone or integrated with Rails.

Create a `script/bootstrap` file in your app that looks like so:

```
#!/bin/env ruby

require 'bootlace'
include Bootlace

package mac: "redis", ubuntu: "redis-server"

bundler

rake 'db:create', environment: { "RAILS_ENV" => "test" }
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

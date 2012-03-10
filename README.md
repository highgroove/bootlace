# Bootlace

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'bootlace', require: false

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bootlace

## Usage

You may use Bootlace stand-alone or integrated with Rails.

```
#!/bin/env ruby

require 'bootlace'
include Bootlace

package mac: "redis", ubuntu: "redis-server"


```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

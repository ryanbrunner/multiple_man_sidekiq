# MultipleManSidekiq

MultipleManSidekiq adds support for asynchronously sending messages through [MultipleMan](https://github.com/influitive/multiple_man). By publishing messages asynchronously, you can avoid serialization of MultipleMan messages and communication with your RabbitMQ server from interfering with the load time of your requests.

## Installation

Add this line to your application's Gemfile:

    gem 'multiple_man_sidekiq'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install multiple_man_sidekiq

## Usage

MultipleManSidekiq adds a new option to the `publish` call provided by MultipleMan. To set any publish to asynchronous, just add `async: true` to the options when setting up publishing. 

### Example

```
class Widget
  include MultipleMan::Publisher
  publish fields: [:foo, :bar],
          async: true
end
```

MultipleMan::Sidekiq will create a new job in your default Sidekiq queue (`ASyncModelPublisher`) that will push your 
messages to RabbitMQ.

## Options

You can configure which queue MultipleMan will send to on a per-operation basis. For example, you might want your seed
messages to be on a low-priority queue. Add this to your MultipleMan initializer:

```
MultipleManSidekiq.configure do
  config.sidekiq_queue = {
    seed: 'low'
  }
end
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/multiple_man_sidekiq/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request


## License

The MIT License (MIT)

Copyright (c) 2015 Influitive Corporation

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

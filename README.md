# Maybelline

[![Build Status](http://travis-ci.org/blatyo/maybelline.png)](http://travis-ci.org/blatyo/maybelline)

An implementation of the [maybe monad][1].

[1]: http://en.wikipedia.org/wiki/Monad_(functional_programming)#The_Maybe_monad

## Setup

**Gemfile**
``` ruby
gem 'maybelline'
```

**Manual**
``` ruby
require 'maybelline'
```

## Usage

Say you have some objects like the ones below:

``` ruby
require 'ostruct'

data = {
  "neat" => {
    "super" => "cool",
    "lame"  => nil
  }
}

object = OpenStruct.new(data)
object.neat = OpenStruct.new(object.neat)
```

If any method in the chain of calls returns nil, the block will return nil.

``` ruby
Maybe(data){|d| d["this_key_doesnt_exist"]["this_key_wont_get_called"]} #=> nil
data.maybe{|d| d["this_key_doesnt_exist"]["this_key_wont_get_called"]}  #=> nil
object.maybe{|o| o.neat.lame.this_method_never_gets_called}             #=> nil
```

If it is successful, it will return the value.

``` ruby
data.maybe{|d| d["neat"]["super"]}  #=> "cool"
object.maybe{|o| o.neat.super}      #=> "cool"
```

## Note on Reporting Issues

* Try to make a failing test case
* Tell me which version of ruby you're using
* Tell me which OS you are using
* Provide me with any extra files if necessary

## Note on Patches/Pull Requests

* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a future version unintentionally.
* Commit, do not mess with rakefile, version, or history. (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.
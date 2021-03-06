cache.rb
========

A simple cache system for Ruby programmers

# Description

You want to keep data in memory, providing a way to retrieve it by its
name (a key) during a specific amount of time, to avoid frequent loading of
the same resource.

This class provide a generic way to do it. It is a Hash-like container that
keep your data for a fixed amount of time (expressed in seconds).


# Using the Cache class

* Create a Cache object by giving its constructor the duration (in seconds)
while the data must be accessible;
* use the `Cache#[]` and `Cache#[]=` operators to get and set data;
* you can check the number of entries by calling the `Cache#size` method;
* you can check whether a key is set or not by calling the `Cache#has_key?` method;
* you can clean up every outdated entries by calling the `Cache#clean_up!` method.

# Sample code:

```ruby
require './cache'

cache = Cache.new seconds=30, minutes=1

cache[:foo] = 'bar' # store the value 'bar' with the key :foo
cache[:foo] # retrieve it (or nil if you've waited for at least 1 minute and 30 seconds)
```

# Notes:

* each time you retrieve a data, its expiration is delayed;
* the `Cache#size` method count every entries, even if their expiration time has been reached. You should perform a call to `Cache#clean_up` before, if you don't want to take outdated data into consideration.

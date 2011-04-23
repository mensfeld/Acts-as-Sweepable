# Acts as Sweepable

## Install

    gem install acts_as_sweepable

and in your Gemfile:
    
    gem 'acts_as_sweepable'

## About

Adds a class method called sweep to ActiveRecord - used to remove old elements.

## Example

    # Will remove elements older than 10 days
    MyClass.sweep(:time => '10d')

    # Will remove elements older than 10 hours
    MyClass.sweep(:time => '10h')

    # Will remove elements older than 10 minutes
    MyClass.sweep(:time => '10m')

Params accepted by this method:

* `time` - d(days),h(hours), m(minutes)
* `conditions` - additional SQL conditions (like WHERE)
* `active` - (default true) - should it use updated_at and created_at to determine if object is old enough or should it use just created_at.

You can also yield a block of code - it will be performed on every object that should be deleted:

    MyClass.sweep(:time => '10d') do |el|
        el.do_smhtng
    end

## Note on Patches/Pull Requests
 
* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a future version unintentionally.
* Commit, do not mess with Rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

## Copyright

Copyright (c) 2011 Maciej Mensfeld. See LICENSE for details.

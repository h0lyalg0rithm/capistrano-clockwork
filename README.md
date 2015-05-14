

# Capistrano::Clockwork

Integrate clockwork gem with capistrano

## Installation

Add this line to your application's Gemfile:

    gem 'daemons'
    gem 'capistrano-clockwork'

or:

    gem 'daemons'
    gem 'capistrano-clockwork', group: :development

Make sure the daemons gem is required in production.
And then execute:

    $ bundle


## Usage
```ruby
    # Capfile

    require 'capistrano/clockwork'
```
Configurable options, shown here with defaults:
By default the gem expects a the clockwork script to be present in the lib folder

```ruby

	:clockwork_default_hooks = true
    :clockwork_file = "lib/clockwork.rb"
```
To override the defaults just change it in your Capfile

## To Change the clockscript location
```ruby

   set :clockwork_file, "clockwork.rb"
   
```
## To remove the default hooks

By default the clockwork daemon is restarted everytime you deploy to your server
```ruby

	set :clockwork_default_hooks, false
```

## Other capistrano tasks
By default the clockwork daemon is restarted everytime you deploy to your server
```bash

	cap clockwork:restart  #=> Restarts your clockwork instance
	cap clockwork:stop     #=> Stops the clockwork daemon
	cap clockwork:status   #=> Checks if clockwork daemon is running
	cap clockwork:start	   #=> Starts the clockwork daemon
```
## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
6. Build your gem using the rake command `rake build`

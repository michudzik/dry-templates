# Dry::Templates [![Build Status](https://travis-ci.org/michudzik/dry-templates.svg?branch=master)](https://travis-ci.org/michudzik/dry-templates)
The purpose of this gem is to add dry-transaction generators to your rails app.
Generated transactions follow the principle of CRUD, which means that for create, read, update, delete and index actions separate transactions are generated.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'dry-templates'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dry-templates

## Usage
Creates transaction for CRUD actions

Example:
<br/>
`$ bin/rails generate dry:templates:transactions init`

This will create:
```
|- app
    |- transactions
        |- application_transaction.rb
```
`$ bin/rails generate dry:templates:transactions users`

This will create:
```
|- app
    |- transactions
        |- application_transaction.rb
        |- users
            |- create.rb
            |- update.rb
            |- fetch.rb
            |- destroy.rb
            |- index.rb
```
`$ bin/rails generate dry:templates:transactions users create update`

This will create:
```
|- app
    |- transactions
        |- application_transaction.rb
        |- users
            |- create.rb
            |- update.rb
```

### Sample
https://github.com/michudzik/dry-templates-sample
Here you can find an example of dry-template generator in action

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/michudzik/dry-templates. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Dry::Templates project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/dry-templates/blob/master/CODE_OF_CONDUCT.md).

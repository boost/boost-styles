# Boost::Styles

Shared Boost styles configuration

## What's inside?
* Rubocop for Rails
* Rubocop performance
* Rubocop RSpec
* Stylelint - WIP
* ESLint - WIP

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'boost-styles', git: 'git@github.com:boost/boost-styles.git', require: false
```

And then execute:

    $ bundle

## Usage

Add this line to your application's `.rubocop.yml` file.

```yaml
inherit_gem: 
  boost-styles:
    - rubocop_default.yml
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/boost-styles. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Boost::Styles project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/boost-styles/blob/master/CODE_OF_CONDUCT.md).

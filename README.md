# HandyApn

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/handy_apn`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'handy_apn'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install handy_apn

## Usage

	$ require 'handy_apn'
	$ rake --tasks
	$ rake apn:send_push_notification[full_file_path_to_dot_pem,pass_phrase_for_certificate,device_token,is_dev_or_prod]

Note:
full_file_path_to_dot_cer - absolute location of the file along with file name and should be for .pem
device_token - should be separated by space after 8 characters as shown in example below.
is_dev_or_prod - false - connects to APN-Dev service - gateway.sandbox.push.apple.com

	$ rake apn:send_push_notification["/Users/blah/apn_certificates/aps_development.pem","blah","eb8328c8 3f42a4dd e7eb8e96 5535b0c7 653032eb 070e54d9 c55133a6 da32c94f",false]

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/sushmasatish/handy_apn.


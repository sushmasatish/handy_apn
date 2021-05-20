# HandyApn

## Requirements

ruby - 2.5.1
gem - 2.7.6

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

### Command Line
  The handy_apn gem provides a command-line option (```handy_apn```) to test your certificates by sending message to the device.
  
  To lists the commands available:
  ```sh
  $ handy_apn -h
  ```
  
  To send message to a device:
  ```sh
  $ handy_apn -h push

  push

  Usage: handy_apn push TOKEN [...]

  Examples:
        
    # description
    handy_apn push <token> -m "Hello, World"
        
  Options:
    -m, --alert ALERT    Body of the alert to send in the push notification 
    -e, --environment ENV Environment to send push notification (production or development (default)) 
    -c, --certificate CERTIFICATE Path to certificate (.pem) file 
    -p, --[no]-passphrase Prompt for a certificate passphrase 
  ```
  
  To send the message "Hello world" to the device using the production apple push notification service using the prodution pem file.
  ```sh
  $ handy_apn push "f2ecca82 b48b7a38 5b838ece 3079ee6f 29f27163 d8407c1f 01f7298c 0a74bd7c" -m "Hello world" -e production -c aps_production.pem -p
  ```

### Rakefile
  The handy_apn gem also provides a rake task to test your certificates by sending a message to the device.
  
  Create a Rakefile:
  ```sh
  $ vi Rakefile
  ```
  Add the following code to the Rakefile.
  ```ruby
  require "handy_apn/Rakefile"
  ```
  
  Now lists the rake tasks
  ```sh
  $ rake --tasks
  $ rake apn:send_message[apn_pem_file_path,apn_pass_phrase,device_token,should_send_message_to_apn_prod,message_text]
  ```
Params:

* apn_pem_file_path - absolute location of the file along with file name
* apn_pass_phrase - passphrase for your pem file
* device_token - should be formed of 64 alphanumeric characters and separated by space after 8 characters as shown in example below.
* should_send_message_to_apn_prod - true would send to apple's production push notification service.
* message_text - Message you want to send

Example to test development certificate:
```sh
$ rake apn:send_message["/Users/blah/apn_certificates/aps_development.pem","blah","eb8328c8 3f42a4dd e7eb8e96 5535b0c7 653032eb 070e54d9 c55133a6 da32c94f",false,"Hello world"]
```

## How to create apple push notification certificate

1. Open you Keychain and request for a CertificateSigningRequest(CSR): 
![alt tag](https://github.com/sushmasatish/handy_apn/blob/master/docs/CSRRequest.png)
2. Create your CSR and **save it disk**:![alt tag](https://github.com/sushmasatish/handy_apn/blob/master/docs/CSRCreation.png)
3. Open **apple developer portal**, open your app id and enable push notification:![alt tag](https://github.com/sushmasatish/handy_apn/blob/master/docs/AppleDeveloper_EnablePushNotification.png)
4. In apple developer portal, To create push notification developer certificate, Click Certificate, you will see this page, click Continue here:![alt tag](https://github.com/sushmasatish/handy_apn/blob/master/docs/AppleInstructionsOnCreatingCSR.png)
5. Now upload the CSR created in step 2:![alt tag](https://github.com/sushmasatish/handy_apn/blob/master/docs/generating_certificate.png)
6. Once generated, click on download and save the file. The saved file would be named: "aps_development.cer":![alt tag](https://github.com/sushmasatish/handy_apn/blob/master/docs/click_download.png)
7. Open the downloaded aps_development.cer file by double clicking. This would add the .cer to keychain. Now you should see, the public key, private key and certificate in your Keychain as shown:![alt tag](https://github.com/sushmasatish/handy_apn/blob/master/docs/CerPrivatePublicKeysInKeychain.png)
8. Now Select the **private key** and the **certificate** and right click and select ```Export 2 items```:![alt tag](https://github.com/sushmasatish/handy_apn/blob/master/docs/ExportingPrivateKeyDevCerTogether.png)
9. Now execute the following ```openssl``` command on the ```AppDemoPrivateKeyDevCerTogether.p12```:

```sh
$ openssl pkcs12 -in AppDemoPrivateKeyDevCerTogether.p12 -out push_notification_demo_apn_dev.pem -nodes -clcerts
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/sushmasatish/handy_apn.


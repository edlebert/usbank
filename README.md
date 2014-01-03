usbank
======

A gem to fetch usbank OFX transaction data.  It signs into usbank.com with your credentials and downloads your account's OFX data.

Installation
------------

Include the gem in your Gemfile:

```ruby
gem "usbank"
```

Usage
-----

```ruby
usbank = Usbank.new(
  username: 'johndoe', 
  password: 'alligator', 
  challenges: {
    "What date did you get married?" => "021498",
    "What was the name of your best friend in high-school?" => "Jane",
    "What is your father's middle name?" => "Cornelius"
  })
usbank.fetch # => String containing OFX data
```
# !!!The gem is not implemented yet, this is just a draft!!!

# Description

A Ruby gem for interacting with Parature (http://www.parature.com/) through their API.

# Installation

Like any other gem. If you use Bundler, please add it to your Gemfile:

```ruby
gem 'parature'
```

Or just install it directly to your system by:

```bash
$ gem install parature
```

# Usage

## Initialization

You should provide your domain name, your account id, your departure id and your token.
All that information you can find on the 'My Settings' page in Parature.
You can either provide that data explicitly into the constructor:

```ruby
parature = Parature.new(
  :host => "s1.parature.com",
  :account_id => 123,
  :departure_id => 456,
  :token => "B2KEnTCcMzA4/Slvvy0kq7iSROmzququ9vuWo6qMLkao5K4b0j3YdZUcw3wibD3NIZi95f7Ue8X0XVdvg9SBXw=="
)
```

Or by putting that info into the config/parature.yml:

```yaml
host: s1.parature.com
account_id: 123
departure_id: 456
token: B2KEnTCcMzA4/Slvvy0kq7iSROmzququ9vuWo6qMLkao5K4b0j3YdZUcw3wibD3NIZi95f7Ue8X0XVdvg9SBXw==
```

and calling the constructor without params, like:

```ruby
parature = Parature.new
```

## CRUD

You can retrieve folders and articles from Knowledgebase and also Tickets.
Have a look at the examples, they are pretty self-descriptable

```ruby
parature.folders.all
parature.folders.first
parature.folders.all(:name => "One")
parature.folders.first(:name => "One")
parature.folders.first.name # => "One"
parature.folders.first.folders.all
parature.folders.first.articles.all
parature.folders.create(:name => "FAQ")
parature.folders.first(:name => "FAQ").articles.create(
  :question => "How to build a time-machine?",
  :answer => "First, you need to buy DeLorean DMC-12..."
)
parature.folders.first.update(:name => "New FAQ")

parature.tickets.first.destroy
# Working with custom fields
parature.tickets.update(:custom => { :details => "blabla, new details..." })

# ...etc...
```

Of course you can combine these methods in the way you like and apply any
of them to folders, tickets and articles. There are some special operations
which can be applied only to Tickets:

```ruby
# Attaching files to the ticket
ticket = parature.tickets.first
ticket.update(:attachment => file) # Where file is an IO object

ticket = parature.tickets.create(
  :custom => { :details => "blabla" },
  ...
  :attachment => file
)
```

# Copyright

Copyright (c) 2012 Anton Astashov, released under the MIT license.

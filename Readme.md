authlogic3
=====

This is an 'enhanced' version/example application of the popular Authlogic gem running on Rails 3.0.

Added Features
------------

* Forgot password
* Email activation

Upcoming Features
------------

* Captcha support (login + registration)
* SMS registration support

Original Readme
------------

It uses the email to login, you could also use a login field, if you like. I use a custom email validator (blatantly stolen from Ryan Bates) to validate email formats.

It also includes RSpec tests for the Authlogic controller.

    To run the app:
    bundle install
    rake db:migrate
    rails s
    open http://localhost:3000/users/new

The root directory redirects to the login page.

    To run the tests:
    bundle install
    rake db:migrate
    rake db:test:prepare
    rake

You can also run autotest for continual testing.

The version of Authlogic used here is a fork that is at:
git://github.com/odorcicd/authlogic.git branch 'rails3'

I am using this because I got a "to_key" error with the official repo.

https://github.com/trevmex/authlogic_rails3_example

Helpful links
------------


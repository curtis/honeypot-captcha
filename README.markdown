# Honeypot Captcha

**The simplest way to add honeypot captchas in your Rails forms.**

Honeypot captchas work off the premise that you can present different form
fields to a spam bot than you do to a real user. Spam bots will typically try
to fill all fields in a form and will not take into account CSS styles.

We add bogus fields to a form and then check to see if those fields are
submitted with values. If they are, we assume that we encountered a spam bot.

* [Honeypot Captcha by Phil Haack](http://haacked.com/archive/2007/09/11/honeypot-captcha.aspx)
* [Stopping spambots with hashes and honeypots](http://nedbatchelder.com/text/stopbots.html)

## Installation

In your Gemfile, simply add

    gem 'honeypot-captcha'

## Usage

I've tried to make it pretty simple to add a honeypot captcha, but I'm open to
any suggestions you may have. By default, `create` and `update` actions are
protected. For other actions, see [below](#protection-for-actions-other-than-create-and-update).

### form_for

Simply specify that the form has a honeypot in the HTML options hash:

    <%= form_for Comment.new, :html => { :honeypot => true } do |form| -%>
      ...
    <% end -%>

### form_tag with block

Simply specify that the form has a honeypot in the options hash:

    <%= form_tag comments_path, :honeypot => true do -%>
      ...
    <% end -%>

### form_tag without block

Simply specify that the form has a honeypot in the options hash:

    <%= form_tag comments_path, :honeypot => true -%>
      ...
    </form>

### Protection for actions other than `create` and `update`

If you are submitting a form to a non-RESTful action and require
honeypot protection, simply add the before filter for that action
in your controller. For example:

    class NewsletterController < ApplicationController
      prepend_before_action :protect_from_spam, :only => [:subscribe]
      ...
    end

### Customizing the honeypot fields

Override the `honeypot_fields` method within `ApplicationController` to
add your own custom field names and values. For example:

    def honeypot_fields
      {
        :my_custom_comment_body => 'Do not fill in this field, sucka!',
        :another_thingy => 'Really... do not fill out!'
      }
    end

Override the `honeypot_string` method within `ApplicationController` to
disguise the string that will be included in the honeypot name. For example:

    def honeypot_string
      'im-not-a-honeypot-at-all'
    end

## Note on Patches/Pull Requests

* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a future version unintentionally.
* Commit, do not mess with rakefile, version, or history. (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

## Author
Created by [Curtis Miller](http://millarian.com) of Velocity Labs, a
[Ruby on Rails development company](http://velocitylabs.io).

### Contributors

* [Eric Saxby](http://github.com/sax)
* [Bernard Grymonpon](https://github.com/wonko)
* [Dave Tapley](https://github.com/dukedave)

## Copyright

Copyright (c) 2010 Curtis Miller. See LICENSE for details.

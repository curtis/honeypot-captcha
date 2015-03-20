class UsersController < ApplicationController
  def new
  end

  def create
    render text: 'ok'
  end

  private

  def honeypot_string
    'im-not-a-honeypot-at-all'
  end
end

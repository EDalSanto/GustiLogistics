require 'simplecov'
require 'minitest/autorun'

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  fixtures :all

  def is_logged_in?
    !session[:user_id].nil?
  end

  def log_in_as(user)
    session[:user_id] = user.id
  end

  def feature_log_in
    visit "/login"
    fill_in "Email", with: users(:edoardo).email
    fill_in "Password", with: 'password'
    click_button "Log in"
  end

end

class ActionDispatch::IntegrationTest

  def log_in_as(user, password: 'password')
    post login_path, params: { session: { email: user.email,
                                          password: 'password' } }
  end
end

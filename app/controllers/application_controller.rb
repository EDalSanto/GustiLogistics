class ApplicationController < ActionController::Base
  before_action :logged_in_user
  protect_from_forgery with: :exception
  include SessionsHelper
  include ProductsHelper
end

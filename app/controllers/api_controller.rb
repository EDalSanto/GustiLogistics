class ApiController < ApplicationController
  skip_before_action :verify_authenticity_token

  before_action :set_default_format
  before_action :authenticate_token!

  private

  def set_default_format
    request.format = :json
  end

  def authenticate_token!
    payload = JsonWebToken.decode(auth_token)
    if payload.present?
      @current_user = User.find(payload["sub"])
      p @current_user
    else
      render json: {errors: ["Invalid auth token"]}, status: :unauthorized
    end
  end

  def auth_token
    @auth_token ||= request.headers.fetch("Authorization", "").split(" ").last
  end
end

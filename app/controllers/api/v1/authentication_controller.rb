class Api::V1::AuthenticationController < ApiController
  skip_before_action :authenticate_token!

  def create
    user = User.find_by(email: params[:user][:email])
    render json: { token: JsonWebToken.encode(sub: user.id) }
  end
end

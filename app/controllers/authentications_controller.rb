# frozen_string_literal: true

# Authentication controller
class AuthenticationsController < ApplicationController
  skip_before_action :authenticate_user

  def login
    @user = User.find_by_email(login_params[:email])
    if @user&.authenticate(login_params[:password])
      token = JwtToken.encode(user_id: @user.id)
      json_success({ token: token })
    else
      json_unauthorized
    end
  end

  private

  def login_params
    params.permit(:email, :password)
  end
end

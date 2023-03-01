# frozen_string_literal: true

# User controller
class UsersController < ApplicationController
  skip_before_action :authenticate_user, only: [:create]
  before_action :find_user, only: [:show]

  def create
    @user = User.new(user_params)
    if @user.save
      json_success(@user.as_json)
    else
      json_bad_request(@user.errors.full_messages)
    end
  end

  private

  def user_params
    params.permit(:username, :email, :password, :password_confirmation)
  end

  def find_user
    @user = User.find(params[:id])
  end
end

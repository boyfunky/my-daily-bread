# frozen_string_literal: true

# Application controller
class ApplicationController < ActionController::API
  before_action :authenticate_user

  private

  def authenticate_user
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    begin
      @decoded = JwtToken.decode(header)
      @current_user = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end

  def json_success(data)
    render json: { data: data }, status: 200
  end

  def json_bad_request(errors)
    render json: { errors: errors }, status: 400
  end

  def json_not_found(message = 'Not Found')
    render json: { message: message }, status: 404
  end

  def json_unauthorized(message = 'Unathorized')
    render json: { message: message }, status: 403
  end
end

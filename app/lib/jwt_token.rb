# frozen_string_literal: true

require 'jwt'

# jwt token
class JwtToken
  SECRET_KEY = Rails.application.secret_key_base

  def self.encode(payload, exp = 1.month.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET_KEY)
  end

  def self.decode(token)
    decoded = JWT.decode(token, SECRET_KEY)[0]
    HashWithIndifferentAccess.new decoded
  end
end

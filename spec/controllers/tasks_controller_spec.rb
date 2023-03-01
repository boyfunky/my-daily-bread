# frozen_string_literal: true

require 'rails_helper'

describe TasksController, type: :controller do
  before(:each) do
    @user = create(:user)
    @auth_token = JwtToken.encode(user_id: @user.id)
  end

  describe 'get task detail' do
    it 'returns task detail' do
      task = create(:task, user: @user)
      headers = { 'Authorization' => @auth_token }
      request.headers.merge! headers
      params = { id: task.id }
      get :show, { "id": task.id.to_s }
    end
  end
end

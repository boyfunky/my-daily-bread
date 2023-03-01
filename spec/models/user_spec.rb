# frozen_string_literal: true

require 'rails_helper'

describe User, type: :model do
  context 'associations' do
    it { should have_many(:tasks) }
  end

  context 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:username) }
    it { should validate_uniqueness_of(:username) }
  end
end

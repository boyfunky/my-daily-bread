# frozen_string_literal: true

require 'rails_helper'

describe Task, type: :model do
  context 'associations' do
    it { should have_many(:task_activities) }
    it { should belong_to(:user) }
  end

  context 'validations' do
    it { should validate_inclusion_of(:status).in_array(%w[backlog in_progress delayed completed].map(&:to_sym)) }
  end
end

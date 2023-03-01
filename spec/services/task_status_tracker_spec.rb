# frozen_string_literal: true
require 'rails_helper'

describe TaskStatusTracker do
  let(!user) { create(:user) }
  let(!task) { create(:task, user: user) }
end

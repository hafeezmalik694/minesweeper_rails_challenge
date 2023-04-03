require 'rails_helper'

RSpec.describe Board, type: :model do
    describe 'validations' do
      it { should validate_presence_of(:name) }
      it { should validate_presence_of(:email) }
    end
  end
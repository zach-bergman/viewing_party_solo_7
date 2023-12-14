require 'rails_helper'

RSpec.describe UserParty, type: :model do
  describe 'validations and relationships' do
    it { should validate_presence_of :user }
    it { should validate_presence_of :viewing_party }
    
    it { should belong_to :user }
    it { should belong_to :viewing_party }
  end
end
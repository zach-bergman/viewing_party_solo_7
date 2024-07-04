require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
    it { should allow_value('something@something.something').for(:email) }
    it { should_not allow_value('something somthing@something.something').for(:email) }
    it { should_not allow_value('something.something@').for(:email) }
    it { should_not allow_value('something').for(:email) }

  end

  describe 'associations' do
    it { should have_many :user_parties }
    it { should have_many(:viewing_parties).through(:user_parties) }
  end

  before(:each) do
    # create users
    @user_1 = User.create!(name: "User 1", email: "user_1@email.com")
    @user_2 = User.create!(name: "User 2", email: "user_2@email.com")
    @user_3 = User.create!(name: "User 3", email: "user_3@email.com")
    @user_4 = User.create!(name: "User 4", email: "user_4@email.com")

    # create viewing parties
    @party_1 = ViewingParty.create!(date: "2024-12-01", start_time: "07:25", duration: 175, movie_id: 245891)
    @party_2 = ViewingParty.create!(date: "2024-12-02", start_time: "07:25", duration: 175, movie_id: 245891) #change movies
    @party_3 = ViewingParty.create!(date: "2024-12-03", start_time: "07:25", duration: 175, movie_id: 245891)
    @party_4 = ViewingParty.create!(date: "2024-12-04", start_time: "07:25", duration: 175, movie_id: 245891)
    @party_5 = ViewingParty.create!(date: "2024-12-04", start_time: "07:25", duration: 175, movie_id: 245891)

    # hosts
    UserParty.create!(user_id: @user_1.id, viewing_party_id: @party_1.id, host: true)
    UserParty.create!(user_id: @user_2.id, viewing_party_id: @party_2.id, host: true)
    UserParty.create!(user_id: @user_3.id, viewing_party_id: @party_3.id, host: true)
    UserParty.create!(user_id: @user_4.id, viewing_party_id: @party_4.id, host: true)
    UserParty.create!(user_id: @user_2.id, viewing_party_id: @party_5.id, host: true)

    # invites for party 1
    UserParty.create!(user_id: @user_2.id, viewing_party_id: @party_1.id, host: false)
    UserParty.create!(user_id: @user_3.id, viewing_party_id: @party_1.id, host: false)

    # invites for party 2
    UserParty.create!(user_id: @user_3.id, viewing_party_id: @party_2.id, host: false)
    UserParty.create!(user_id: @user_4.id, viewing_party_id: @party_2.id, host: false)

    # invites for party 3
    UserParty.create!(user_id: @user_2.id, viewing_party_id: @party_3.id, host: false)
    UserParty.create!(user_id: @user_1.id, viewing_party_id: @party_3.id, host: false)

    # invites for party 4
    UserParty.create!(user_id: @user_1.id, viewing_party_id: @party_4.id, host: false)
    UserParty.create!(user_id: @user_2.id, viewing_party_id: @party_4.id, host: false)
  end

  describe "instance methods" do
    describe "#party_invites" do
      it "returns all viewing parties the user has been invited to", :vcr do
        expect(@user_1.party_invites).to eq([@party_3, @party_4])
      end
    end

    describe "#host_parties" do
      it "returns all viewing parties the user has been invited to", :vcr do
        expect(@user_2.host_parties).to eq([@party_2, @party_5])
      end
    end
  end
end

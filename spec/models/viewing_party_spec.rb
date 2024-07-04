require 'rails_helper'

RSpec.describe ViewingParty, type: :model do
  before(:each) do
      @user_1 = User.create!(name: 'Sam', email: 'sam@email.com')
      @user_2 = User.create!(name: 'Tommy', email: 'tommy@email.com')
      @party = ViewingParty.create!(date: "2023-12-01", start_time: "07:25", duration: 175)
      UserParty.create!(user_id: @user_1.id, viewing_party_id: @party.id, host: true)
      UserParty.create!(user_id: @user_2.id, viewing_party_id: @party.id, host: false)
  end
  
  describe 'relationships' do
      it { should have_many :user_parties }
      it { should have_many(:users).through(:user_parties) }
  end

  describe "validations" do
    it { should validate_presence_of :duration }
    it { should validate_presence_of :date }
    it { should validate_presence_of :start_time }
  end

  describe "instance methods" do
    it "returns user that is hosting the party" do
      expect(@party.find_host).to eq (@user_1)
    end

    describe "#movie" do
      it "returns the movie associated with the viewing party by id - if id is given", :vcr do
        party_2 = ViewingParty.create!(date: "2022-11-05", start_time: "05:15", duration: 135, movie_id: 245891)

        expect(@party.movie).to eq(nil)
        
        expect(party_2.movie).to be_a Movie
        expect(party_2.movie.id).to eq(245891)
      end
    end

    describe "#duration_must_be_longer_than_movie_runtime" do
      it "adds error if duration is less than movie runtime when creating new ViewingParty object", :vcr do
        party_3 = ViewingParty.create(date: "2022-11-05", start_time: "05:15", duration: 5, movie_id: 245891)

        expect(party_3.errors.full_messages).to include("Duration must be longer than movie runtime")
      end
    end
  end
end
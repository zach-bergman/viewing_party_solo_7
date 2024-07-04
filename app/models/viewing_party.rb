class ViewingParty < ApplicationRecord
   has_many :user_parties
   has_many :users, through: :user_parties

   validate :duration_must_be_longer_than_movie_runtime

   validates :duration, presence: true
   validates :date, presence: true
   validates :start_time, presence: true

   def find_host
      users.where("user_parties.host = true").first
   end

   def duration_must_be_longer_than_movie_runtime
      if movie_id.present? && duration < movie.runtime
         errors.add(:duration, "must be longer than movie runtime")
      end
   end

   def movie
      if movie_id.present?
         MovieFacade.new(nil, movie_id).movie
      end
   end
end

class User < ApplicationRecord
   validates_presence_of :name, :email
   validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

   has_many :user_parties
   has_many :viewing_parties, through: :user_parties

   def party_invites
      viewing_parties.where("user_parties.host = false")
   end

   def host_parties
      viewing_parties.where("user_parties.host = true")
   end
end

class User < ApplicationRecord
   validates_presence_of :name, :email
   validates_uniqueness_of :email, format: { with: URI::MailTo::EMAIL_REGEXP }

   has_many :user_parties
   has_many :viewing_parties, through: :user_parties
end

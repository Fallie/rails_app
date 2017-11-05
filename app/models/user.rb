class User < ApplicationRecord
  include Clearance::User

    has_many :appointments 
    
	before_save { self.email = email.downcase }

	validates :name, presence: true, length: { maximum: 50 }
	validates :email, presence: true, length: { maximum: 255 }, 
			  uniqueness: { case_sensitive: false }
	validates :password, confirmation: true

	ROLES = ['doctor', 'patient'].freeze
end

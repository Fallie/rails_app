class Appointment < ApplicationRecord
	belongs_to :user 
	validates :datetime, presence: true
	validates :doctor_id, presence: true
	validates :patient_id, presence: true
end

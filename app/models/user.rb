class User < ApplicationRecord
  include Clearance::User

	before_save { self.email = email.downcase }

	validates :name, presence: true, length: { maximum: 50 }
	validates :email, presence: true, length: { maximum: 255 }, 
			  uniqueness: { case_sensitive: false }
	validates :password, confirmation: true
	validates :phone_number, format: 
				{ with: /\A(\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}\z/, 
				message: "Please enter a valid phone number (123) 456-7890" }
	validates :postcode, presence: true, length: { maximum: 5 }

	scope :doctors, -> { where(role: 'doctor') }

	ROLES = ['doctor', 'patient'].freeze

	def user_appointments
	  if is_patient
	    Appointment.where(patient_id: id)
	  elsif is_doctor
	    Appointment.where(doctor_id: id)
	  end
    end

	def upcoming_appointments
		if user_appointments == nil
			nil
		else
	      user_appointments.order(:appointment_time).select { |a| 
	        a.appointment_time > (DateTime.now) 
	      }
	  	end
  	end
  
  	def appointment_count
   	  @appointment_count ||= user_appointments.count if is_patient
  	end

    def is_patient
      role == 'patient'
  	end

  	def is_doctor
      role == 'doctor'
  	end


end

class Appointment < ApplicationRecord
	validates :doctor_id, presence: true
	validates :patient_id, presence: true
	validates :duration, presence: true, numericality: { greater_than_or_equal_to: 0 }
	validates :appointment_time, presence: { message: "must be a valid date" }

	validate :time_still_valid

	def start_time
		self.appointment_time
	end

	def end_time
		appointment_time + duration.seconds
	end

	def patient
		User.find(patient_id) if patient_id
	end

	def doctor
		User.find(doctor_id) if doctor_id
	end

	def location_name 
		doctor.location
	end

	## Form Parsing methods

	def patient_attributes=(atts)
		if atts[:name] != ""
		  self.patient = User.find_or_create_by(atts)
		end
	end

	def appointment_time=(time)
		if time.is_a?(Hash)
		  self[:appointment_time] = parse_datetime(time) 
		else
		  self[:appointment_time] = time
		end
	end

	def parse_date(string)
		array = string.split("/")
		first_item = array.pop
		array.unshift(first_item).join("-")
	end

	def parse_datetime(hash)
		if hash["date"].match(/\d{2}\/\d{2}\/\d{4}/)
		  Time.zone.parse("#{parse_date(hash["date"])} #{hash["hour"]}:#{hash["min"]}")
		end
	end

	def duration=(duration) 
		if duration.is_a?(Hash)
		  self[:duration] = parse_duration(duration)
		else 
		  self[:duration] = duration
		end
	end

	def parse_duration(hash)
		hash["hour"].to_i + hash["min"].to_i
	end

	def time_still_valid
		AppointmentTimeValidator.new(self).validate
	end
end

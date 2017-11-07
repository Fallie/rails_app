require 'rails_helper'

RSpec.describe Appointment, type: :model do

  let(:two_days_later) { DateTime.now.midnight + 59.hours }
  let(:valid_attributes) { {appointment_time: two_days_later, duration: 3600, patient_id: 2, doctor_id: 3 } }  
 
  before do
  	create(:third_test_user)
    create(:second_test_user)
  end

  context "validations" do 
    
    it "must have a duration" do 
      no_duration = Appointment.new( valid_attributes.merge(duration: "") )
      expect(no_duration).not_to be_valid
    end
    
    it "must have an appointment time" do 
      no_time = Appointment.new( valid_attributes.merge(appointment_time: "") )
      expect(no_time).not_to be_valid
    end
    
    
    it "cannot book an appointment that starts in the middle of another appointment" do 
      Appointment.create(valid_attributes)
      half_an_hour_later = two_days_later + 30.minutes
      conflicting_appointment = Appointment.create( valid_attributes.merge(appointment_time: half_an_hour_later))
      expect(conflicting_appointment).not_to be_valid
    end
    
    it "cannot book an appointment that starts at the same time as another appointment" do 
      Appointment.create(valid_attributes)
      conflicting_appointment = Appointment.create(valid_attributes)
      expect(conflicting_appointment).not_to be_valid
    end
    
  end
end

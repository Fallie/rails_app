class AppointmentSerializer < ActiveModel::Serializer
  attributes :id, :appointment_time, :duration, :doctor_id, :patient_id, :created_at
end

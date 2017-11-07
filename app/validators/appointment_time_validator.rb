
class AppointmentTimeValidator < ActiveModel::Validator

  def initialize(appointment)
    @appointment = appointment
    @doctor = appointment.doctor
    @patient = appointment.patient
  end

  def validate

    appointments_doctor = @doctor.user_appointments.select { |a|
      a.appointment_time.midnight == @appointment.appointment_time.midnight 
    }

    appointments_patient = @patient.user_appointments.select { |a|
      a.appointment_time.midnight == @appointment.appointment_time.midnight 
    }

    appointments = appointments_doctor + appointments_patient
    # makes sure that current appointments don’t overlap
    # first checks if an existing appointment is still
    # in progress when the new appointment is set to start
    # next checks if the new appointment would still be in 
    # progress when an existing appointment is set to start
    appointments.each do |appointment|
      if @appointment != appointment
          if (appointment.appointment_time <= @appointment.appointment_time && 
            @appointment.appointment_time <= appointment.end_time || 
            @appointment.appointment_time <= appointment.appointment_time && 
            appointment.appointment_time <= @appointment.end_time)
            @appointment.errors.add(:appointment_time, 'unavailable')
          end
      end
    end
  end
end
  
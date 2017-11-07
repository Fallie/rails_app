class AppointmentsController < ApplicationController
  before_action :require_login
  before_action :set_appointment, only: [:edit, :update, :destroy]
  before_action :set_appointments, only: [:index, :show, :edit]

  def index
    @upcoming_appointments = current_user.upcoming_appointments.paginate(page: params[:page], per_page: 2)
    
  end

  def new
    @appointments = current_user.user_appointments.select { |a| a.persisted? }
    @appointment = current_user.user_appointments.build
  end

  def create
    if current_user.is_patient
      @appointment = Appointment.new(appointment_params.merge(patient_id: current_user.id))
      if @appointment.valid?
        @appointment.save
        redirect_to appointments_path
      else 
        @appointment.doctor_id = nil
        @appointments = current_user.user_appointments.select { |a| a.persisted? }
        render :new
      end
    else
      not_found
    end
  end

  def update
    if @appointment.update(appointment_params)
      redirect_to appointments_path
    else 
      set_appointments
      render :edit
    end
  end

  def destroy
    @appointment.destroy 
    redirect_to appointments_path
  end

  private 

  def set_appointment
        
    @appointment = Appointment.find(params[:id])

    if @appointment.nil? 
      flash[:error] = "Appointment not found."
      redirect_to appointments_path
    end
  end
  
  def set_appointments
    @appointments = current_user.user_appointments.order(appointment_time: :desc)

  end
  
  def appointment_params
    params.require(:appointment).permit(:doctor_id, appointment_time: [:date, :hour, :min], duration: [:hour, :min])
  end
end

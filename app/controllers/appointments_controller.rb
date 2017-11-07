class AppointmentsController < ApplicationController
  before_action :require_login
  before_action :set_appointment, only: [:edit, :update, :destroy]
  before_action :set_appointments, only: [:index, :show, :edit]

  def index
    @upcoming_appointments = current_user.upcoming_appointments.paginate(page: params[:page], per_page: 2)
    respond_to do |format|
      format.html
      format.json { render json: @upcoming_appointments }
    end 
    
  end

  def new
    @appointments = current_user.user_appointments.select { |a| a.persisted? }
    @appointment = current_user.user_appointments.build
  end

  def create

    if current_user.is_patient
      @appointment = Appointment.new(appointment_params.merge(patient_id: current_user.id))
      respond_to do |format|
        if @appointment.valid?
          @appointment.save
          format.html { redirect_to appointments_path }
          format.json { render :show, status: :created, location: @appointment }

        else 
          @appointment.doctor_id = nil
          @appointments = current_user.user_appointments.select { |a| a.persisted? }
          format.html { render :new }
          format.json { render json: @appointment.errors, status: :unprocessable_entity }
        end
      end
    else
      not_found
    end
  end

  def update
 
    respond_to do |format|
      if @appointment.update(appointment_params)

        format.html { redirect_to appointments_path}
        format.json { render :show, status: :ok, location: @appointment }
      else
        set_appointments
        format.html { render :edit }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
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

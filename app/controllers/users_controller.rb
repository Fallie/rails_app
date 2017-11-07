class UsersController < Clearance::UsersController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :check_user, only: [:edit, :update,]


  def index
    @users = User.where.not(id: 1)
    @users = @users.where(role: 'doctor') if current_user.id != 1
    @users = @users.paginate(page: params[:page], per_page: 20)
    respond_to do |format|
      format.html
      format.json { render json: @users }
    end 
  end

  def new
    @user = User.new
  end

  def create
    @user = user_from_params

    respond_to do |format|
      if @user.save
        sign_in @user
        format.html { redirect_back_or url_after_create }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    set_user
    #Only patient that made appointment with the doctor can be seen by the doctor.
    if @user.is_patient && current_user.is_doctor
      can_view = false
      @user.user_appointments.select { |x, y| can_view = true if x.doctor_id == current_user.id}
      not_found if !can_view
    end
  end

  def edit
    set_user
  end

  def update
  
    respond_to do |format|
      if @user.update(user_params)

        format.html { redirect_to root_path}
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    check_root_user
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url}
      format.json { head :no_content }
    end
  end

  private

  def check_root_user  
    not_found  if !current_user || current_user.id != 1
  end

  def check_user  
    not_found  if !current_user || current_user.id != params[:id].to_i
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, 
                                 :role, :phone_number, :location, :postcode)
  end

end
class UsersController < Clearance::UsersController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :check_user, only: [:show, :edit, :update]


  def index
  
   @users = User.all
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
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url}
      format.json { head :no_content }
    end
  end

  private

  def check_user  
    not_found  if current_user.id != params[:id].to_i
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :role)
  end

end
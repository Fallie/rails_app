class UsersController < Clearance::UsersController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :check_user, only: [:edit, :update]


  def new
    @user = User.new
  end

  def create
    @user = user_from_params
    @user.role = role if role
    if @user.save
      sign_in @user
      redirect_back_or url_after_create
    else
      render template: "users/new"
    end
  end

  def show
    set_user
  end

  def edit
    set_user
  end

  def update
    if @user.update(user_params)
      redirect_to root_path
    else
      render 'users/edit'
    end
  end

  private

  def check_user  
    raise 'error' if current_user.id != params[:id]
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :role)
  end

  def role
    params[:user][:role]
  end
end
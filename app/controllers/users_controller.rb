class UsersController < Clearance::UsersController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  

  def new
    @user = User.new
  end

  def create
    @user = user_from_params

    if @user.save
      sign_in @user
      redirect_back_or url_after_create
    else
      flash.now[:error] = @user.errors.full_messages[0]
      render template: "users/new"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end

end
class Users::RegistrationsController < Devise::RegistrationsController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    redirect_to "registered" and return if @user.save
    render :new
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :name)
  end

end
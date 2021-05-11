class Users::SessionsController < Devise::SessionsController
  def new
    @user = User.new
  end

  def create
    @user = User.find_by email: params[:user][:email]
    render "not_found" and return if @user.nil?
    sign_in @user and redirect_to products_path and return if @user.confirmed? and @user.valid_password?(params[:user][:password])
    render "not_authorized"
  end

  def destroy
    sign_out current_user
    redirect_to root_path and return
  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end
end
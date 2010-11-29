class PasswordResetsController < ApplicationController
  before_filter :load_user_using_perishable_token, :only => [:edit, :update]
  before_filter :require_no_user
  
  def index
    render :action => :new
  end
  def new
    @user = User.new
  end
  def create
    @user = User.find_by_email(params[:email])
    if @user
      @user.deliver_password_reset_instructions!
      flash[:notice] = "Instructions to reset your password have been emailed to you. " +
        "Please check your email."
      redirect_to root_url
    else
      @user = User.new if !@user
      @user.errors.add(:email, "missing") if params[:email].blank?
      @user.errors.add(:email, "doesn't exist") if !User.find_by_email(params[:email])
      render :action => :new
    end
  end
  def edit
    render
  end
  def update
    @user.errors.add(:password, "missing") if params[:user][:password].blank?
    @user.errors.add(:password_confirmation, "missing") if params[:user][:password_confirmation].blank?
    if !@user.errors.any? 
      @user.password = params[:user][:password]
      @user.password_confirmation = params[:user][:password_confirmation]
      @user.save
      if  !@user.verified then
         @user.verify!
         flash[:notice] = "Password successfully updated and we also went ahead and verified your account"
      else
         flash[:notice] = "Password successfully updated"
      end
      redirect_to users_path, :format => params[:format]
    else
      render :action => :edit
    end
    
  end
  private
    def load_user_using_perishable_token
      @user = User.find_by_perishable_token(params[:id])
      unless @user
        flash[:notice] = "we're sorry, but we could not locate your account." +
          "if you are having issues try copying and pasting the URL " +
          "from your email into your browser or restarting the " +
          "reset password process."
        redirect_to root_url
      end
    end
end

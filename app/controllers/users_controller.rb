class UsersController < ApplicationController
  before_filter :require_user, :except => [:new, :create]

  def index
    @users = User.all
    respond_to do |format|
      format.html # index.html.haml
      format.xml  { render :xml => @users }
    end
  end
  def show
    @user = User.find(params[:id])
    respond_to do |format|
      format.html # show.html.haml
      format.xml  { render :xml => @user }
    end
  end
  def new
    @user = User.new
    respond_to do |format|
      format.html # new.html.haml
      format.xml  { render :xml => @user }
    end
  end
  def edit
    @user = User.find(params[:id])
  end
  def create
    @user = User.new(params[:user])
    respond_to do |format|
      if @user.save
        @user.deliver_verification_instructions!
        format.html { redirect_to(root_url, :notice => 'thanks for signing up, we\'ve delivered an email to you with instructions on how to complete your registration!') }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end
  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(@user, :notice => 'user was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end
end

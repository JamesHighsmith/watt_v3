class Users::RegistrationsController < Devise::RegistrationsController

  def edit
    @user = User.find_by_id(params[:format])
  end

  def update
    @user = User.find_by_id(params[:user_id])  
    if (params[:user][:password]=='' && params[:user][:password_confirmation]=='')
      @user.update_attributes(:name => params[:user][:name],:username => params[:user][:username],:email => params[:user][:email],:role => params[:user][:role] )
    else
      @user.update_attributes(:name => params[:user][:name],:username => params[:user][:username],:email => params[:user][:email],:password => params[:user][:password],:password_confirmation => params[:user][:password_confirmation],:role => params[:user][:role] )
    end  
    redirect_to "/manage_users"
  end
 
  def destroy
    @user = User.find_by_id(params[:user])
    if @user.videos.blank?
      @user.destroy
      flash[:notice] = "User has successfully deleted!"
      redirect_to :back
    else
      flash[:notice] = "User can not be deleted as some videos are also associated with that User!"
      redirect_to :back
    end
  end

end
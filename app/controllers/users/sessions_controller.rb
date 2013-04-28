class Users::SessionsController < Devise::SessionsController
  def new
    
    respond_to do |format|
      format.html do
        
      end
      format.js do
        session[:user_return_to] = params[:return_url]
        session[:note_body] = params[:note_body]
      end

      puts "&&&&&&&&&&&&&&&&&&&&&&&&&&&&&"
      puts request.xhr?
      puts format.inspect
      format.json do
        render :layout => nil
      end
    end
  end

  def create
    super
  end
end
class ApplicationController < ActionController::Base
  protect_from_forgery

  def give_vote(params,object)
    object = object.constantize.find(params[:id])
    begin
      if params[:direction] == 'up'
        current_user.vote_for(object)
      else
        current_user.vote_against(object)
      end
      status = "200"
    rescue ActiveRecord::RecordInvalid
      status = "404"
    end

    respond_to do |format|
      format.js do
        alert = (status == "200") ? 'Thanks for Voting' : 'Vote Already given'
        render :js => "alert('#{alert}');"
      end
    end
  end
  
end

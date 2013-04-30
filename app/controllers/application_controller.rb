class ApplicationController < ActionController::Base
  protect_from_forgery

  def give_vote(params,object)
    object = object.constantize.find(params[:id])
    
    if params[:direction] == 'up'
      current_user.vote_exclusively_for(object)
    else
      current_user.vote_exclusively_against(object)
    end
    
    respond_to do |format|
      format.js do
        voting = render_to_string(:partial => 'shared/voting', :locals => { :object => object }).to_json
        render :js => "$('#voting_#{object.class.to_s}_#{object.id}').html(#{voting});$('#voting_#{object.class.to_s}_#{object.id}').effect('highlight', {}, 3000);"
      end
    end
  end
  
end

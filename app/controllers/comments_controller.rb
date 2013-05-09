class CommentsController < ApplicationController
  before_filter :authenticate_user!

  def vote
    give_vote(params, 'Comment')
  end
  
  def create
    comment = Comment.new(params[:comment])
    user = current_user
    user.comments << comment
    respond_to do |format|
      format.js do
        comment_html = render_to_string(:partial => "projects/partials/comment", :locals => {:comment => comment, :user_id => user.id, :project_id => params[:project_id] }).to_json
        if comment.commentable.class.to_s == "Project"
          render :js => "$('#all_comments').append(#{comment_html});$('.comment_text_area').val('');"
        elsif comment.commentable.class.to_s == "Comment"
          #puts "***************************************"
          puts "comment_#{params[:project_id]}_#{comment.id}"
          render :js => "$('#comment_#{params[:project_id]}_#{comment.commentable_id}').append(#{comment_html});$('.comment_text_area').val('');$('#comment_#{comment.commentable_id}').hide('slow');"
        end
      end
    end
  end
end

class ProjectsController < ApplicationController
  before_filter :authenticate_user!, except: [:index]

  def vote
    give_vote(params, 'Project')
  end

  def search_by_tags
    if params[:q].present?
      sql = "select * from tags where LOWER(name) LIKE "  + "'" + params[:q].downcase.to_s + "%%'" +""
      result = ActiveRecord::Base.connection.execute(sql)
      @tags = result.to_a
      @tags = @tags.flatten

      respond_to do |format|
        format.json { render :json => @tags }
      end
    end
  end

  def index
    #    @projects = params[:id].blank? ? Project.all : Project.where("user_id=?",params[:id])

    if params[:tag]
      @projects = params[:id].blank? ? Project.tagged_with(params[:tag]) : Project.tagged_with(params[:tag]).where("user_id=?",params[:id])
    else
      @projects = params[:id].blank? ? Project.all : Project.where("user_id=?",params[:id])
    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @projects }
    end
  end

  def show
    @project = Project.find(params[:id])
    @comment = Comment.new
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @project }
    end
  end


  def new
    @project = current_user.projects.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @project }
    end
  end

  def edit
    @project = current_user.projects.find(params[:id])
  end

  def create
    @project = current_user.projects.build(params[:project])

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render json: @project, status: :created, location: @project }
      else
        format.html { render action: "new" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @project = current_user.projects.find(params[:id])

    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_url }
      format.json { head :no_content }
    end
  end
end

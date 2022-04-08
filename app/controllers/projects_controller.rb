class ProjectsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @projects = Project.includes(:todos).all

    render json: @projects, include: [
      todos: {except: [:project_id]}
    ]
  end

  def create
    @project = Project.new(project_params)
    
    if @project.save
      render json: "", status: 201
    else
      render json: { error: "Unable to create Project"}, status: 400
    end
  end

  private
  def project_params
    params.permit(:title)
  end
end

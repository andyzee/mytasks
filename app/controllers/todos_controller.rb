class TodosController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    errors = []
    if params[:project_id] and params[:project_id] != -1
      @project = Project.find(params[:project_id])
    elsif params[:project_title]
      @project = Project.new(title: params[:project_title])
      unless @project.save
        errors.push("Unable to create project")
      end
    end

    unless @project
      errors.push("Project not found or couldn't be created")
      render json: { errors: errors }, status: 422
    else
      @todo = @project.todos.new(todo_params)
      
      if @todo.save
        @projects = Project.includes(:todos).all
  
        render json: @projects, include: [
          todos: {except: [:project_id]}
        ], status: 201
      else
        render json: { error: "Unable to create Todo"}, status: 400
      end
    end

  end

  def update
    @todo = Todo.find(params[:id])
    if @todo
      @todo.update(todo_params)
      render json: @todo, status: 200
    else
      render json: { error: "Unable to update Todo"}, status: 400
    end
  end

  private
  def todo_params
    params.permit(:text, :isCompleted)
  end
end

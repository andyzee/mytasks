class TodosController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    if params[:project_id]
      @project = Project.find(params[:project_id])
    elsif params[:project_title]
      @project = Project.create(title: params[:project_title])
    end

    unless @project
      render json: { error: "Project not found or couldn't be created"}, status: 422
    end

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

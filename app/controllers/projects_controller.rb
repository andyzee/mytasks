class ProjectsController < ApplicationController
  def index
    result = {
      message: "ok"
    }
    render json: result
  end
end

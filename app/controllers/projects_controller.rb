class ProjectsController < ApplicationController

  before_action :authenticate_employee!
  
  def index
    @projects =  current_employee.projects
  end

  def new
    @project = Project.new
  end

  def edit
  end

  def create
    @project = Project.new(name: project_params[:name])

    respond_to do |format|
      if @project.valid? && current_employee.projects << @project
        format.html { redirect_to projects_path, alert: "Project Successfully Created"}
      else
        format.html { render action: :new}
      end
    end
  end

  def update
  end

  def delete
  end

  private

  def project_params
    params.require(:project).permit(:name)
  end
end

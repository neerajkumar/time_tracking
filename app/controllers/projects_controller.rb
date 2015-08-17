class ProjectsController < ApplicationController

  before_action :authenticate_employee!
  
  def index
    @projects =  current_employee.projects
  end

  def new
    @project = Project.new if current_employee.is_admin?
  end

  def edit
    @project = current_employee.projects.find(params[:id]) if current_employee.is_admin?
    @project.logged_hour_types.build
  end

  def create
    if current_employee.is_admin?
      @project = Project.new(name: project_params[:name])

      respond_to do |format|
        if @project.valid? && current_employee.projects << @project
          format.html { redirect_to projects_path, alert: "Project Successfully Created"}
        else
          format.html { render action: :new}
        end
      end
    end 
  end

  def update
    if current_employee.is_admin?
      @project = current_employee.projects.find(params[:id])

      respond_to do |format|
        if @project.update(project_params) 
          format.html { redirect_to projects_path, alert: "Project Successfully Updated"}
        else
          format.html { render action: :new}
        end
      end
    end
  end
    
  def show
    if current_employee.is_admin?
      @project = Project.find(params[:id])
      @members = @project.employees.uniq
      @resource = @project.employees.new

      respond_to do |format|
        format.html {}
      end
    end
  end

  def delete
    if current_employee.is_admin?
    end
  end

  private

  def project_params
    params.require(:project).permit(:name, logged_hour_types_attributes: [:id, :name])
  end
end

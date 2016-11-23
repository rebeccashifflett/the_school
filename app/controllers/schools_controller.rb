class SchoolsController < ApplicationController
  before_action :set_school, except: [:index, :new, :create]
  def index
    @schools = School.all
  end

  def new
    @school = School.new
  end

  def create
    @school = School.new(school_params)
    if @school.save
      flash[:success] = "School Created!"
      redirect_to school_path(@school)
    else
      flash[:error] = 'Fix errors and try again'
      render :new
    end
  end

  def destroy
    @school.destroy
    flash[:success] = 'School deleted!'
    redirect_to schools_path
  end

  def show
  end

  def edit

  end

  def update
   if @school.update(school_params)
     flash[:success] = 'School Updated!'
     redirect_to school_path(@school)
   else
     flash[:error] = 'School failed to update'
     render :edit
   end
  end


  private
  def school_params
    params.require(:school).permit(:name, :students, :open)
  end

  def set_school
    @school = School.find(params[:id])
  end
end

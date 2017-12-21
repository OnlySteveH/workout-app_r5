class DashboardsController < ApplicationController
  
  def show
  end
  
  def index
    @athletes = User.paginate(:page => params[:page])
  end
  
end

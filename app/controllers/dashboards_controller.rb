class DashboardsController < ApplicationController
  
  def show
  end
  
  def index
    @athletes = User.all
  end
  
end

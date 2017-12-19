class ExercisesController < ApplicationController
  
  def index
    #@exercises = Exercise.all
  end
  
  def new
    @exercise = current_user.exercises.new
  end
  
end
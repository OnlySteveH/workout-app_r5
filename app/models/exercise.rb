class Exercise < ApplicationRecord
  validates :duration_in_min, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :workout, presence: true
  validates :workout_date, presence: true
  belongs_to :user
  
  alias_attribute :workout_details, :workout
  alias_attribute :activity_date, :workout_date
  
  default_scope { where('workout_date > ?', 7.days.ago)
                  .order(workout_date: :desc) }
  
end

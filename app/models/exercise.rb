class Exercise < ApplicationRecord
  
  validates :duration_in_min, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :workout, presence: true
  validates :workout_date, presence: true
  validate :not_future_date
  validate :older_than_a_week
  
  belongs_to :user
  
  alias_attribute :workout_details, :workout
  alias_attribute :activity_date, :workout_date
  
  default_scope { where('workout_date > ?', 7.days.ago)
                  .order(workout_date: :desc) }


  private
  
    def not_future_date
      if workout_date.present? && Date.today < workout_date
        errors.add(:workout_date, "cannot be in the future")
      end
    end
  
    def older_than_a_week
      if workout_date.present? && workout_date < 7.days.ago
        errors.add(:workout_date, "cannot be older than a week")
      end
    end
  
end
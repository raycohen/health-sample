class Appointment < ActiveRecord::Base
  belongs_to :doctor
  belongs_to :patient

  validates :doctor, presence: true
  validates :patient, presence: true
  validates :start_time, presence: true
end

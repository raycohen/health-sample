class Doctor < ActiveRecord::Base
  include PersonConcern

  SPECIALTIES = [
    'Orthopedist',
    'Opthamologist',
    'Cardiologist'
  ].freeze

  validates :specialty, inclusion: {
    in: SPECIALTIES,
    message: "is not a supported specialty"
  }

  def name
    "Dr. #{super}"
  end
end

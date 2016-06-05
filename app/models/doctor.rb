class Doctor < ActiveRecord::Base
  include PersonConcern

  # A more flushed out system would allow a doctor to have multiple specialties,
  # the list of possible specialties be driven from a database table,
  # and use a join table to associate doctors and their specialties + metadata

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

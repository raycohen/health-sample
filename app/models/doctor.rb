class Doctor < ActiveRecord::Base
  include PersonConcern

  # A more flushed out system would allow a doctor to have multiple specialties,
  # the list of possible specialties be driven from a database table,
  # and use a join table to associate doctors and their specialties + metadata

  AILMENT_TO_SPECIALTY_MAP = {
    'broken bones' => 'Orthopedist',
    'eye trouble' => 'Opthamologist',
    'heart disease' => 'Cardiologist'
  }.freeze

  SPECIALTIES = AILMENT_TO_SPECIALTY_MAP.values.freeze

  validates :specialty, inclusion: {
    in: SPECIALTIES,
    message: "is not a supported specialty"
  }

  scope :for_ailment, lambda { |ailment|
    where(specialty: specialty_for(ailment))
  }

  scope :near_patient, lambda { |patient, miles|
    near([patient.lat, patient.long], miles)
  }

  def self.specialty_for(ailment)
    AILMENT_TO_SPECIALTY_MAP[ailment]
  end

  def has_specialty_for_ailment?(ailment)
    specialty == AILMENT_TO_SPECIALTY_MAP[ailment]
  end

  def name
    "Dr. #{super}"
  end

  def name_and_specialty
    "#{name} - #{specialty}"
  end
end

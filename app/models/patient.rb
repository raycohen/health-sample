class Patient < ActiveRecord::Base
  include PersonConcern

  # A more flushed out system would allow a patient to have multiple ailments,
  # the list of possible ailments be driven from a database table,
  # and use a join table to associate patients and their ailments + metadata

  AILMENTS = [
    'broken bones',
    'eye trouble',
    'heart disease'
  ].freeze

  validates :ailment, inclusion: {
    in: AILMENTS,
    message: "is not a supported ailment"
  }
end

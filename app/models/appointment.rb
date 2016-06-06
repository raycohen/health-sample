class Appointment < ActiveRecord::Base
  belongs_to :doctor
  belongs_to :patient

  after_commit :send_emails, on: :create

  validates :doctor, presence: true
  validates :patient, presence: true
  validates :start_time, presence: true

  validate :check_distance_from_patient_to_doctor, on: :create
  validate :start_time_three_days_in_future, on: :create
  validate :doctor_treats_ailment, on: :create

  def distance_from_patient_to_doctor
    Geocoder::Calculations.distance_between(
      [patient.lat, patient.long],
      [doctor.lat, doctor.long]
    )
  end

  private

  def send_emails
    AppointmentMailer.patient_appointment_created(self)
    AppointmentMailer.doctor_appointment_created(self)
  end

  def start_time_three_days_in_future
    if start_time < 3.days.from_now
      errors.add(:start_time, "must be 3 days in the future")
    end
  end

  def doctor_treats_ailment
    unless doctor.has_specialty_for_ailment?(patient.ailment)
      errors.add(:doctor, "does not treat #{patient.ailment}")
    end
  end

  def check_distance_from_patient_to_doctor
    if distance_from_patient_to_doctor > 10
      errors[:base] << "Office can't be more than 10 miles from patient."
    end
  end
end

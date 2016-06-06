class Appointment < ActiveRecord::Base
  belongs_to :doctor
  belongs_to :patient

  after_commit :send_emails, on: :create

  validates :doctor, presence: true
  validates :patient, presence: true
  validates :start_time, presence: true

  def send_emails
    AppointmentMailer.patient_appointment_created(self)
    AppointmentMailer.doctor_appointment_created(self)
  end
end

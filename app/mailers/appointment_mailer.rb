class AppointmentMailer < ApplicationMailer
  def patient_appointment_created(appointment)
    @appointment = appointment
    @patient = appointment.patient
    @doctor = appointment.doctor

    mail to: @patient.email, subject: 'An appointment was created'
  end

  def doctor_appointment_created(appointment)
    @appointment = appointment
    @patient = appointment.patient
    @doctor = appointment.doctor

    mail to: @doctor.email, subject: 'An appointment was created'
  end
end

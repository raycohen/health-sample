require 'rails_helper'

describe AppointmentMailer do
  let(:appointment) { create :appointment }

  shared_examples_for 'an appointment created email' do
    it 'contains the office address' do
      expect(subject.body).to include(appointment.doctor.display_address)
    end

    it 'contains the patient name' do
      expect(subject.body).to include(appointment.patient.name)
    end

    it 'contains the doctor name' do
      expect(subject.body).to include(appointment.doctor.name)
    end
  end

  describe '#patient_appointment_created' do
    subject do
      described_class.patient_appointment_created(appointment).deliver_now
    end

    it 'is sent to the patient' do
      expect(subject.to).to eq([appointment.patient.email])
    end

    it_behaves_like 'an appointment created email'
  end
  
  describe '#doctor_appointment_created' do
    subject do
      described_class.doctor_appointment_created(appointment).deliver_now
    end

    it 'is sent to the doctor' do
      expect(subject.to).to eq([appointment.doctor.email])
    end

    it_behaves_like 'an appointment created email'
  end
end

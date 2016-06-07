require 'rails_helper'

describe Appointment do
  let(:doctor) { create(:doctor) }
  let(:patient) { create(:patient) }

  subject { create :appointment, doctor: doctor, patient: patient }

  it { is_expected.to be_valid }

  describe 'distance_from_patient_to_doctor' do
    context 'with geocoded patient and doctor' do

      before do
        Geocoder::Lookup::Test.add_stub(
          "123 Main St, New York, NY, 10012", [
            {
              'latitude'     => 40.70550508797169,
              'longitude'    => -74.70643825531006,
              'address'      => 'New York, NY, USA',
              'state'        => 'New York',
              'state_code'   => 'NY',
              'country'      => 'United States',
              'country_code' => 'US'
            }
          ]
        )

        Geocoder::Lookup::Test.add_stub(
          "456 Main St, New York, NY, 10013", [
            {
              'latitude'     => 40.702003,
              'longitude'    => -74.887052,
              'address'      => 'New York, NY, USA',
              'state'        => 'New York',
              'state_code'   => 'NY',
              'country'      => 'United States',
              'country_code' => 'US'
            }
          ]
        )
      end

      # latitude: 40.70550508797169, longitude: -74.00643825531006
      let(:doctor) { create(:doctor, street: '123 Main St') }

      # , latitude: 40.702003, longitude: -72.887052
      let(:patient) { create(:patient, street: '456 Main St') }

      subject { build :appointment, doctor: doctor, patient: patient }

      it 'calculates the distance in miles between the two' do
        expect(subject.distance_from_patient_to_doctor.round).to eq(9)
      end

      context "when the doctor's office is too far away" do
        before do
          Geocoder::Lookup::Test.add_stub(
            "789 Main St, New York, NY, 10012", [
              {
                'latitude'     => 40.70550508797169,
                'longitude'    => -74.00643825531006,
                'address'      => 'New York, NY, USA',
                'state'        => 'New York',
                'state_code'   => 'NY',
                'country'      => 'United States',
                'country_code' => 'US'
              }
            ]
          )
        end

        let(:doctor) { create(:doctor, street: '789 Main St') }

        it 'is invalid' do
          expect(subject).to be_invalid
        end
      end
    end
  end
end

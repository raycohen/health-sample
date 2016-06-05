require 'rails_helper'
require 'support/person_examples'

describe Doctor do
  subject { create :doctor }

  it { is_expected.to be_valid }

  it_behaves_like 'a person'

  describe '#name' do
    let(:name) { subject.name }

    it 'starts with "Dr. "' do
      expect(name.starts_with?('Dr. ')).to be_truthy
    end
  end

  specify 'that the the validation rule for specialty exists' do
    # personally I am not a fan of this style of validation
    #
    # A more flushed out system would likely allow a doctor to have multiple specialties, 
    # the list of possible specialties be driven from a database table,
    # and use a join table to associate doctors and their specialties + metadata
    expect(subject)
      .to validate_inclusion_of(:specialty).in_array(Doctor::SPECIALTIES)
  end
end

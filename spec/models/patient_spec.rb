require 'rails_helper'

describe Patient do
  subject { create :patient }

  it { is_expected.to be_valid }

  it_behaves_like 'a person'

  specify 'that the the validation rule for ailment exists' do
    expect(subject)
      .to validate_inclusion_of(:ailment).in_array(Patient::AILMENTS)
  end
end

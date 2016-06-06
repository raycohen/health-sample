require 'rails_helper'

describe Appointment do
  subject { create :appointment }

  it { is_expected.to be_valid }
end

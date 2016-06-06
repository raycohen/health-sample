FactoryGirl.define do
  factory :appointment do
    doctor
    patient
    start_time 4.days.from_now
  end
end

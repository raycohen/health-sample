class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.integer :doctor_id, null: false
      t.integer :patient_id, null: false
      t.datetime :start_time, null: false
      t.timestamps null: false
    end
  end
end

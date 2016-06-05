class AddAilmentToPatient < ActiveRecord::Migration
  def change
    add_column :patients, :ailment, :string
  end
end

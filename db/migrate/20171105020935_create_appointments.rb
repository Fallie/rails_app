class CreateAppointments < ActiveRecord::Migration[5.1]
  def change
    create_table :appointments do |t|
      t.datetime :appointment_time
      t.integer :duration,  limit: 4
	  t.integer :doctor_id,  limit: 4
	  t.integer :patient_id,  limit: 4 

      t.timestamps
    end
    add_index :appointments, :patient_id
 	add_index :appointments, :doctor_id
  end
end

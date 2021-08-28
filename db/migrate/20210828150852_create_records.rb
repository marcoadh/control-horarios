class CreateRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :records do |t|
      t.datetime :job_entry
      t.datetime :job_exit
      t.float :daily_hours
      t.references :employee, foreign_key: true

      t.timestamps
    end
  end
end

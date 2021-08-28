class CreateEmployees < ActiveRecord::Migration[5.2]
  def change
    create_table :employees do |t|
      t.string :nombre
      t.string :apellido

      t.timestamps
    end
  end
end

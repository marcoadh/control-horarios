class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.string :nombre
      t.string :apellido
      t.string :tipo
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end

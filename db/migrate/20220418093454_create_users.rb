class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :pc
      t.string :province
      t.string :phone
      t.string :email2
      t.references :role, null: false, foreign_key: true

      t.timestamps
    end
  end
end
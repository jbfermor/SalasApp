class CreateReservations < ActiveRecord::Migration[7.0]
  def change
    create_table :reservations do |t|
      t.date :day
      t.datetime :start_time
      t.datetime :end_time
      t.string :title
      t.text :description
      t.text :tools
      t.text :others
      t.references :user, null: false, foreign_key: true
      t.references :room, null: false, foreign_key: true
      t.references :tech, null: false, foreign_key: true

      t.timestamps
    end
  end
end

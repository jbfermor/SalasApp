class AddSuperToUser < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :super, foreign_key: {to_table: :users}
  end
end

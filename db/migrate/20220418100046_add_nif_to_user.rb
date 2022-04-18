class AddNifToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :nif, :string
  end
end

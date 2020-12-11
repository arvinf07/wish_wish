class AddDetailsColumn < ActiveRecord::Migration[5.2]
  def change
    add_column :wishes, :details, :string
  end
end

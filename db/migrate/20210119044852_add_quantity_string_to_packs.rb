class AddQuantityStringToPacks < ActiveRecord::Migration
  def change
    add_column :packs, :quantity_string, :string
  end
end

class AddBlurbToPacks < ActiveRecord::Migration
  def change
    add_column :packs, :blurb, :string
  end
end

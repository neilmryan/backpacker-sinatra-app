class AddPackIdToItems < ActiveRecord::Migration
  def change
    add_column :items, :pack_id, :integer
  end
end

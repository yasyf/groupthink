class AddGeneratedAtToList < ActiveRecord::Migration
  def change
    add_column :lists, :generated_at, :datetime
  end
end

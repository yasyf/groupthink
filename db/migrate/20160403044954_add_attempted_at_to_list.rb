class AddAttemptedAtToList < ActiveRecord::Migration
  def change
    add_column :lists, :attempted_at, :datetime
  end
end

class AddNoteToEnotes < ActiveRecord::Migration
  def change
    add_column :enotes, :note, :text
  end
end

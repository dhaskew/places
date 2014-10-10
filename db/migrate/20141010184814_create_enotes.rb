class CreateEnotes < ActiveRecord::Migration
  def change
    create_table :enotes do |t|
      t.references :user, index: true
      t.string :title
      t.string :guid

      t.timestamps
    end
  end
end

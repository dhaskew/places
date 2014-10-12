class CreateVisits < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.references :enote, index: true
      t.string :name
      t.string :link
      t.string :address
      t.integer :duration

      t.timestamps
    end
  end
end

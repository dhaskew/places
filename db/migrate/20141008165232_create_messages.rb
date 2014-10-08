class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.references :user, index: true
      t.text :text
      t.boolean :read, default: false 

      t.timestamps
    end
  end
end

class AddEvernoteToUsers < ActiveRecord::Migration
  def change
    add_column :users, :evernote_token, :string
    add_column :users, :evernote_token_dttm, :datetime
  end
end

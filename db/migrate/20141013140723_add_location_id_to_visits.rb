class AddLocationIdToVisits < ActiveRecord::Migration
  def change
    add_reference :visits, :location, index:true
  end
end

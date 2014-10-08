class Message < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :text
  validates_inclusion_of :read, in: [true, false]
end

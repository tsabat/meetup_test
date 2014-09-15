class CreateAttendances < ActiveRecord::Migration
  def change
    create_table :attendances do |t|
      t.belongs_to :event
      t.belongs_to :user

      t.string :status
      t.string :rsvp
      t.date :scheduled
      t.timestamps
    end
  end
end

class CreateRecordings < ActiveRecord::Migration[5.1]
  def change
    create_table :recordings do |t|
      t.references :caller, index:true, foreign_key: true
      t.datetime :call_date
      t.string :recording_folder
      t.boolean :copied_to_mp3, default: false

      t.timestamps
    end
  end
end

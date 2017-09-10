class AddTranscriptToRecordings < ActiveRecord::Migration[5.1]
  def change
    add_column :recordings, :transcript, :text
    add_index :recordings, :transcript 
  end
end

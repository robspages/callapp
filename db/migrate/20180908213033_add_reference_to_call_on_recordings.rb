class AddReferenceToCallOnRecordings < ActiveRecord::Migration[5.1]
  def change
  	add_reference :recordings, :call, index: true, foreign_key: true
  end
end

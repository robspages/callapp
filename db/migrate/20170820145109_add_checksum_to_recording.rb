class AddChecksumToRecording < ActiveRecord::Migration[5.1]
  def change
    add_column :recordings, :checksum, :string
    add_index :recordings, :checksum
  end
end

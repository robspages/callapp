class AddFilePathToRecordings < ActiveRecord::Migration[5.1]
  def change
    add_column :recordings, :file_path, :string
  end
end

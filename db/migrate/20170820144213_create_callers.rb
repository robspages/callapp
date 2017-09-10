class CreateCallers < ActiveRecord::Migration[5.1]
  def change
    create_table :callers do |t|
      t.text :name
      t.text :original_title
      t.text :notes

      t.timestamps
    end
  end
end

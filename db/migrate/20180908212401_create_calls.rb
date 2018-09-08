class CreateCalls < ActiveRecord::Migration[5.1]
  def change
    create_table :calls do |t|
      t.references :callers, index: true, foreign_key: true

      t.timestamps
    end
  end
end

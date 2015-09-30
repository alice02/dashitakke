class CreateSources < ActiveRecord::Migration
  def change
    create_table :sources do |t|
      t.string :src
      t.references :answer, index: true

      t.timestamps
    end
  end
end

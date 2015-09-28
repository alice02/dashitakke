class AddMimeToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :mime, :string
  end
end

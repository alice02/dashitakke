class AddExtensionToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :extension, :string
  end
end

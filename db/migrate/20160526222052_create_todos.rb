class CreateTodos < ActiveRecord::Migration
  def change
    create_table :todos do |t|
      t.text :text, null: false
      t.boolean :completed, null: false, default: false
      t.belongs_to :user, null: false
      t.timestamps null: false
    end
  end
end

class CreateFeedbacks < ActiveRecord::Migration[7.1]
  def change
    create_table :feedbacks do |t|
      t.references :call_session, null: false, foreign_key: true
      t.text :content

      t.timestamps
    end
  end
end

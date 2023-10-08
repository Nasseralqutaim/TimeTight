class CreateCallSessions < ActiveRecord::Migration[7.1]
  def change
    create_table :call_sessions do |t|
      t.references :initiator, null: false, foreign_key: { to_table: :users }
      t.references :recipient, null: false, foreign_key: { to_table: :users }
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
  end
end

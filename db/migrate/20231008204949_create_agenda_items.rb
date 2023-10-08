class CreateAgendaItems < ActiveRecord::Migration[7.1]
  def change
    create_table :agenda_items do |t|
      t.references :call_session, null: false, foreign_key: true
      t.text :description

      t.timestamps
    end
  end
end

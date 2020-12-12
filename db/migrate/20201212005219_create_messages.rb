class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.references :user, foreign_key: true
      t.references :channel, foreign_key: true
      t.text :content, null: false
      t.string :image

      t.timestamps
    end
  end
end

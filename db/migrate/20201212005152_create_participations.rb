class CreateParticipations < ActiveRecord::Migration[6.0]
  def change
    create_table :participations do |t|
      t.references :user, foreign_key: true
      t.references :channel, foreign_key: true

      t.timestamps
    end

    add_index :participations, [:user_id, :channel_id], unique: true
  end
end

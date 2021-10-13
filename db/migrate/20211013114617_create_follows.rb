class CreateFollows < ActiveRecord::Migration[6.1]
  def change
    create_table :follows do |t|
      t.references :follower_user, null: false
      t.references :followee_user, null: false

      t.timestamps
    end

    add_foreign_key :follows, :users, column: :follower_user_id
    add_foreign_key :follows, :users, column: :followee_user_id

  end
end

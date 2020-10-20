class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :avatar
      t.string :provider
      t.string :uid
      t.string :remember_digest
      t.boolean :user_role, default: true
      t.boolean :admin_role, default: false

      t.timestamps
    end
  end
end

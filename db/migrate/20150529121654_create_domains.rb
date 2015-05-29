class CreateDomains < ActiveRecord::Migration
  def change
    create_table :domains do |t|
      t.string :name
      t.date :expires_on
      t.integer :status

      t.timestamps null: false
    end
  end
end

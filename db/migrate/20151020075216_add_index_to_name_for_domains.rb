class AddIndexToNameForDomains < ActiveRecord::Migration
  def change
    add_index :domains, :name, unique: true
  end
end

class AddPropertiesToDomains < ActiveRecord::Migration
  def change
    add_column :domains, :properties, :json, default: {}, null: false
  end
end

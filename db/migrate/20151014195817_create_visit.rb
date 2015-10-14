class CreateVisit < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.integer :short_url_id
      t.integer :visitor_id
      t.timestamps
    end
  end
end

class CreateShortenedUrls < ActiveRecord::Migration
  def change
    create_table :shortened_urls do |t|
      t.string :submitter_id, null: false
      t.string :short_url, unique: true, null: false

      t.timestamps
    end
  end
end

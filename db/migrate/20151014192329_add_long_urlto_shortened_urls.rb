class AddLongUrltoShortenedUrls < ActiveRecord::Migration
  def change
    # a = ShortenedUrl.new
    # a.add_column(:long_url, :string)
    add_column :shortened_urls, :long_url, :string
  end
end

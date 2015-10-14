class Visit < ActiveRecord::Base

  def self.record_visit!(user, shortened_url)
    Visit.create!({"short_url_id" => shortened_url.id, "visitor_id"=> user.id})
  end

  belongs_to(
    :user,
    class_name: "User",
    foreign_key: :visitor_id,
    primary_key: :id
  )

  belongs_to(
    :short_url,
    class_name: "ShortenedUrl",
    foreign_key: :short_url_id,
    primary_key: :id
  )

end

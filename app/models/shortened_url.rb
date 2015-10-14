class ShortenedUrl < ActiveRecord::Base
  validates :short_url, presence: true, null: false

  belongs_to(
    :submitter,
    class_name: "User",
    foreign_key: :submitter_id,
    primary_key: :id
  )

  has_many(
    :visits,
    class_name: "Visit",
    foreign_key: :short_url_id,
    primary_key: :id
  )

  has_many(
    :visitors,
    through: :visits,
    source: :user
  )

  has_many(
    :distinct_visitors,
    Proc.new { distinct },
    through: :visits,
    source: :user
  )

  def self.create_for_user_and_long_url!(user, long_url)
    ShortenedUrl.create!({"submitter_id" => user.id, "short_url" => self.random_code, "long_url" => long_url })
  end

  def self.random_code
    include SecureRandom

    random_code = nil
    while random_code.nil? || ShortenedUrl.exists?(short_url: random_code)
      random_code = SecureRandom.urlsafe_base64
    end

    random_code
  end

  def num_clicks
    self.visits.count
  end

  def num_uniques
    self.distinct_visitors.select(:visitor_id).count
  end

  def num_recent_uniques
    self
      .distinct_visitors
      .select("users.id")
      .where("visits.created_at > ?", 10.minutes.ago)
      .count
    # <<-SQL
    #   SELECT
    #     users.*
    #   FROM
    #     users
    #   JOIN
    #     visits
    #   ON
    #     visits.visitor_id = users.id
    #   WHERE
    #     visits.shortened_url_id = #{ self.id }
    #
    # SQL
  end

end

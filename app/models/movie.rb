class Movie < ActiveRecord::Base
  def self.all_ratings
    self.uniq.order(:rating).pluck(:rating)
  end
end

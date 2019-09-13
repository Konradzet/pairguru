class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :movie

  validates :user, uniqueness: {scope: :movie_id}
end

class Post < ActiveRecord::Base
  has_and_belongs_to_many :tags
  validates :body, :title, presence: true

end

class Comment < ApplicationRecord

  belongs_to :user
  belongs_to :micropost
  has_many :comments, foreign_key: "post_parent_id", dependent: :destroy

    validates :user_id, presence: true
    validates :micropost_id, presence: true
    validates :body, presence: true, allow_blank: false


end

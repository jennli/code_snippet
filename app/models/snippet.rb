class Snippet < ActiveRecord::Base
  belongs_to :user
  belongs_to :language

  validates :title, presence:true, uniqueness:{scope: [:body, :language_id]}
  validates :body, presence:true

  validates :user, presence:true
  validates :language, presence:true
end

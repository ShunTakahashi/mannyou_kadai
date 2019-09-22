class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  scope :search_title, ->(title) { where("title LIKE ?", "%#{ title }%") }

  def self.search(search)
    return Task.all unless search
    Task.where(['title LIKE ?', "%#{search}%"])
  end

end


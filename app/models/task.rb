class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  scope :search_title, ->(title) { where("title LIKE ?", "%#{ title }%") }
  scope :search_content, ->(content) { where("content LIKE ?", "%#{ content }%") }

  def self.search(search,content)
    return Task.all unless search
    Task.where(['title LIKE ? AND content LIKE ?', "%#{search}%", "%#{content}%"])
  end

end


class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  # scope :search_title, ->(title) { where("title LIKE ?", "%#{ title }%") }
  # scope :search_content, ->(content) { where("content LIKE ?", "%#{ content }%") }

  def self.search(search, content, status)
    return Task.all unless search || content || status
    Task.where(['title LIKE ? AND content LIKE ? AND status LIKE ?', "%#{search}%", "%#{content}%", "#{status}"])
  end

end


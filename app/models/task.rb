class Task < ApplicationRecord
  belongs_to :user
  has_many :labelings, dependent: :destroy
  has_many :labels, through: :labelings, source: :label

  validates :title, presence: true
  validates :content, presence: true

  scope :created_desc, -> {order(created_at: :desc)}
  scope :expired_desc, -> {order(expired_at: :desc)}
  scope :expired_asc, -> {order(expired_at: :asc)}
  scope :sort_priority_asc, -> {order(priority: :asc)}
  scope :sort_priority_desc, -> {order(priority: :desc)}

  scope :search_title, ->(title) {where("title LIKE ?", "%#{ title }%")}
  scope :search_content, ->(content) {where("content LIKE ?", "%#{ content }%")}
  scope :search_status, -> (status) {where("status LIKE ?", "#{ status }%")}
  scope :search_title_content, ->(title, content) {where("title LIKE ? AND content LIKE ?", "%#{ title }%", "%#{content}%")}
  scope :search_title_status, ->(title, status) {where("title LIKE ? AND status LIKE ?", "%#{ title }%", "%#{status}%")}
  scope :search_content_status, ->(content, status) {where("content LIKE ? AND status LIKE ?", "%#{ content }%", "%#{ status }%")}
  scope :search_title_content_status, ->(title, content, status) {where("title LIKE ? AND content LIKE ? AND status LIKE ?", "%#{ title }%", "%#{ content }%", "%#{ status }%")}

  enum priority: { low: 0, middle: 1, high: 2 }



  def self.index_order(params)
    if params[:reload]
      created_desc
    elsif params[:sort_expired_asc]
      expired_asc
    elsif params[:sort_expired_desc]
      expired_desc
    elsif params[:sort_priority_asc]
      sort_priority_asc
    elsif params[:sort_priority_desc]
      sort_priority_desc
    elsif params[:task].present?
      if params[:task][:title].present? && params[:task][:content].present? && params[:task][:status].present?
        search_title_content_status(params[:task][:title], params[:task][:content], params[:task][:status])
      elsif params[:task][:title].present? && params[:task][:content].present?
        search_title_content(params[:task][:title], params[:task][:content]).created_desc
      elsif params[:task][:title].present? && params[:task][:status]
        search_title_status(params[:task][:title], params[:task][:status]).created_desc
      elsif params[:task][:content].present? && params[:task][:status]
        search_content_status(params[:task][:content], params[:task][:status]).created_desc
      elsif params[:task][:title].present?
        search_title(params[:task][:title]).created_desc
      elsif params[:task][:content].present?
        search_content(params[:task][:content]).created_desc
      elsif params[:task][:status].present?
        search_status(params[:task][:status]).created_desc
      elsif params[:task][:title].blank? && params[:task][:content].blank? && params[:task][:status].blank?
        created_desc
      end
    else
      created_desc
    end
  end


end
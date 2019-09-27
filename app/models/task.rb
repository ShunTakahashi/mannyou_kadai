class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  scope :search_title, ->(title) {where("title LIKE ?", "%#{ title }%")}
  scope :search_content, ->(content) {where("content LIKE ?", "%#{ content }%")}
  scope :search_status, -> (status) {where("status LIKE ?", "#{ status }%")}
  scope :search_title_content, ->(title, content) {where("title LIKE ? AND content LIKE ?", "%#{ title }%", "%#{content}%")}
  scope :search_title_status, ->(title, status) {where("title LIKE ? AND status LIKE ?", "%#{ title }%", "%#{status}%")}
  scope :search_content_status, ->(content, status) {where("content LIKE ? AND status LIKE ?", "%#{ content }%", "%#{ status }%")}
  scope :search_title_content_status, ->(title, content, status) {where("title LIKE ? AND content LIKE ? AND status LIKE ?", "%#{ title }%", "%#{ content }%", "%#{ status }%")}


  def self.index_order(params)
    if params[:sort_expired_asc]
      @tasks = Task.all.order(expired_at: :asc)
    elsif params[:sort_expired_desc]
      @tasks = Task.all.order(expired_at: :desc)
    elsif params[:task].present?
      if params[:task][:title].present? && params[:task][:content].present? && params[:task][:status].present?
        search_title_content_status(params[:task][:title], params[:task][:content], params[:task][:status])
      elsif params[:task][:title].present? && params[:task][:content].present?
        search_title_content(params[:task][:title], params[:task][:content])
      elsif params[:task][:title].present? && params[:task][:status]
        search_title_status(params[:task][:title], params[:task][:status])
      elsif params[:task][:content].present? && params[:task][:status]
        search_content_status(params[:task][:content], params[:task][:status])
      elsif params[:task][:title].present?
        search_title(params[:task][:title])
      elsif params[:task][:content].present?
        search_content(params[:task][:content])
      elsif params[:task][:status].present?
        search_status(params[:task][:status])
      end
    else
      @tasks = Task.all.order(created_at: :desc)
    end


  end

end


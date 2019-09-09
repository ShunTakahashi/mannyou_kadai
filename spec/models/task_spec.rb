require 'rails_helper'

RSpec.describe Task, type: :model do

  describe 'バリデーションチェック' do

    it 'Titleが空だと失敗すること' do
      task = Task.new(title: '', content: 'false')
      task.valid?
      expect(task.errors.messages[:title]).to include('を入力してください')
    end

    it 'Contentが空だと失敗すること' do
      task = Task.new(title: 'error', content: '')
      task.valid?
      expect(task.errors.messages[:content]).to include('を入力してください')
    end

    it 'Title,Contentが入力されていたら成功すること'do
      task = Task.new(title: 'true', content: 'true')
      expect(task).to be_valid
    end

  end
end
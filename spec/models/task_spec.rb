require 'rails_helper'

RSpec.describe Task, type: :model do

  describe 'バリデーションチェック' do

    let(:task) { create(:task) }

    it 'Titleが空だと失敗すること' do
      task.title = ''
      task.valid?
      expect(task.errors.messages[:title]).to include('を入力してください')
    end

    it 'Contentが空だと失敗すること' do
      task.content = ''
      task.valid?
      expect(task.errors.messages[:content]).to include('を入力してください')
    end

    it 'Title,Contentが入力されていたら成功すること' do
      expect(task).to be_valid
    end

  end
end
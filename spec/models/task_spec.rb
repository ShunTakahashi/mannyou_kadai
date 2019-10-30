require 'rails_helper'

RSpec.describe Task, type: :model do
  let(:task) {build(:task)}

  describe 'バリデーションチェック' do

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

  describe 'scopeチェック' do
    before do
      User.create(id: 1, name: 'test', email: 'test@sample', password: '123456778')
      Task.create(title: "1st", content: "1st", status: "not_yet_arrived", user_id: 1)
      Task.create(title: "1st", content: "2nd", status: "not_yet_arrived",user_id: 1)
      Task.create(title: "2nd", content: "1st", status: "complete",user_id: 1)
    end

    it 'search_title' do
      expect(Task.search_title("1st").count).to eq 2
    end

    it 'search_content' do
      expect(Task.search_content("1st").count).to eq 2
    end

    it 'search_status' do
      expect(Task.search_status("not_yet_arrived").count).to eq 2
    end

    it 'search_title_content' do
      expect(Task.search_title_content('1st', '2nd').count).to eq 1
    end

    it 'search_title_status' do
      expect(Task.search_title_status('1st', 'not_yet_arrived').count).to eq 2
    end

    it 'search_content_status' do
      expect(Task.search_content_status('1st', 'not_yet_arrived').count).to eq 1
    end

    it 'search_title_content_status' do
      expect(Task.search_title_content_status('1st', '2nd', 'not_yet_arrived').count).to eq 1
    end

  end
end
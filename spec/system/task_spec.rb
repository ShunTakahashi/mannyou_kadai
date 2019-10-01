require 'rails_helper'

RSpec.describe 'Task', type: :system do
  let(:task) {create(:task)}

  describe 'タスク一覧確認' do
    it 'タスク一覧が表示されること' do
      task
      visit root_path
      expect(page).to have_content task.title
      expect(page).to have_content task.content
      expect(Task.count).to eq 1
    end
  end

  describe 'タスク作成テスト' do
    it 'タスクが作成されること' do
      visit new_task_path
      fill_in 'タイトル', with: 'test1'
      fill_in '内容', with: 'content'
      click_on '登録する'
      expect(page).to have_content 'test1'
      expect(page).to have_content 'content'
    end
  end

  describe 'タスク詳細テスト' do
    it 'タスク詳細が表示されること' do
      task
      visit root_path
      click_on '詳細'
      expect(page).to have_content task.title
      expect(page).to have_content task.content
    end
  end

  describe 'タスクが作成日時の降順に並んでいるかのテスト' do
    it '降順に表示されること' do
      Task.create(title: '1', content: 'test!')
      Task.create(title: '2', content: 'test!!')
      Task.create(title: '3', content: 'test!!!')
      visit root_path
      expect(Task.order("created_at DESC").map(&:title)).to eq ["3", "2", "1"]
    end
  end

  describe '終了期限が正しく表示され、指定順番に並んでいること' do
    it '終了期限を指定通りに追加できていること' do
      Task.create(title: '1', content: 'test!', expired_at: Time.current + 2.day)
      Task.create(title: '2', content: 'test!', expired_at: Time.current + 3.day)
      Task.create(title: '3', content: 'test!', expired_at: Time.current + 4.day)
      visit root_path
      click_on '▼'
      expect(Task.order("expired_at DESC").map(&:title)).to eq ["3", "2", "1"]
      click_on '▲'
      expect(Task.order("expired_at ASC").map(&:title)).to eq ["1", "2", "3"]
    end
  end

  describe '優先度が正しく表示され、指定順番に並んでいること' do
    it '優先度を指定通りに追加できていること' do
      Task.create(title: '1', content: 'test!', priority: 0)
      Task.create(title: '2', content: 'test!', priority: 1)
      Task.create(title: '3', content: 'test!', priority: 2)
      visit root_path
      visit root_path
      click_on '△'
      expect(Task.order("priority ASC").map(&:title)).to eq ["1", "2", "3"]
      click_on '▽'
      expect(Task.order("priority DESC").map(&:title)).to eq ["3", "2", "1"]

    end
  end

end
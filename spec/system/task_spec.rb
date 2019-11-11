require 'rails_helper'

RSpec.describe 'Task', type: :system do
  let(:task) {create(:task)}

  before do
    FactoryBot.create(:test_user)
    visit new_session_path
    fill_in 'メールアドレス', with: 'test@sample'
    fill_in 'パスワード', with: '12345678'
    click_on 'ログイン'
  end

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
      Task.create(title: '1', content: 'test!', user_id: 2)
      visit root_path
      click_on '詳細'
      expect(page).to have_content '終了期限'
      expect(page).to have_content '優先度'
    end
  end

  describe 'タスクが作成日時の降順に並んでいるかのテスト' do
    it '降順に表示されること' do
      Task.create(title: '1', content: 'test!', user_id: 2)
      Task.create(title: '2', content: 'test!!', user_id: 2)
      Task.create(title: '3', content: 'test!!!', user_id: 2)
      visit root_path
      expect(Task.order("created_at DESC").map(&:title)).to eq ["3", "2", "1"]
    end
  end

  describe '終了期限が正しく表示され、指定順番に並んでいること' do
    it '終了期限を指定通りに追加できていること' do
      Task.create(title: '1', content: 'test!', expired_at: Time.current + 2.day, user_id: 2)
      Task.create(title: '2', content: 'test!', expired_at: Time.current + 3.day, user_id: 2)
      Task.create(title: '3', content: 'test!', expired_at: Time.current + 4.day, user_id: 2)
      visit root_path
      click_on '▼'
      expect(Task.order("expired_at DESC").map(&:title)).to eq ["3", "2", "1"]
      click_on '▲'
      expect(Task.order("expired_at ASC").map(&:title)).to eq ["1", "2", "3"]
    end
  end

  describe '優先度が正しく表示され、指定順番に並んでいること' do
    it '優先度を指定通りに追加できていること' do
      Task.create(title: '1', content: 'test!', priority: 0, user_id: 2)
      Task.create(title: '2', content: 'test!', priority: 1, user_id: 2)
      Task.create(title: '3', content: 'test!', priority: 2, user_id: 2)
      visit root_path
      visit root_path
      click_on '△'
      expect(Task.order("priority ASC").map(&:title)).to eq ["1", "2", "3"]
      click_on '▽'
      expect(Task.order("priority DESC").map(&:title)).to eq ["3", "2", "1"]
    end
  end

  describe 'ラベル作成テスト' do
    before do
      Label.create(id: 1, label_name: "勉強")
      Label.create(id: 2, label_name: "趣味")
    end
    it 'ラベルが正しく追加され、詳細ページに表示されること' do
      visit new_task_path
      fill_in 'タイトル', with: 'test1'
      fill_in '内容', with: 'content'
      check "task_label_ids_1"
      click_on '登録する'
      click_on '詳細'
      expect(page).to have_content '勉強'
    end

    it 'ラベル検索ができること' do

      visit new_task_path
      fill_in 'タイトル', with: 'test1'
      fill_in '内容', with: 'content'
      check "task_label_ids_1"
      click_on '登録する'

      visit new_task_path
      fill_in 'タイトル', with: 'test2'
      fill_in '内容', with: 'content'
      check "task_label_ids_2"
      click_on '登録する'

      root_path
      select '勉強', from: 'task_task_label_ids'
      click_on 'ラベル検索'
      expect(page).to have_content 'test1'

    end
  end

end
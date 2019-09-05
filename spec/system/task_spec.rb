require 'rails_helper'

RSpec.describe 'Task', type: :system do

  describe 'タスク一覧確認' do
      xit 'タスク一覧が表示されること' do
        task = FactoryBot.create(:task)
        visit root_path
        expect(page).to have_content task.title
        expect(page).to have_content task.content
        expect(Task.count).to eq 1
      end
  end

  describe 'タスク作成テスト' do
    xit 'タスクが作成されること' do
      visit new_task_path
      fill_in 'タイトル', with: 'test1'
      fill_in '内容',with: 'content'
      click_on '登録する'
      expect(page).to have_content 'test1'
      expect(page).to have_content 'content'
    end
  end

  describe 'タスク詳細テスト' do
    it 'タスク詳細が表示されること' do
    task = FactoryBot.create(:task)
    visit root_path
    click_on '詳細'
    expect(page).to have_content task.title
    expect(page).to have_content task.content
    end
  end
end


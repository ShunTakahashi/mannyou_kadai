require 'rails_helper'

RSpec.feature "タスク管理機能", type: :feature do

  scenario "タスク一覧のテスト" do
    Task.create!(title: 'test_task_01', content: 'testtesttest')
    Task.create!(title: 'test_task_02', content: 'samplesample')
    visit tasks_path
    expect(page).to have_content 'testtesttest'
    expect(page).to have_content 'samplesample'
  end

  scenario "タスク作成のテスト" do
    visit new_task_path
    fill_in '予定', with: 'タスク名'
    fill_in 'コメント', with: 'タスク詳細'
    click_on '登録する'
    expect(page).to have_content 'タスク名'
    expect(page).to have_content 'タスク詳細'
  end

  scenario "タスク詳細のテスト" do
    Task.create!(title: 'test', content: 'test!!!')
    visit tasks_path
    click_on 'Show'
    expect(page).to have_content 'test'
    expect(page).to have_content 'test!!!'
  end
end
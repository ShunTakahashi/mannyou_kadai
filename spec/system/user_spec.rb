require 'rails_helper'

RSpec.describe 'User', type: :system do
  before do
    FactoryBot.create(:user)
    FactoryBot.create(:test_user)
  end

  describe "アカウント作成" do
    it 'アカウントが作成され、同時にログインされること' do
      visit new_user_path
      fill_in '名前', with: 'true'
      fill_in 'メールアドレス', with: 'testtt@sample'
      fill_in 'パスワード', with: 'password'
      fill_in '確認用パスワード', with: 'password'
      click_on '登録する'
      expect(page).to have_content 'true'
    end
  end

  describe 'ログイン' do
    it 'ログイン後マイページにジャンプすること' do
      visit new_session_path
      fill_in 'メールアドレス', with: 'test@sample'
      fill_in 'パスワード', with: '12345678'
      click_on 'ログイン'
      expect(page).to have_content 'test'
    end

    it 'ログイン時にマイページへのリンクが表示されること' do
      visit new_session_path
      fill_in 'メールアドレス', with: 'test@sample'
      fill_in 'パスワード', with: '12345678'
      click_on 'ログイン'
      expect(page).to have_content 'MyPage'
    end

    it 'ログイン状態でログアウトができること' do
      visit new_session_path
      fill_in 'メールアドレス', with: 'test@sample'
      fill_in 'パスワード', with: '12345678'
      click_on 'ログイン'
      click_on 'ログアウト'
      expect(page).to have_content 'ログイン'
    end
  end

  describe 'ログイン失敗時' do
    it '失敗時にログイン画面に戻ること' do
      visit new_session_path
      fill_in 'メールアドレス', with: 'aaa'
      fill_in 'パスワード', with: 'aaa'
      click_on 'ログイン'
      expect(page).to have_content 'Login'
    end
  end


  describe "他のユーザーとの関係" do
    it 'user2でログインした場合user2のタスクが表示されること' do
      Task.create(title: "false", content: "false", status: "not_yet_arrived", user_id: 1)
      Task.create(title: "true", content: "true", status: "not_yet_arrived", user_id: 2)
      visit new_session_path
      fill_in 'メールアドレス', with: 'test@sample'
      fill_in 'パスワード', with: '12345678'
      click_on 'ログイン'
      visit tasks_path
      expect(page).to have_content 'true'
    end

    it "user2でログインした場合user1のタスクが表示されないこと" do
      Task.create(title: "false", content: "false", status: "not_yet_arrived", user_id: 1)
      Task.create(title: "true", content: "true", status: "not_yet_arrived", user_id: 2)
      visit new_session_path
      fill_in 'メールアドレス', with: 'test@sample'
      fill_in 'パスワード', with: '12345678'
      click_on 'ログイン'
      visit tasks_path
      expect(page).not_to have_content 'false'
    end

    it "他人のマイページにアクセスできないことを確認する" do
      visit new_session_path
      fill_in 'メールアドレス', with: 'test@sample'
      fill_in 'パスワード', with: '12345678'
      click_on 'ログイン'
      visit user_path(2)
      expect(page).to_not have_content 'test1'
    end
  end
end
#save_and_open_pag
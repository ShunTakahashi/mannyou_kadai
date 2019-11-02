require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) {build(:user)}

  describe 'バリデーションチェック' do

    it 'Nameが空だと失敗すること' do
      user.name = ''
      user.valid?
      expect(user.errors[:name]).to include('を入力してください')
    end

    it 'Emailが空だと失敗すること' do
      user.email = ''
      user.valid?
      expect(user.errors[:email]).to include('を入力してください')
    end

    it 'Emailが重複していると失敗すること' do
      User.create(email: 'foo@example.com')
      @user = User.create(email: 'foo@example.com')
      expect(@user.save).to be_falsey
    end

    it 'Passwordが空だと失敗すること' do
      expect(FactoryBot.build(:user, password: "")).to_not be_valid
    end

    it 'Passwordが8文字以内だと失敗すること' do
      @user = FactoryBot.build(:user, password: "a" * 6, password_confirmation: "a" * 6)
      expect(@user).to be_invalid
    end

    it 'PasswordとPassword_confirmationが一致しなければ失敗すること' do
      @user = FactoryBot.build(:user, password: "a" * 9, password_confirmation: "a" * 10)
      expect(@user).to be_invalid
    end

  end
end

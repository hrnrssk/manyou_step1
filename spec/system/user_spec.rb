require 'rails_helper'
RSpec.describe 'ユーザー機能', type: :system do
  describe 'ユーザー登録のテスト' do
    context 'ユーザーを新規に登録した場合' do
      it 'サインインできること' do
        # new_user_pathに遷移する（ユーザーの新規作成ページに遷移する）
        visit new_user_path
        fill_in 'ユーザー名', with: 'Mr_test1'
        fill_in 'メールアドレス', with: 'mr_test1@g.com'
        fill_in 'パスワード', with: '111111'
        fill_in '確認用パスワード', with: '111111'
        click_on 'Create my account'
        expect(page).to have_content 'Mr_test1'
        expect(page).to have_content 'mr_test1@g.com'
      end
    end
    context 'ユーザがログインせずタスク一覧画面に飛ぼうとした場合' do
      it 'ログイン画面に遷移すること' do
        # 一覧画面に遷移する
        visit tasks_path
        expect(page).to have_content 'ログインしてください'
      end
    end
  end
  describe 'セッション機能のテスト' do
    context '一般ユーザーの場合' do
      before do
        @user_a = FactoryBot.create(:user, user_name: 'ユーザーA', email: 'a@example.com')
        visit new_user_path
        fill_in 'ユーザー名', with: 'Mr_test1'
        fill_in 'メールアドレス', with: 'mr_test1@g.com'
        fill_in 'パスワード', with: '111111'
        fill_in '確認用パスワード', with: '111111'
        click_on 'Create my account'
      end
      it 'ログインができてマイページに飛べること' do
        # new_session_pathに遷移する（ログイン画面に遷移する）
        visit new_session_path
        fill_in 'Email', with: 'mr_test1@g.com'
        fill_in 'Password', with: '111111'
        click_on 'Log in'
        expect(page).to have_content 'Mr_test1'
        expect(page).to have_content 'mr_test1@g.com'
      end
      it '一般ユーザが他人の詳細画面に飛ぶとタスク一覧画面に遷移すること' do
        # task_pathに遷移する（他人の詳細画面に遷移する）
        visit user_path(@user_a.id)
        # binding.irb
        expect(page).to have_content 'タスク一覧'
      end
      it 'ログアウトができること' do
        # task_pathに遷移する（他人の詳細画面に遷移する）
        click_on 'Logout'
        # binding.irb
        expect(page).to have_content 'ログアウトしました'
      end
    end
  end
end
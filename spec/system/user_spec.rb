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
  describe '管理画面のテスト' do
    context '管理ユーザーの場合' do
      before do
        @user_ad = FactoryBot.create(:user, user_name: 'アドミン', email: 'admin@example.com')
        @user_pub = FactoryBot.create(:second_user, user_name: 'ユーザーP', email: 'pub@example.com')
        visit new_session_path
        fill_in 'Email', with: 'admin@example.com'
        fill_in 'Password', with: '111111'
        click_on 'Log in'
      end
      it '管理画面にアクセスできること' do
        # visit admin_users_pathに遷移する（ログイン画面に遷移する）
        visit admin_users_path
        expect(page).to have_content '管理画面のユーザー一覧画面'
      end
      it 'ユーザーの新規登録ができること' do
        visit admin_users_path
        click_on 'ユーザーの新規作成'
        fill_in 'ユーザー名', with: 'Mr_test2'
        fill_in 'メールアドレス', with: 'mr_test2@g.com'
        fill_in 'パスワード', with: '222222'
        fill_in '確認用パスワード', with: '222222'
        click_on 'Create my account'
        expect(page).to have_content 'Mr_test2'
        expect(page).to have_content '詳細'
        expect(page).to have_content '削除'
      end
      it 'ユーザーの詳細画面にアクセスできること' do
        visit admin_users_path
        # binding.irb
        all('tr td')[6].click_on '詳細'
        expect(page).to have_content 'ユーザーP'
        expect(page).to have_content 'pub@example.com'
      end
      it 'ユーザの編集画面からユーザを編集できること' do
        visit admin_users_path
        all('tr td')[6].click_on '詳細'
        click_on 'プロフィール編集'
        fill_in 'ユーザー名', with: 'ユーザーP2'
        fill_in 'パスワード', with: '222222'
        fill_in '確認用パスワード', with: '222222'
        click_on '更新する'
        expect(page).to have_content 'ユーザーP2'
        expect(page).to have_content 'pub@example.com'
      end
      it 'ユーザの削除ができること' do
        visit admin_users_path
        all('tr td')[7].click_on '削除'
        page.accept_confirm "Are you sure?"
        expect(page).to have_content 'ユーザーは削除されました'
        binding.irb
      end
    end
    context '一般ユーザーの場合' do
      before do
        @user_ad = FactoryBot.create(:user, user_name: 'アドミン', email: 'admin@example.com')
        @user_pub = FactoryBot.create(:second_user, user_name: 'ユーザーP', email: 'pub@example.com')
        visit new_session_path
        fill_in 'Email', with: 'pub@example.com'
        fill_in 'Password', with: '222222'
        click_on 'Log in'
      end
      it '管理画面にアクセスできないこと' do
        visit admin_users_path
        expect(page).to have_content 'タスク一覧'
        binding.irb
      end
    end
  end
end
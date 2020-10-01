require 'rails_helper'
RSpec.describe 'ユーザー登録', type: :system do
  describe 'ユーザーの新規登録機能' do
    context 'ユーザーを新規に登録した場合' do
      it 'サインインできること' do
        # new_user_pathに遷移する（新規作成ページに遷移する）
        visit new_user_path
        # 新規登録内容を入力する
        #「タスク名」というラベル名の入力欄と、「タスク詳細」というラベル名の入力欄にタスクのタイトルと内容をそれぞれ入力する
        # ここに「タスク名」というラベル名の入力欄に内容をfill_in（入力）する処理を書く
        fill_in 'ユーザー名', with: 'Mr_test1'
        # ここに「タスク詳細」というラベル名の入力欄に内容をfill_in（入力）する処理を書く
        fill_in 'メールアドレス', with: 'mr_test1@g.com'
        fill_in 'パスワード', with: '111111'
        fill_in '確認用パスワード', with: '111111'
        # binding.irb
        # @user = FactoryBot.create(:user)
        # allow(controller).to receive(:current_user).and_return(@user)
        click_on 'Create my account'
        # clickで登録されたはずの情報が、ユーザー詳細ページに表示されているかを確認する
        # ここにユーザー詳細ページに、テストコードで作成したデータがタスク詳細画面にhave_contentされているか（含まれているか）を確認（期待）するコードを書く
        expect(page).to have_content 'Mr_test1'
        expect(page).to have_content 'mr_test1@g.com'
      end
    end
  end
end
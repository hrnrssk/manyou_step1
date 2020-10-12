require 'rails_helper'
RSpec.describe 'ラベル機能', type: :system do
  describe 'ラベル作成機能' do
    before do
      user_a = FactoryBot.create(:user, user_name: 'ユーザーA', email: 'a@example.com')
      FactoryBot.create(:task, name: '最初のタスク', detail: 'テスト１', deadline: '2020/08/10', status: '未着手', priority: '低', user: user_a)
      FactoryBot.create(:second_task, name: '二番目のタスク', detail: 'テスト２', deadline: '2020/08/20', status: '着手中', priority: '中', user: user_a)
      FactoryBot.create(:third_task, name: '三番目のタスク', detail: 'テスト３', deadline: '2020/08/30', status: '完了', priority: '高', user: user_a)
    end
    context 'ユーザーAがログインしているとき' do
      before do 
        visit new_session_path
        fill_in 'Email', with: 'a@example.com'
        fill_in 'Password', with: '111111'
        click_on 'Log in'
      end
      it '複数のラベルが付いたタスクを作成できる' do
        # 1. new_task_pathに遷移する（新規作成ページに遷移する）
        # ここにnew_task_pathにvisitする処理を書く
        visit new_task_path
        # 2. 新規登録内容を入力する
        #「タスク名」というラベル名の入力欄と、「タスク詳細」というラベル名の入力欄にタスクのタイトルと内容をそれぞれ入力する
        # ここに「タスク名」というラベル名の入力欄に内容をfill_in（入力）する処理を書く
        fill_in 'タスク名', with: 'テスト０１'
        # ここに「タスク詳細」というラベル名の入力欄に内容をfill_in（入力）する処理を書く
        fill_in '内容', with: 'テスト０１をテストする'
        select "2020", from: "task[deadline(1i)]"
        select "8月", from: "task[deadline(2i)]"
        select "27", from: "task[deadline(3i)]"
        select '未着手', from: '状態'
        select '低', from: '優先順位'
        # binding.irb
        check 'task_label_ids_1'
        check 'task_label_ids_2'
        # 3. 「登録する」というvalue（表記文字）のあるボタンをクリックする
        # ここに「登録する」というvalue（表記文字）のあるボタンをclick_onする（クリックする）する処理を書く
        click_on '登録する'
        sleep 1
        # binding.irb
        expect(page).to have_content 'テスト０１'
        expect(page).to have_content 'テスト０１をテストする'
        expect(page).to have_content '2020-08-27'
        expect(page).to have_content '未着手'
        expect(page).to have_content '低'
        expect(page).to have_content 'sample1'
        expect(page).to have_content 'sample2'
      end
    end
  end
  describe 'FactoryBotでのタスク作成' do
    before do
      user_a = FactoryBot.create(:user, user_name: 'ユーザーA', email: 'a@example.com')
      FactoryBot.create(:task, name: '最初のタスク', detail: 'テスト１', deadline: '2020/08/10', status: '未着手', priority: '低', user: user_a)
      FactoryBot.create(:second_task, name: '二番目のタスク', detail: 'テスト２', deadline: '2020/08/20', status: '着手中', priority: '中', user: user_a)
      FactoryBot.create(:third_task, name: '三番目のタスク', detail: 'テスト３', deadline: '2020/08/30', status: '完了', priority: '高', user: user_a)
    end
    context 'FactoryBotでラベルに紐づいたタスクを作成できる' do
      before do
        visit new_session_path
        fill_in 'Email', with: 'a@example.com'
        fill_in 'Password', with: '111111'
        click_on 'Log in'
      end
      it 'タスク一覧画面にラベル付きタスクが表示される' do
        visit tasks_path
        expect(page).to have_content 'sample1'
        expect(page).to have_content 'sample2'
      end
    end
  end
  describe 'ラベル検索機能' do
    before do
      user_a = FactoryBot.create(:user, user_name: 'ユーザーA', email: 'a@example.com')
      FactoryBot.create(:task, name: '最初のtask', detail: 'テスト１', deadline: '2020/08/10', status: '完了', priority: '低', user: user_a)
      FactoryBot.create(:second_task, name: '二番目のタスク', detail: 'テスト２', deadline: '2020/08/20', status: '未着手', priority: '中', user: user_a)
      FactoryBot.create(:third_task, name: '三番目のタスク', detail: 'テスト３', deadline: '2020/08/30', status: '未着手', priority: '高', user: user_a)
    end
    context 'ユーザーAがログインしているとき' do
      before do
        visit new_session_path
        fill_in 'Email', with: 'a@example.com'
        fill_in 'Password', with: '111111'
        click_on 'Log in'
      end
      it 'ラベルのみで検索できる' do
        visit tasks_path
        select 'sample1', from: 'task_label_id'
        click_on '検索'
        # binding.irb
        expect(page).to have_content '最初のtask'
        expect(page).not_to have_content '二番目のタスク'
        expect(page).not_to have_content '三番目のタスク'
      end
      it 'タスク名と状態とラベルで検索できる' do
        visit tasks_path
        fill_in 'タスク名で検索', with: 'タスク'
        select '未着手', from: '状態'
        select 'sample5', from: 'task_label_id'
        click_on '検索'
        # binding.irb
        expect(page).not_to have_content '最初のtask'
        expect(page).not_to have_content '二番目のタスク'
        expect(page).to have_content '三番目のタスク'
      end
    end
  end
end
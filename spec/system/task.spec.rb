require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  # let(:task_let) { FactoryBot.create(:task, name: '最初のタスク', detail: 'テスト', deadline: '2020/08/01', status: '未着手', priority: '低', user: user_a) }
  describe '新規作成機能' do
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
      it 'ユーザーAが作成したタスクが表示される' do
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
        # fill_in '終了期限', with: '2020/08/27'
        select '未着手', from: '状態'
        select '低', from: '優先順位'
        # 3. 「登録する」というvalue（表記文字）のあるボタンをクリックする
        # ここに「登録する」というvalue（表記文字）のあるボタンをclick_onする（クリックする）する処理を書く
        # current_user = @user
        # binding.irb
        click_on '登録する'
        # 4. clickで登録されたはずの情報が、タスク詳細ページに表示されているかを確認する
        # （タスクが登録されたらタスク詳細画面に遷移されるという前提）
        # ここにタスク詳細ページに、テストコードで作成したデータがタスク詳細画面にhave_contentされているか（含まれているか）を確認（期待）するコードを書く
        expect(page).to have_content 'テスト０１'
        expect(page).to have_content 'テスト０１をテストする'
        expect(page).to have_content '2020-08-27'
        expect(page).to have_content '未着手'
        expect(page).to have_content '低'
      end
    end
  end

  describe '一覧表示機能' do
    before do
      user_a = FactoryBot.create(:user, user_name: 'ユーザーA', email: 'a@example.com')
      FactoryBot.create(:task, name: '最初のタスク', detail: 'テスト１', deadline: '2020/08/10', status: '未着手', priority: '低', user: user_a)
      FactoryBot.create(:second_task, name: '二番目のタスク', detail: 'テスト２', deadline: '2020/08/20', status: '着手中', priority: '中', user: user_a)
      FactoryBot.create(:third_task, name: '三番目のタスク', detail: 'テスト３', deadline: '2020/08/30', status: '完了', priority: '高', user: user_a)
    end
    context '一覧画面に遷移した場合' do
      before do
        visit new_session_path
        fill_in 'Email', with: 'a@example.com'
        fill_in 'Password', with: '111111'
        click_on 'Log in'
      end
      it '作成済みのタスク一覧が表示される' do
        # テストで使用するためのタスクを作成
        # task = FactoryBot.create(:task, name: 'task', detail: 'テスト', deadline: '2020/08/31', status: '未着手', priority: '1', author: 'sasaki')
        # task = task_let
        # タスク一覧ページに遷移
        # click_on 'タスク一覧へ'
        visit tasks_path
        # binding.irb
        # click_on 'タスク登録'
        # fill_in 'タスク名', with: '最初のタスク'
        # fill_in '内容', with: '最初のタスクを行う'
        # select "2020", from: "task[deadline(1i)]"
        # select "8月", from: "task[deadline(2i)]"
        # select "27", from: "task[deadline(3i)]"
        # select '未着手', from: '状態'
        # select '低', from: '優先順位'
        # click_on '登録する'
        # visit tasks_path
        # visitした（遷移した）page（タスク一覧ページ）に「task」という文字列が
        # have_contentされているか（含まれているか）ということをexpectする（確認・期待する）
        expect(page).to have_content '最初のタスク'
        # expectの結果が true ならテスト成功、false なら失敗として結果が出力される
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      before do
        visit new_session_path
        fill_in 'Email', with: 'a@example.com'
        fill_in 'Password', with: '111111'
        click_on 'Log in'
      end
      it '新しいタスクが一番上に表示される' do
        # テストで使用するためのタスクを作成
        # task = task_let
        # タスク一覧ページに遷移
        visit tasks_path
        task_list = all('.task_row')
        # binding.irb
        expect(task_list[0]).to have_content '三番目'
      end
    end
    context 'タスクが終了期限の降順にソートされている場合' do
      before do
        visit new_session_path
        fill_in 'Email', with: 'a@example.com'
        fill_in 'Password', with: '111111'
        click_on 'Log in'
      end
      it '"終了期限でソートする"ボタンを押すと終了期限が遅いタスクから降順で並び替えられる' do
        # テストで使用するためのタスクを作成
        # task = task_let
        # タスク一覧ページに遷移
        visit tasks_path
        click_on '終了期限でソートする'
        expect(all('.task_row')[0]).to have_content '2020-08-30'
        expect(all('.task_row')[1]).to have_content '2020-08-20'
        expect(all('.task_row')[2]).to have_content '2020-08-10'
        # binding.irb
        # all('tr td')[6].click_on '詳細'
        # expect(page).to have_content '2020/08/20'
      end
    end
    context 'タスクが優先順位の高い順にソートされている場合' do
      before do
        visit new_session_path
        fill_in 'Email', with: 'a@example.com'
        fill_in 'Password', with: '111111'
        click_on 'Log in'
      end
      it '"優先順位でソートする"ボタンを押すと優先順位が高いタスクから順に並び替えられる' do
        # テストで使用するためのタスクを作成
        # task = task_let
          # タスク一覧ページに遷移
        visit tasks_path
        click_on '優先順位でソートする'
        # binding.irb
        expect(all('.task_row')[0]).to have_content '高'
        expect(all('.task_row')[1]).to have_content '中'
        expect(all('.task_row')[2]).to have_content '低'
        # binding.irb
        # all('tr td')[6].click_on '詳細'
        # expect(page).to have_content '高'
      end
    end
  end
  describe '詳細表示機能' do
    before do
      user_a = FactoryBot.create(:user, user_name: 'ユーザーA', email: 'a@example.com')
      FactoryBot.create(:task, name: '最初のタスク', detail: 'テスト１', deadline: '2020/08/10', status: '未着手', priority: '低', user: user_a)
      FactoryBot.create(:second_task, name: '二番目のタスク', detail: 'テスト２', deadline: '2020/08/20', status: '着手中', priority: '中', user: user_a)
      FactoryBot.create(:third_task, name: '三番目のタスク', detail: 'テスト３', deadline: '2020/08/30', status: '完了', priority: '高', user: user_a)
    end
    context '任意のタスク詳細画面に遷移した場合' do
      before do
        visit new_session_path
        fill_in 'Email', with: 'a@example.com'
        fill_in 'Password', with: '111111'
        click_on 'Log in'
      end
      it '該当タスクの内容が表示される' do
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
        # 3. 「登録する」というvalue（表記文字）のあるボタンをクリックする
        # ここに「登録する」というvalue（表記文字）のあるボタンをclick_onする（クリックする）する処理を書く
        click_on '登録する'
        expect(page).to have_content 'テスト０１'
      end
    end
  end
  describe 'タスク管理機能', type: :system do
    describe '検索機能' do
      before do
        user_a = FactoryBot.create(:user, user_name: 'ユーザーA', email: 'a@example.com')
        FactoryBot.create(:task, name: '最初のタスク', detail: 'テスト１', deadline: '2020/08/10', status: '未着手', priority: '低', user: user_a)
        FactoryBot.create(:second_task, name: '二番目のタスク', detail: 'テスト２', deadline: '2020/08/20', status: '着手中', priority: '中', user: user_a)
        FactoryBot.create(:third_task, name: '三番目のタスク', detail: 'テスト３', deadline: '2020/08/30', status: '完了', priority: '高', user: user_a)
      end
      context 'タイトルであいまい検索をした場合' do
        before do
          visit new_session_path
          fill_in 'Email', with: 'a@example.com'
          fill_in 'Password', with: '111111'
          click_on 'Log in'
        end
        it "検索キーワードを含むタスクで絞り込まれる" do
          visit tasks_path
          # タスクの検索欄に検索ワードを入力する (例: task)
          fill_in 'タスク名で検索', with: '最初'
          # 検索ボタンを押す
          click_on '検索'
          expect(page).to have_content '最初'
          expect(page).not_to have_content '二番目'
        end
      end
      context 'ステータス検索をした場合' do
        before do
          visit new_session_path
          fill_in 'Email', with: 'a@example.com'
          fill_in 'Password', with: '111111'
          click_on 'Log in'
        end
        it "ステータスに完全一致するタスクが絞り込まれる" do
          # ここに実装する
          # プルダウンを選択する「select」について調べてみること
          visit tasks_path
          select '未着手', from: '状態'
          click_on '検索'
          expect(page).to have_content '未着手'
        end
      end
      context 'タイトルのあいまい検索とステータス検索をした場合' do
        before do
          visit new_session_path
          fill_in 'Email', with: 'a@example.com'
          fill_in 'Password', with: '111111'
          click_on 'Log in'
        end
        it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
          # ここに実装する
          visit tasks_path
          fill_in 'タスク名で検索', with: 'タスク'
          select '未着手', from: '状態'
          click_on '検索'
          expect(page).to have_content '最初'
        end
      end
    end
  end
end
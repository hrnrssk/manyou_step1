require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'タスクモデル機能', type: :model do
    describe 'バリデーションのテスト' do
      context 'タスクのタイトルが空の場合' do
        it 'バリデーションにひっかる' do
          task = Task.new(name: '', detail: '失敗テスト', deadline: '2020/08/31', status: '未着手', priority: '高', author: 'sasaki')
          expect(task).not_to be_valid
        end
      end
      context 'タスクの詳細が空の場合' do
        it 'バリデーションにひっかかる' do
          task = Task.new(name: '失敗テスト', detail: '', deadline: '2020/08/31', status: '未着手', priority: '高', author: 'sasaki')
          expect(task).not_to be_valid
        end
      end
      context 'タスクのタイトルと詳細に内容が記載されている場合' do
        it 'バリデーションが通る' do
          task = Task.new(name: '成功テスト', detail: '成功テスト', deadline: '2020/08/31', status: '未着手', priority: '高', author: 'sasaki')
          expect(task).to be_valid
        end
      end
    end
    describe '検索機能' do
      before do
        FactoryBot.create(:task, name: "テスト1", detail: 'テスト1', deadline: '2020/08/1', status: '着手中', priority: '高', author: 'sasaki')
        FactoryBot.create(:second_task, name: "タスク2", detail: 'テスト2', deadline: '2020/08/2', status: '未着手', priority: '中', author: 'hironori')
        FactoryBot.create(:third_task, name: "タスク3", detail: 'テスト3', deadline: '2020/08/10', status: '未着手', priority: '低', author: 'hironori')
      end
      context 'scopeメソッドでタイトルのあいまい検索をした場合' do
        it "検索キーワードを含むタスクが絞り込まれる" do
          # title_seachはscopeで提示したタイトル検索用メソッドである。メソッド名は任意で構わない。
          # 'task'は検索文字列
          expect(Task.search_with_name('テスト1').count).to eq 1
          expect(Task.search_with_name('テスト1').count).not_to eq 2
          expect(Task.search_with_name('タスク2').count).to eq 1
        end
      end
      context 'scopeメソッドでステータス検索をした場合' do
        it "ステータスに完全一致するタスクが絞り込まれる" do
          # ここに内容を記載する
          expect(Task.search_with_status('未着手').count).to eq 2
          expect(Task.search_with_status('着手中').count).to eq 1
        end
      end
      context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
        it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
          # ここに内容を記載する
          expect(Task.search_with_name_and_status('タスク3', '未着手').count).to eq 1
        end
      end
    end
  end
end
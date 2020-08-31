require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'タスクモデル機能', type: :model do
    describe 'バリデーションのテスト' do
      context 'タスクのタイトルが空の場合' do
        it 'バリデーションにひっかる' do
          task = Task.new(name: '', detail: '失敗テスト', deadline: '2020/08/31', status: '未着手', priority: '1', author: 'sasaki')
          expect(task).not_to be_valid
        end
      end
      context 'タスクの詳細が空の場合' do
        it 'バリデーションにひっかかる' do
          task = Task.new(name: '失敗テスト', detail: '', deadline: '2020/08/31', status: '未着手', priority: '1', author: 'sasaki')
          expect(task).not_to be_valid
        end
      end
      context 'タスクのタイトルと詳細に内容が記載されている場合' do
        it 'バリデーションが通る' do
          task = Task.new(name: '成功テスト', detail: '成功テスト', deadline: '2020/08/31', status: '未着手', priority: '1', author: 'sasaki')
          expect(task).to be_valid
        end
      end
    end
  end
end
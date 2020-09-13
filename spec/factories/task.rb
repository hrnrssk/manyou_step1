# 「FactoryBotを使用します」という記述
FactoryBot.define do
    # 作成するテストデータの名前を「task」とします
    # （実際に存在するクラス名と一致するテストデータの名前をつければ、そのクラスのテストデータを自動で作成します）
    factory :task do
      name { 'Factoryで作ったデフォルトのタスク１' }
      detail { 'Factoryで作ったデフォルトのコンテント１' }
      # deadline { 'Factoryで作ったデフォルトの終了期限１' }
      deadline { '2020/08/10' }
      status { 'Factoryで作ったデフォルトの状態１' }
      priority { 'Factoryで作ったデフォルトの優先順位１' }
      author { 'Factoryで作ったデフォルトの作者１' }
    end
    # 作成するテストデータの名前を「second_task」とします
    # （存在しないクラス名の名前をつける場合、オプションで「このクラスのテストデータにしてください」と指定します）
    factory :second_task, class: Task do
      name { 'Factoryで作ったデフォルトのタスク２' }
      detail { 'Factoryで作ったデフォルトのコンテント２' }
      # deadline { 'Factoryで作ったデフォルトの終了期限２' }
      deadline { '2020/08/20' }
      status { 'Factoryで作ったデフォルトの状態２' }
      priority { 'Factoryで作ったデフォルトの優先順位２' }
      author { 'Factoryで作ったデフォルトの作者２' }
    end
    factory :third_task, class: Task do
      name { 'Factoryで作ったデフォルトのタスク3' }
      detail { 'Factoryで作ったデフォルトのコンテント3' }
      # deadline { 'Factoryで作ったデフォルトの終了期限２' }
      deadline { '2020/08/10' }
      status { 'Factoryで作ったデフォルトの状態3' }
      priority { 'Factoryで作ったデフォルトの優先順位3' }
      author { 'Factoryで作ったデフォルトの作者3' }
    end
end
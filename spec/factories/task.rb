# 「FactoryBotを使用します」という記述
FactoryBot.define do
    # 作成するテストデータの名前を「task」とします
    # （実際に存在するクラス名と一致するテストデータの名前をつければ、そのクラスのテストデータを自動で作成します）
    factory :task do
      name { 'Factoryで作ったデフォルトのタスク１' }
      detail { 'Factoryで作ったデフォルトのコンテント１' }
      deadline { 'Factoryで作ったデフォルトの終了期限１' }
      status { 'Factoryで作ったデフォルトの状態１' }
      priority { 'Factoryで作ったデフォルトの優先順位１' }
      author { 'Factoryで作ったデフォルトの作者１' }
    end
    # 作成するテストデータの名前を「second_task」とします
    # （存在しないクラス名の名前をつける場合、オプションで「このクラスのテストデータにしてください」と指定します）
    factory :second_task, class: Task do
      name { 'Factoryで作ったデフォルトのタスク２' }
      detail { 'Factoryで作ったデフォルトのコンテント２' }
      deadline { 'Factoryで作ったデフォルトの終了期限２' }
      status { 'Factoryで作ったデフォルトの状態２' }
      priority { 'Factoryで作ったデフォルトの優先順位２' }
      author { 'Factoryで作ったデフォルトの作者２' }
    end
end
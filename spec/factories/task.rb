# 「FactoryBotを使用します」という記述
FactoryBot.define do
    # 作成するテストデータの名前を「task」とします
    # （実際に存在するクラス名と一致するテストデータの名前をつければ、そのクラスのテストデータを自動で作成します）
    factory :task do
      name { 'Factoryで作ったデフォルトのタスク1' }
      detail { 'Factoryで作ったデフォルトのコンテント１' }
      deadline { '2020/08/10' }
      status { 'Factoryで作ったデフォルトの状態１' }
      priority { '高' }
      user
    end
    # 作成するテストデータの名前を「second_task」とします
    # （存在しないクラス名の名前をつける場合、オプションで「このクラスのテストデータにしてください」と指定します）
    factory :second_task, class: Task do
      name { 'Factoryで作ったデフォルトのタスク2' }
      detail { 'Factoryで作ったデフォルトのコンテント２' }
      deadline { '2020/08/20' }
      status { 'Factoryで作ったデフォルトの状態２' }
      priority { '中' }
      user
    end

    factory :third_task, class: Task do
      name { 'Factoryで作ったデフォルトのタスク3' }
      detail { 'Factoryで作ったデフォルトのコンテント3' }
      deadline { '2020/08/11' }
      status { 'Factoryで作ったデフォルトの状態3' }
      priority { '低' }
      user
    end
end
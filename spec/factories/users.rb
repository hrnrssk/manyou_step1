FactoryBot.define do
  factory :user do
    user_name { "test1" }
    email { "test1@g.com" }
    password { "111111" }
    admin { true }
  end

  factory :second_user, class: User do
    user_name { "test2" }
    email { "test2@g.com" }
    password { "222222" }
    admin { false }
  end

  factory :third_user, class: User do
    user_name { "test3" }
    email { "test3@g.com" }
    password { "333333" }
    admin { false }
  end
end

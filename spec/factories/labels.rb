FactoryBot.define do
  factory :label do
    name { "sample1" }
  end
  factory :second_label, class:Label do
    name { "sample2" }
  end
  factory :third_label, class:Label do
    name { "sample3" }
  end
  factory :forth_label, class:Label do
    name { "sample4" }
  end
  factory :fifth_label, class:Label do
    name { "sample5" }
  end
end

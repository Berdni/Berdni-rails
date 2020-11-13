FactoryBot.define do
  factory :user do
    name { 'Yukihiro Matsumoto' }

    factory :user_with_posts do
      posts { [association(:post)] }
    end
  end

  factory :post do
    body { 'Some text' }
    user
  end
end

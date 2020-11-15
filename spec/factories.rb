FactoryBot.define do
  factory :user do
    name { 'Yukihiro Matsumoto' }

    factory :user_with_posts do
      transient do
        posts_count { 5 }
      end

      posts do
        Array.new(posts_count) { association(:post) }
      end
    end
  end

  factory :post do
    body { 'Some text' }
    user
  end
end
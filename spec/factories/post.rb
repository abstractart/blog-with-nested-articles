FactoryBot.define do
  factory :post do
    slug { Faker::Internet.unique.slug }
    title { Faker::Lorem.sentence }
    content { Faker::Lorem.paragraph }
    published { true }
    parent_slug { nil }
    toc_settings { {"contents": []} }
  end
end

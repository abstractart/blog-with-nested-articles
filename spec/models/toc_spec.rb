require 'rails_helper'

RSpec.describe Toc do
  subject { Toc.build(parent_post) }

  let(:parent_post_slug) { Faker::Internet.unique.slug}
  let(:parent_post_title) { Faker::Lorem.sentence }

  let(:child_post_slug) { Faker::Internet.unique.slug}
  let(:child_post_title) { Faker::Lorem.sentence }

  let(:unpublished_child_post_slug) { Faker::Internet.unique.slug}
  let(:unpublished_child_post_title) { Faker::Lorem.sentence }

  let(:not_from_toc_child_post_slug) { Faker::Internet.unique.slug}
  let(:not_from_toc_child_post_title) { Faker::Lorem.sentence }

  let(:section_name) { 'First Section' }
  let(:parent_post) do
    create(
      :post,
      slug: parent_post_slug,
      toc_settings: {
        contents: [
          {
            name: section_name,
            type: 'section'
          },
          {
            name: child_post_title,
            type: 'post',
            slug: child_post_slug
          },
          {
            name: unpublished_child_post_title,
            type: 'post',
            slug: unpublished_child_post_slug
          }
        ]
      }
    )
  end
  let!(:child_post) do
    create(
      :post,
      parent_slug: parent_post.slug,
      title: child_post_title,
      slug: child_post_slug
    )
    end
  let!(:unpublished_child_post) do
    create(
      :post,
      parent_slug: parent_post.slug,
      published: false,
      slug: unpublished_child_post_slug
    )
  end
  let!(:published_child_post_not_from_toc) do
    create(
      :post,
      slug: not_from_toc_child_post_slug,
      parent_slug: parent_post.slug,
      title: not_from_toc_child_post_title
    )
  end

  let(:expected_sections) do
    [Toc::DEFAULT_SECTION, section_name]
  end

  let(:expected_posts) do
    {
      Toc::DEFAULT_SECTION => [
        {
          name: not_from_toc_child_post_title,
          slug: not_from_toc_child_post_slug,
          parent_slug: parent_post_slug
        }
      ],
      section_name => [
        {
          name: child_post_title,
          slug: child_post_slug,
          parent_slug: parent_post_slug
        }
      ]
    }
  end

  it 'builds toc without unpublished and with posts not from toc' do
    expect(subject.sections).to match_array(expected_sections)
    expect(subject.posts_by_sections).to eq(expected_posts)
  end
end

require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  let!(:parent_post) { create(:post) }
  let!(:child_post) { create(:post, parent_slug: parent_post.slug) }

  describe 'get /:post_slug' do
    context 'when post exists' do
      it 'returns 200' do

        get "/#{parent_post.slug}"
        expect(response).to be_successful
      end
    end

    context 'when post not exists' do
      it 'returns 404' do
        rails_respond_without_detailed_exceptions do
          get "/not-presented-slug"
        end

        expect(response).not_to be_successful
        expect(response.status).to eq(404)
      end
    end

    context 'when post is a subpost' do
      it 'returns 404' do
        rails_respond_without_detailed_exceptions do
          get "/#{child_post.slug}"
        end

        expect(response).not_to be_successful
        expect(response.status).to eq(404)
      end
    end
  end

  describe 'get /:post_slug/:subpost-slug' do
    context 'when post exists' do
      it 'returns 200' do

        get "/#{child_post.parent_slug}/#{child_post.slug}"
        expect(response).to be_successful
      end
    end

    context 'when post not exists' do
      it 'returns 404' do
        rails_respond_without_detailed_exceptions do
          get "/#{child_post.parent_slug}/not-presented-slug"
        end

        expect(response).not_to be_successful
        expect(response.status).to eq(404)
      end
    end
  end
end

class PostsController < ApplicationController
  def show
    post_slug, subpost_slug = params[:post_slug], params[:subpost_slug]

    @post = Post.published.without_parent.find_by_slug!(post_slug)
    @toc = Toc.build(@post)

    if subpost_slug
      @post = @post.subposts.published.find_by_slug!(subpost_slug)
    end
  end
end

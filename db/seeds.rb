post = Post.create(
  slug: 'parent-post',
  title: 'Parent Post',
  content: 'Parent Content',
  published: true,
  toc_settings: {
    contents: [
      {
        name: 'Child Post without section',
        type: 'post',
        slug: 'child-post-without-section'
      },
      {
        name: 'First Section',
        type: 'section'
      },
      {
        name: 'Child Post from section 1',
        type: 'post',
        slug: 'child-post-1-from-s-1'
      },
      {
        name: 'Deleted from DB post',
        type: 'post',
        slug: 'deleted-from-db-post'
      },
      {
        name: 'Second Section',
        type: 'section'
      }
    ]
  }
)

subpost = Post.create(
  slug: 'child-post-1-from-s-1',
  parent_slug: post.slug,
  title: 'Child Post from section 1',
  content: 'Child Post from section 1 content',
  published: true
)

subpost_not_from_toc = Post.create(
  slug: 'child-post-1-not-from-toc',
  parent_slug: post.slug,
  title: 'Child Post not from toc',
  content: 'Child Post not from toc',
  published: true
)

subpost_without_section = Post.create(
  slug: 'child-post-without-section',
  parent_slug: post.slug,
  title: 'Child Post without section',
  content: 'Child Post without section content',
  published: true
)

unpublished_child_post = Post.create(
  slug: 'unpublished-child-post',
  parent_slug: post.slug,
  title: 'unpublished Post',
  content: 'unpublished post',
  published: false
)

unpublished_parent_post = Post.create(
  slug: 'unpublished-post',
  parent_slug: nil,
  title: 'unpublished Post',
  content: 'unpublished post',
  published: false
)

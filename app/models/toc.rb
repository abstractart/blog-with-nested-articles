class Toc
  DEFAULT_SECTION = "Without section"
  attr_reader :sections
  attr_reader :posts_by_sections

  def initialize(sections, posts_by_sections)
    @sections, @posts_by_sections = sections, posts_by_sections
  end

  def self.build(post)
    sections = []
    posts_by_sections = Hash.new {|hash, k| hash[k] = []}

    sections << DEFAULT_SECTION

    subposts = Post.published.with_parent(post.slug).pluck(:slug, :title).to_h

    current_section = DEFAULT_SECTION
    post.toc_settings["contents"].each do |item|
      if item['type'] == 'section'
        sections << item['name']
        current_section = item['name']
      elsif item['type'] == 'post' && subposts.has_key?(item['slug'])
        posts_by_sections[current_section] << { slug: item['slug'], name: item['name'], parent_slug: post.slug }
        subposts.delete(item['slug'])
      end
    end

    subposts.each do |slug, name|
      posts_by_sections[DEFAULT_SECTION] << { slug: slug, name: name, parent_slug: post.slug }
    end

    new(sections, posts_by_sections)
  end
end

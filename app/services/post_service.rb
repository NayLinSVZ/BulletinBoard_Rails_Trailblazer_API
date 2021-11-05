class PostService
  # function post detail
    # params id
    # return post
    def self.getPostById(id)
      @post = Post.find_by(id: id)
    end
end
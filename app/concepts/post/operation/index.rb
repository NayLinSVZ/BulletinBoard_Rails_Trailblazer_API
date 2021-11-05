module Post::Operation
  class Index < Trailblazer::Operation
    step :get_post_list
    step :noti

    def get_post_list(options, **)
      @posts = Post.where(deleted_user_id: nil)
      @info =[]
      @posts.each do |post|
        user_info = post.attributes
        user_info[:create_user] = post.create_user
        user_info[:updated_user] = post.updated_user
        @info << user_info
      end
      options[:posts] = @info
    end

    def noti(options, **)
      options[:noti] = "is ok"
    end
  end
end
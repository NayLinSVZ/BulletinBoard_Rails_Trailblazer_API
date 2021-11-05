module Post::Operation
  class Download < Trailblazer::Operation
    step :get_post_list
    step :noti

    def get_post_list(options, **)
      options[:posts] = Post.all
    end

    def noti(options, **)
      options[:noti] = "is ok"
    end
  end
end
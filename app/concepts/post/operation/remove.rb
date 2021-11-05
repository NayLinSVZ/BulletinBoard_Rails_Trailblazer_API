module Post::Operation
  class Remove < Trailblazer::Operation
    step :model!
    pass :id_valid
    fail :id_invalid
    step :soft_remove_post

    def model!(options, params:, **)
      options[:post] = Post.find_by(id: params[:id])
    end

    def soft_remove_post(options,params:, ** )
      options["delete_user"] = Post.find_by(id: params[:id]).update(deleted_user_id: params[:deleted_user_id] , deleted_at: params[:deleted_at])
    end

    def id_valid(options,**)
      options["pass"] = "Your Post ID is Valid"
    end

    def id_invalid(options,**)
      options["fail"] = "Your Post ID is Invalid"
    end
  end
end
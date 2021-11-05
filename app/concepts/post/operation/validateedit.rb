module Post::Operation
  class Validateedit < Trailblazer::Operation
    Reform::Form::ActiveModel::Validations
    step :model!
    step Contract::Build(constant: Post::Contract::Create)
    step Contract::Validate(key: :post)
    pass :is_valid
    fail :not_valid
    
    def model!(options, params:, **)
      options["model"] = PostService.getPostById(params[:id])
    end

      def is_valid(options, **)
        options[:pass] = "validation success"
      end
      def not_valid(options, **)
        options[:fail] = "validation fail"
      end
  end
end
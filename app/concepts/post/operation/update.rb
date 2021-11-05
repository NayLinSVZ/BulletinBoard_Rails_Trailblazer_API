class Post::Operation::Update < Trailblazer::Operation

  class Present < Trailblazer::Operation
    step :model!
    step self::Contract::Build(constant: Post::Contract::Create)
    def model!(options, params:, **)
      options["model"] = Post.find_by(id: params[:id])
    end
  end
  step Nested(Present)
  step self::Contract::Validate(key: :post)
  step self::Contract::Persist()
  step :notify!

  def notify!(options, model:, **)
    options["result.notify"] = "hello"
  end

end


class User::Operation::Update < Trailblazer::Operation
  class Present < Trailblazer::Operation
    step :model!
    step self::Contract::Build(constant: User::Contract::Base)
    step self::Contract::Validate()
    def model!(options, params:, **)
      options["model"] = User.find_by(id: params[:id])
    end
  end
  step Nested(Present)
  step self::Contract::Persist()
  step :notify!
  def notify!(options, model:, **)
    options["result.notify"] = "hello"
  end

end


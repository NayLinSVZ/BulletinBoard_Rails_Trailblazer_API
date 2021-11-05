module Post::Operation
  class Create < Trailblazer::Operation
    class Present < Trailblazer::Operation
      step Model(Post, :new)
      step Contract::Build(constant: Post::Contract::Create)
      step Contract::Validate()
      pass :is_valid
      fail :not_valid

      def is_valid(options, **)
        options[:pass] = "validation success"
      end
      def not_valid(options, **)
        options[:fail] = "validation fail"
      end
    end

    step Nested(Present)
    step Contract::Persist()
    step :notify!

    def notify!(options, **)
      options["notify"] = "Creation is OK"
    end
  end
end
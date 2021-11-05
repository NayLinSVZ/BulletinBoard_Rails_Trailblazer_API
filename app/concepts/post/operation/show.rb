module Post::Operation
  class Show < Trailblazer::Operation
    step Model( Post , :find_by)
    pass :id_valid
    fail :id_invalid

    def model!(options, params:, **)
      options[:post] = Model( Post , :find_by)
    end

    def id_valid(options,**)
      options["pass"] = "Your User ID is Valid"
    end

    def id_invalid(options,**)
      options["fail"] = "Your User ID is Invalid"
    end
  end
end
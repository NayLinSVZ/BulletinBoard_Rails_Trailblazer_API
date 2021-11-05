module User::Operation
  class Validate < Trailblazer::Operation
  
    step Model(User, :new)  
    step Contract::Build( constant: User::Contract::Base )
    step Contract::Validate()
    pass :id_valid
    fail :id_invalid

    def id_valid(options,**)
      options["pass"] = "Your User ID is Valid"
    end
      
    def id_invalid(options,**)
      options["fail"] = "Your User ID is Invalid"
    end
  end
end

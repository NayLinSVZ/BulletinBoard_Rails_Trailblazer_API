class User::Operation::Login < Trailblazer::Operation
  class Present < Trailblazer::Operation
    step Model(User, :find_by , :email)
    step Contract::Build( constant: User::Contract::Update )
    pass :id_valid
    fail :id_invalid

    def id_valid(options,**)
      options["pass"] = "Your User ID is Valid"
    end
      
    def id_invalid(options,**)
      options["fail"] = "Your User ID is Invalid"
    end
  end

  step Model(User, :find_by , :email)
  step :valid!
  pass :is_valid
  fail :is_invalid

  def is_valid(options,**)
    options["pass"] = "Login is pass"
  end
    
  def is_invalid(options,**)
    options["fail"] = "invalid email and password"
  end
  
  def valid!(options, params:, **)
    if options[:model] && options[:model].authenticate(params[:password])
      options[:token] = encode_token({user_id: options[:model].id})
    end
  end
  def encode_token(payload)
    JWT.encode(payload, "12345")
  end
end


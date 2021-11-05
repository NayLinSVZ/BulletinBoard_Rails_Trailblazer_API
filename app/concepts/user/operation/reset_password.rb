module User::Operation
  class ResetPassword < Trailblazer::Operation
    class GetToken < Trailblazer::Operation
      step Model(User, :find_by, :email)  
      step :token_c
      pass :id_valid
      fail :id_invalid

      def token_c(options, model:, **)
        options[:token] = encode_token({user_id: options[:model].id})
      end

      def encode_token(payload)
        JWT.encode(payload, Constants::SECRET)
      end

      def id_valid(options,**)
        options["pass"] = "Your email is Valid"
      end
        
      def id_invalid(options,**)
        options["fail"] = "Your email is Invalid"
      end
    end

    class GetEmail < Trailblazer::Operation
      step Model(PasswordReset, :find_by, :token)  
      pass :id_valid
      fail :id_invalid
  
      def id_valid(options,**)
        options["pass"] = "Your email is Valid"
      end
          
      def id_invalid(options,**)
        options["fail"] = "Your email is Invalid"
      end
    end  

    class GetUserDataByEmail < Trailblazer::Operation
      step Model(User, :find_by, :email)  
      pass :id_valid
      fail :id_invalid
  
      def id_valid(options,**)
        options["pass"] = "Your email is Valid"
      end
          
      def id_invalid(options,**)
        options["fail"] = "Your email is Invalid"
      end
    end  
    
    class UpdatePassword < Trailblazer::Operation
      step :model!
      step :update_password
      pass :email_valid
      fail :email_invalid
      
      def model!(options, params:, **)
        options[:user] = User.find_by(id: params[:id])
      end
      def update_password(options,params:, ** )
        options["updated User"] = User.find_by(id: params[:id]).update(password: params[:newpassword])
      end
  
      def email_valid(options,**)
        options["pass"] = "Your Email is Valid"
      end
  
      def email_invalid(options,**)
        options["fail"] = "Your Email ID is Invalid"
      end
    end

    step Model(PasswordReset , :new)  
    step Contract::Build( constant: User::Contract::ResetPassword )
    step Contract::Validate()
    step Contract::Persist()
    pass :id_valid
    fail :id_invalid

    def id_valid(options,**)
      options["pass"] = "Complete"
    end
      
    def id_invalid(options,**)
      options["fail"] = "Fail"
    end
  end
end

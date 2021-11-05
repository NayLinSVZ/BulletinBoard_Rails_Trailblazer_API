module User::Operation
  class ChangePassword < Trailblazer::Operation
    step Model(User, :find_by)
    step :check_password
    step :update_password
    pass :is_ok
    fail :not_ok

    def check_password(options, params:, **)
      options[:user]= options[:model].authenticate(params[:currentpassword])         
    end
    def update_password(options, params:, **)
      options[:model] = options[:model].update(password: params[:newpassword])            
    end

    def is_ok(options,**)
      options["pass"] = "Update Success"
    end
        
    def not_ok(options,**)
      options["fail"] = "Update Fail"
    end    
  end
end
class User::Operation::Create < Trailblazer::Operation
  
  step Model(User, :new)
  step Contract::Build( constant: User::Contract::Base )
  step Contract::Validate( )
  step Contract::Persist( )
  step :img_process
  step :notify!

  def img_process(options, params:,**)
    if params[:image]
      imgname = params[:image].original_filename
      username = params[:name]
      path = File.join("app", "assets" , "images" ,(username+imgname))
      File.open(path, "wb") { |f| f.write(params[:image].read) }
    end
  end
  def notify!(options, model:, **)
    options["result.notify"] = "New User Creation is Success..."
  end
end
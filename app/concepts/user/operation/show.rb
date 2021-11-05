module User::Operation
  class Show < Trailblazer::Operation

    step :model!
    pass :id_valid
    fail :id_invalid
    step :get_user_data

    def model!(options, params:, **)
      options[:user] = User.find_by(id: params[:id])
    end

    def get_user_data(options, ** )
      user = options[:user]
      if user.profile
        filename = user.profile
        path = "app/assets/images/"+filename
        data = File.open(path, 'rb') {|file| file.read }
        imgfile = "data:image;base64,#{Base64.encode64(data)}"
        @profileImg = imgfile
      end
      options["user"] = user
      options["profileImg"] = @profileImg
    end

    def id_valid(options,**)
      options["pass"] = "Your User ID is Valid"
    end
    def id_invalid(options,**)
      options["fail"] = "Your User ID is Invalid"
    end
  end
end
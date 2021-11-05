module User::Operation
  class Index < Trailblazer::Operation
    step :get_user_list

    def get_user_list(options, params:, ** )
      @users = User.where(deleted_user_id: 0)
      @userInfo = []
      @users.each do |user|

        filename = user.profile
        path = "app/assets/images/"+filename
        data = File.open(path, 'rb') {|file| file.read }
        imgfile = "data:image;base64,#{Base64.encode64(data)}"
        
        user_info = user.attributes
        createdUser = User.find(user.create_user_id)
        updatedUser = User.find(user.updated_user_id)
        user_info[:createdUser] = createdUser.name
        user_info[:updatedUser] = updatedUser.name
        user_info[:img] = imgfile

        @userInfo << user_info
      end
      options["model"] = @userInfo
    end
  end
end
class UserController < ApplicationController
  before_action :authorized, only: [:auto_login , :create, :validate , :index]
  def login
    data = User::Operation::Login.(params: params)
    if data[:fail]
      return render json:  data[:fail], status: 422
    end
    render json: data
  end
  def index
    users = User::Operation::Index.(params: params)  
    render json: users[:model]
  end

  def create
    user = User::Operation::Create.(params: params)
    return render json: {result: user}
  end

  def validate
    if params[:profile]
      params[:profile] = params[:profile].original_filename
    end
    user = User::Operation::Validate.(params: params)
      
    if user[:fail]
      return render json:  user[:'contract.default'].errors, status: 422
    end
    render json: user
  end

  def show
    operation = User::Operation::Show.(params: params)
    if operation[:fail]
      return render json: {error: operation[:fail]} , status: 422
    end
    render json: operation
  end

  def remove
    remove_user = User::Operation::Remove.(params: params)
    if remove_user[:fail]
      return render json: {error: remove_user[:fail]} , status: 422
    end
    render json: remove_user
  end

  def update
    attribute = User::Operation::Update::Present.(params: params) do |d|
      return render json: d
    end
    render json: attribute
  end

  def changePassword
    update_user_data = User::Operation::ChangePassword.(params: params) 
    if update_user_data[:fail]
      return render json: {error: update_user_data[:fail]}, status: 422
    end
    render json: update_user_data
  end

  def resetPassword
    token = User::Operation::ResetPassword::GetToken.(params: params) 
    if token[:fail]
      return render json: {error: token[:fail]}, status: 422
    end

    pr = User::Operation::ResetPassword.(params: {email: params[:email], token: token[:token]})
    if pr[:fail]
      return render json:  pr[:'contract.default'].errors, status: 422
    end

    UserMailer.sendEmail(token).deliver_now
    render json: pr
    
  end

  def resetPasswordData
    resetPasswordData = User::Operation::ResetPassword::GetEmail.(params: params) 
    if resetPasswordData[:fail]
      return render json: {error: resetPasswordData[:fail]}, status: 422
    end
    render json:resetPasswordData
  end

  def email 
    resetPasswordData = User::Operation::ResetPassword::GetUserDataByEmail.(params: params) 
    if resetPasswordData[:fail]
      return render json: {error: resetPasswordData[:fail]}, status: 422
    end
    render json:resetPasswordData
  end

  def updatePassword
    operation = User::Operation::ResetPassword::UpdatePassword.(params: params)
    if operation[:fail]
      return render json: {error: operation[:fail]} , status: 422
    end
    render json: operation
  end

end

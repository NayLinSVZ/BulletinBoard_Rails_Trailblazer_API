module User::Contract
  class ResetPassword < Reform::Form

    property :email
    property :token

    validates :email,:token, presence: true
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  end
end
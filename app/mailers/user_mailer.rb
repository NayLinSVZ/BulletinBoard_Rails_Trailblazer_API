class UserMailer < ApplicationMailer
  default from: 'testerrails.01@gmail.com'
  layout 'mailer' 
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.sendEmail.subject
  #
  def sendEmail(userdata)
    @name = userdata[:model].name
    @token = userdata[:token]
    @email = userdata[:model].email
    @url = "http://localhost:8080/login/forget-password-update?token=#{@token}"
    mail(to: @email,
      body: "
      <!DOCTYPE html>
      <html>
        <head>
          <meta content='text/html; charset=UTF-8' http-equiv='Content-Type' />
        </head>
        <body>
          <h3>Welcome to Bulletin_Board, #{@name} </h3><br>
          <p>
            your username is : #{@name}
          </p><br>
          <a href='#{@url}'>
            #{@url}
          </a>
          <p>Click the Link and Reset your password..</p><br>
          <p>Thanks for joining and have a great day!</p>
        </body>
      </html>
      ",
      content_type: "text/html",
      subject: "Password Reset!")
  end
end

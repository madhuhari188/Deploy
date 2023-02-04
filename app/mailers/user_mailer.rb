class UserMailer < ApplicationMailer

  def welcome_email(user)
    @user = user
    mail(from: 'no-replay@tech-savvy.com' , to: user.email,subject: 'Welcome to the Tech Savvy')
  end

end

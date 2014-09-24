class Notifications < ActionMailer::Base
  default from: "tu.tumso@gmail.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifications.signup.subject
  #
  def signup(application)
    @application = application

    mail to: @application.email
  end
end

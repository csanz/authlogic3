class Notifier < ActionMailer::Base
  default_url_options[:host] = "#{APP_CONFIG[:domain]}"
  
  def password_reset_instructions(user)
    subject       "[#{APP_CONFIG[:domain]}] password reset instructions"
    from          "#{APP_CONFIG[:domain]} <noreply@#{APP_CONFIG[:domain]}>"
    recipients    user.email
    sent_on       Time.now
    body          :user => user
  end

  def verification_instructions(user)
      subject       "[#{APP_CONFIG[:domain]}] email verification"
      from          "#{APP_CONFIG[:domain]} <noreply@#{APP_CONFIG[:domain]}>"
      recipients    user.email
      sent_on       Time.now
      body          :user => user 
  end
    
end
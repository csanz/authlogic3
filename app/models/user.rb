class User < ActiveRecord::Base
  validates :name,  :presence => true
  validates :email, :presence => true, :uniqueness => true, :email_format => true
  
  acts_as_authentic do |c|
    c.login_field = :email          # email is the login field
    c. validate_login_field = false # There is no login field, so don't validate it
  end

  def deliver_password_reset_instructions!
    reset_perishable_token!
    Notifier.deliver_password_reset_instructions(self)
  end
  def deliver_verification_instructions!
    reset_perishable_token!
    Notifier.deliver_verification_instructions(self)
  end
  def verify!
      self.verified = true
      self.save
  end
end

require "devise"

$: << File.expand_path("..", __FILE__)

require "devise_sms_activable/routes"
require "devise_sms_activable/schema"
require 'devise_sms_activable/controllers/url_helpers'
require 'devise_sms_activable/controllers/helpers'
require 'devise_sms_activable/rails'

module Devise
  mattr_accessor :sms_confirm_within
  @@sms_confirm_within = 2.days
  mattr_accessor :sms_confirmation_keys
  @@sms_confirmation_keys = [:email]
  mattr_accessor :sms_sender
  @@sms_sender = "Devise::SmsSender"

  mattr_accessor :sms_confirm_also_mail
  @@sms_confirm_also_mail = true
                                        
  
  def self.ref(arg)
    if defined?(ActiveSupport::Dependencies::ClassCache)
      ActiveSupport::Dependencies::reference(arg)
      Getter.new(arg)
    else
      ActiveSupport::Dependencies.ref(arg)
    end
  end
  
  # Get the sms sender class from the mailer reference object.
  def self.sms_sender
    @@sms_sender_ref.get
  end
  
  # Set the smser reference object to access the smser.
  def self.sms_sender=(class_name)
    @@sms_sender_ref = ref(class_name)
  end
  
  self.sms_sender = "Devise::SmsSender"  
end

Devise.add_module :sms_activable, :model => "models/sms_activable", :controller => :sms_activations, :route => :sms_activation

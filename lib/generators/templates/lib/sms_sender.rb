module Devise
  class SmsSender
    #Actually sends the sms token. feel free to modify and adapt to your provider and/or gem
    def self.send_sms(phone,message)
      message = MainsmsApi::Message.new(sender: I18n.t('app_from'), message: message, recipients: [phone])
      response = message.deliver
      if response.status == 'success'
        true
      else
        false
      end
    end   
  end
end

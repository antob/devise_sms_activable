class Devise::SmsActivationsController < Devise::ConfirmationsController

  # POST /resource/sms_activation
  def create                      
    self.resource = resource_class.send_sms_token(params[resource_name])
    
    if successfully_sent?(resource)
      respond_with({}, :location => after_resending_confirmation_instructions_path_for(resource_name))
    else
      respond_with(resource)
    end
  end
  
  # GET /resource/sms_activation?sms_token=abcdef
  def show
    self.resource = resource_class.confirm_by_sms_token(params[:sms_token])

    if resource.errors.empty?
      set_flash_message(:notice, :confirmed) if is_navigational_format?
      sign_in(resource_name, resource)
      respond_with_navigational(resource){ redirect_to after_confirmation_path_for(resource_name, resource) }
    else
      respond_with_navigational(resource.errors, :status => :unprocessable_entity){ render :new }
    end
  end  
  
  
end

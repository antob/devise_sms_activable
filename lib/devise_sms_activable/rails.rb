module DeviseInvitable
  class Engine < ::Rails::Engine

    ActiveSupport.on_load(:action_controller) do
      include DeviseSmsActivable::Controllers::Helpers
    end

  end
end

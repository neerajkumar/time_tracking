class Employees::RegistrationsController < Devise::RegistrationsController

  respond_to :html, :json
  
  layout 'login'

  # before_action :employee_params
  
# before_filter :configure_sign_up_params, only: [:create]
# before_filter :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
   # super
  #end

  # POST /resource
  # def create
  #  super
  # end

  # GET /resource/edit
  # def edit
  #  super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.for(:sign_up) << :attribute
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.for(:account_update) << :attribute
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

  protected

  # def after_sign_up_path_for(resource)
    # sends multiple admin emails (no deliver call needed)
    #AdminMailer.new_sign_up(resource) unless Rails.env.test?
    #super
  #end

  private

  def employee_params
    binding.pry
    params.require(:employee).permit(:first_name, :last_name, :portal_id, :email)
  end

end

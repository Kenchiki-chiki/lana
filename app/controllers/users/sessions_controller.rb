class Users::SessionsController < Devise::SessionsController
  skip_forgery_protection only: %i(destroy)

  def destroy
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    set_flash_message! :notice, :signed_out if signed_out
    yield if block_given?

    head :no_content
  end
end
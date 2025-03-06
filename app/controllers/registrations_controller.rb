class RegistrationsController < Devise::RegistrationsController
  def create
    super do |resource|
      if resource.persisted?
        flash[:notice] = "Welcome, #{resource.email}! You have signed up successfully."
      end
    end
  end


  protected

  def update_resource(resource, params)
    if params[:avatar].present?
      resource.avatar.attach(params[:avatar])
    end
    resource.update_without_password(params.except(:avatar))
  end
end

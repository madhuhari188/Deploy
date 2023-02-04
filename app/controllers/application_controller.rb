class ApplicationController < ActionController::Base
  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { render json: {error:"Not Authorized"}, status: :forbidden }
      format.html { redirect_to root_path, notice: exception.message }
    end
  end
  # rescue_from ActiveRecord::RecordNotFound, with: :not_found
  # rescue_from ActionController::RoutingError, with: :not_found
  # def not_found
  #   # raise ActionController::RoutingError.new('Not Found')
  #   render file: "#{Rails.root}/public/404.html", layout: true, status: :not_found
  # end

end

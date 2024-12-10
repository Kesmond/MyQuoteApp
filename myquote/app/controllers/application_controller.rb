class ApplicationController < ActionController::Base
    #Some helper methods that may be useful
    helper_method :current_user, :logged_in?, :is_administrator?

    #Current_user method retrieves details of the currently logged-in user from the session object.
    #The ||= operator assigns these details to @current_user so the database is queried only once per request
    def current_user
        @current_user ||= User.find_by(id: session[:user_id])
    end

    #Checks if user is logged in (set), returning not nil if user is determined logged in
    def logged_in?
        !current_user.nil?
    end

    #Checks if current_user is an administrator based on the session[:is_admin] value, if true, user is an admin, otherwise they are a standard user
    def is_administrator?
        session[:is_admin]
    end

#Sets methods to private, preventing them from being called from outside ApplicationController object    
private
    #Ensures that an action or controller is accessible only by logged-in users
    def require_login
        #If user isn't logged in
        unless logged_in?
            #Sends an error flash message
            flash[:error] = "You are not permitted to access this resource"
            #Redirects to login page
            redirect_to login_path
        end
    end
end

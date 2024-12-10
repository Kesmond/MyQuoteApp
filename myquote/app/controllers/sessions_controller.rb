class SessionsController < ApplicationController
    #Renders the login form
    def new
    end

    #Handles the login process. 
    def create
        #Finds a user based on the provided email
        user = User.find_by(email: params[:email])
        #If the email is found, the password is correct, and the user's status is Active
        if user && user.authenticate(params[:password]) && user.status == "Active"
            #Allocates user_id, first name, is admin, to a session object
            session[:user_id] = user.id
            session[:fname] = user.fname
            session[:is_admin] = user.is_admin
            #Checks whether it is an admin or standard user
            if session[:is_admin]
                #If it's an administrator user, redirect to admin page
                redirect_to admin_path, notice: "Logged in successfully!"
            else
                #If it's a standard user, redirect to standard user page
                redirect_to userhome_path, notice: "Logged in successfully!"
            end
        #If the email is found, the password is correct, and the user's status is Suspended
        elsif user && user.authenticate(params[:password]) && user.status == "Suspended"
            #Sends an error message notifying this account is Suspended
            flash.now[:error] = "You have been Suspended. Please contact administrator."
            #Renders a new login form
            render 'new'
        #If the email is found, the password is correct, and the user's status is Banned
        elsif user && user.authenticate(params[:password]) && user.status == "Banned"
            #Sends an error message notifying this account is Banned
            flash.now[:error] = "You have been Banned."
            #Renders a new login form
            render 'new'
        #If anything isn't entered correctly as in the database
        else
            #Sends an error message notifying invalid email or password
            flash.now[:error] = "Invalid email or password. Please try again."
            #Renders a new login form
            render 'new'
        end
    end

    #Handles the logout process
    def destroy
        #Clears all set parameters from session object to null
        session[:user_id] = nil
        #Redirects user to home page with the message
        redirect_to root_path, notice: "Logged out successfully!"
    end
    
end

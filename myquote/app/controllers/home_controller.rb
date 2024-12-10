class HomeController < ApplicationController
  #Display top 5 recently created public quotes
  def index
    @quotes = Quote.includes(:categories).where(is_public: true).order(created_at: :desc).take(5)
  end

  #Method on the admin index page (/admin) which only allows logged in administrator to access it
  def aindex
    #If the user has logged on and is an administrator
    if logged_in? && is_administrator?
      #Display top 5 recently created public quotes
      @quotes = Quote.includes(:categories).where(is_public: true).order(created_at: :desc).take(5)
    #If user isn't an administrator
    else
      #Sends an error message and redirects it to login page
      flash[:error] = "You are not authorised to access this resource"
      redirect_to login_path
    end
  end

  #Method on the user index page (/userhome) which only allows logged in standard user to access it
  def uindex
    #If the user has logged on and is a standard user
    if logged_in? && !is_administrator?
      #Display top 5 recently created public quotes
      @quotes = Quote.includes(:categories).where(is_public: true).order(created_at: :desc).take(5)
    #If user isn't a standard user
    else
      #Sends an error message and redirects it to login page
      flash[:error] = "You are not authorised to access this resource"
      redirect_to login_path
    end
  end
  
  #Method on the your quotes index page (/your-quotes) which only allows logged in users to access it (assuming every logged in user can upload their quote)
  def uquotes
    #If the user has logged on
    if logged_in?
      #Display top 5 recently created public quotes
      @quotes = Quote.includes(:categories).where(user_id: session[:user_id])
    #If the user isn't logged in
    else
      #Sends an error message and redirects it to login page
      flash[:error] = "You are not authorised to access this resource"
      redirect_to login_path
    end
  end
end

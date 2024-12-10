class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
  before_action :authorize_user, only: %i[ show edit update destroy]
  before_action :require_login, except: [:new, :create]

  # GET /users or /users.json
  def index
    #If there is a logged in user which is an administrator
    if logged_in? && is_administrator?
      @users = User.all #Retrieve all users from database
    #Otherwise, if there is a logged in user but NOT an administrator
    elsif logged_in? && !is_administrator?
      redirect_to userhome_path #redirect to their user landing page
    #Otherwise, no one is logged in
    else
      #Generate unauthorised message
      flash[:error] = "You are not authorised to access this resource"
      redirect_to login_path #Then redirect to login page
    end

  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to login_path, notice: "Sign up successful. Please log in." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:fname, :lname, :email, :password, :is_admin, :status)
    end

    #Don't allow user to edit other user's information
    def authorize_user
      #Find the user of the given id
      @user = User.find(params[:id])

      #If the current logged in user's id is not the given id an not an administrator
      if logged_in? && !is_administrator? && current_user.id != @user.id
        #Sends an error message
        flash[:error] = "You are not authorised to access this user"
        #If the current user is logged in
        if logged_in?
          #Redirect it to its home page
          redirect_to userhome_path
        #If it's not logged in
        else
          #Redirect it to the login page
          redirect_to login_path
        end
      end
    end
end
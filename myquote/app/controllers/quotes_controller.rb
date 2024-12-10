class QuotesController < ApplicationController
  before_action :set_quote, only: %i[ show edit update destroy ]
  before_action :require_login, except: [:index, :show]
  before_action :user_edit, only: %i[ edit update destroy] #Limits access when edit, update, and destroy

  # GET /quotes or /quotes.json
  def index
    @quotes = Quote.includes(:categories).order(created_at: :desc)
  end

  # GET /quotes/1 or /quotes/1.json
  def show
    @quote = Quote.find(params[:id])
  end

  # GET /quotes/new
  def new
    @quote = Quote.new
    7.times {@quote.quote_categories.build}  # Give the form SEVEN quote category fields
  end

  # GET /quotes/1/edit
  def edit
    (7 - @quote.quote_categories.count).times {@quote.quote_categories.build}  # Give the form up to SEVEN quote category fields
  end

  # POST /quotes or /quotes.json
  def create
    @quote = Quote.new(quote_params)

    respond_to do |format|
      if @quote.save
        format.html { redirect_to quote_url(@quote), notice: "Quote was successfully created." }
        format.json { render :show, status: :created, location: @quote }
      else
        7.times {@quote.quote_categories.build}
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @quote.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /quotes/1 or /quotes/1.json
  def update
    respond_to do |format|
      if @quote.update(quote_params)
        format.html { redirect_to quote_url(@quote), notice: "Quote was successfully updated." }
        format.json { render :show, status: :ok, location: @quote }
      else
        (7 - @quote.quote_categories.count).times {@quote.quote_categories.build}
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @quote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quotes/1 or /quotes/1.json
  def destroy
    @quote.destroy

    respond_to do |format|
      format.html { redirect_to quotes_url, notice: "Quote was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quote
      @quote = Quote.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def quote_params
      params.require(:quote).permit(:text, :year_publication, :comment, :is_public, :author_id, :user_id,
      quote_categories_attributes: [:id, :quote_id, :category_id])
    end

    #Denies access other quotes which isn't created by user
    def user_edit
      if @quote.user_id != current_user.id
        flash[:error] = "You are not allowed to access this quote"
        redirect_to quote_url(@quote)
      end
    end
end

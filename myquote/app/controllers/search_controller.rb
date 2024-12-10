class SearchController < ApplicationController
  def index
    #Gets the value of a category by the search form
    category_query = params[:category_query]

    #If quote with the asked category is present/found
		if category_query.present?
      #Displays the result
		  @quotematch = Quote.joins(:quote_categories, :categories).where("categories.category_name LIKE ?", "%#{category_query}%").distinct
    end

  end
end


class ReviewsController < ApplicationController

  before_filter :require_login
  
  def create
    @product = Product.find(params[:product_id])
    @review = @product.reviews.create(review_param)
    @review.user = current_user

    if @review.save
      redirect_to product_path(@product)
      flash[:notice] = "Review submitted!"
    else
      redirect_to product_path(@product)
      flash.now.alert = "Could not submit review!"
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @product = @review.product

    if current_user == @review.user
      @review.destroy
    end
    redirect_to product_path(@product)
  end

  private
  def review_param
    params.require(:review).permit(
      :product_id,
      :rating,
      :description
    )
  end

  def require_login
    if !logged_in?
      flash[:error] = "You are not logged in!"
      redirect_to login_path
    end 
  end
end

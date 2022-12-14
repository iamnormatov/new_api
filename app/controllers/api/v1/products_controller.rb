class Api::V1::ProductsController < ApiController
  before_action :set_product, only: %i[ show edit update destroy ]

  # GET /products or /products.json
  def index
    @products = Product.all
    render json: @products
  end

  # GET /products/1 or /products/1.json
  def show
    render json: @product
  end

  # GET /products/new
  def new
    @product = Product.new
  end
 
  # GET /products/1/edit
  def edit
  end

  # product /products or /products.json
  def create
    @product = Product.new(product_params)
    @product.user = current_user
      if @product.save
        # format.html { redirect_to product_url(@product), notice: "product was successfully created." }
        render json: @product, status: :created, location: @product
      else
        # format.html { render :new, status: :unprocessable_entity }
        render json: @product.errors, status: :unprocessable_entity
      end
    end

  # PATCH/PUT /products/1 or /products/1.json
  def update
      if @product.update(product_params)
    render json: @product
  else
    render json: @product.errors, status: :unprocessable_entity
    end
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    @product.destroy
    
    if @product.destroy
      head :no_content
    end
    
    # respond_to do |format|
    #   format.html { redirect_to products_url, notice: "product was successfully destroyed." }
    #   format.json { head :no_content }
    # end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:name, :description, :price, :user_id)
    end
end

class ProductsController < ApplicationController
    def index
        @products = Product.all
    end

    def new
        @product = Product.new
        @categories = Category.all
        @product.categories.new
        #CategoriesController is not necessary!
    end
    
    def create
        @product = Product.new(product_params)
        #params[:categories].each do |cat|
        #    @product.categories << Category.find_by_name(cat)        
        #end    
        if @product.save
            redirect_to products_path, notice: "Product successfully created"
        else
            render :new
        end
    end
 
    def edit
        @product = Product.find(params[:id])
        #@categories = Category.all
    end

    def update
        @product = Product.find(params[:id])
        #@categories = Category.find(params[:category_ids])        
        if @product.update(product_params)
            redirect_to products_path, notice: "Product successfully modified"            
        else
            render :edit
        end
    end
    
    def destroy
        product = Product.find(params[:id])
        product.destroy

        redirect_to products_path, notice: "Product deleted"
    end
        
    private
        def product_params
            params.require(:product).permit(:name, :price, category_ids: [])
        end
end

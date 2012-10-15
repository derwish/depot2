class LineItemsController < ApplicationController
  # GET /line_items
  # GET /line_items.json
  def index
    # @line_items = LineItem.all

    # respond_to do |format|
    #   format.html # index.html.erb
    #   format.json { render json: @line_items }
    # end

      logger.error "Blocked access to line_items list via browser"
      redirect_to store_url, notice: 'Invalid path'
  end

  # GET /line_items/1
  # GET /line_items/1.json
  def show
    begin
      # @line_item = LineItem.find(params[:id])
    # rescue ActiveRecord::RecordNotFound
    #   logger.error "Attempt to access via browser line_item #{params[:id]}"
    #   redirect_to store_url, notice: 'line_item'
    # else
      #made line_item unavailable via broser
      # respond_to do |format|
      #  format.html # show.html.erb
      #   format.json { render json: @cart }
      # end  

      logger.error "Blocked access to line_items list via browser"
      redirect_to store_url, notice: 'Invalid path'

    end
  end

  # GET /line_items/new
  # GET /line_items/new.json
  def new
    @line_item = LineItem.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @line_item }
    end
  end

  # # GET /line_items/1/edit
  def edit
    @line_item = LineItem.find(params[:id])
  end

  # POST /line_items
  # POST /line_items.json
  def create
    @cart = current_cart
    reset_visit
    product = Product.find(params[:product_id])
    @line_item = @cart.add_product(product.id)
    logger.error "what the hell #{@cart.inspect}"

    respond_to do |format|
      if @line_item.save
        format.html { redirect_to store_path }
        format.js { @current_item = @line_item }
        format.json { render json: @line_item, status: :created, location: @line_item }
      else
        format.html { render action: "new" }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /line_items/1
  # PUT /line_items/1.json
  def update
      @cart = current_cart
      to_add = Integer(params[:to_add])
      product = Product.find(params[:product_id])
      @removed = false;

      if( to_add > 0 )
        @cart.add_product(product.id, to_add)
      elsif( to_add == 0 )
        logger.error "Unexpected quantity to add"
      else
        @removed = @cart.remove_product(product.id, -to_add)
      end

      respond_to do |format|
        format.html { redirect_to store_path, notice: "changed quantity of #{params[:pr_title]}" }
        @removed ? format.js : format.js{ @current_item = LineItem.find(params[:id]) }
        format.json { head :ok }
      end
  end

  # DELETE /line_items/1
  # DELETE /line_items/1.json
  def destroy
    @line_item = LineItem.find(params[:id])
    @cart = @line_item.cart

    rescue ActiveRecord::RecordNotFound
      logger.error "Attempt to access via browser line_item #{params[:id]}"
      redirect_to store_url, notice: 'not found item to destroy'
    else
      @line_item.destroy
      logger.info 'destoy of the line item'

      respond_to do |format|
        format.html { redirect_to store_path, notice: "removed product #{params[:pr_title]} from the cart"}
        format.js
        format.json { head :ok }
      end
    end
  end

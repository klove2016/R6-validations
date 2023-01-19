class OrdersController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :catch_not_found
    before_action :set_order, only: [:show, :edit, :update, :destroy]

    def index
        @orders = Order.all
    end
    def edit
    end
    def new
        @order = Order.new
        @customers = Customer.all
    end
    def create
        @order = Order.new(order_params)
        if @order.save
            flash.notice = "The customer order record was created successfully."
            redirect_to @order
          else
            flash.now.alert = @order.errors.full_messages.to_sentence
            render :new  
          end
    end
    def show
    end
    def update
        if @order.update(order_params)
            flash.notice = "The customer order record was updated successfully."
            redirect_to @order
          else
            flash.now.alert = @order.errors.full_messages.to_sentence
            render :edit
          end
    end
    def destroy
        if @order.destroy
            flash[:notice] = "Order was successfully deleted."
        else
            flash[:alert] = "An error occurred while trying to delete the order."
        end
        redirect_to customer_path(@order.customer_id)
       
    end

    private

    def set_order
        @order = Order.find(params[:id])
    end
    def order_params
        params.require(:order).permit(:product_count, :product_name, :customer_id)
    end
    def catch_not_found(e)
        Rails.logger.debug("We had a not found exception.")
        flash.alert = e.to_s
        redirect_to customers_path
      end
end

class DeliveriesController < ApplicationController
  def index
    if current_user != nil
      matching_deliveries = Delivery.all

      @list_of_deliveries = matching_deliveries.order({ :created_at => :desc })

      render({ :template => "deliveries/index" })
    else
      redirect_to("/users/sign_in", { :notice => "You need to sign in or sign up before continuing" })
    end
  end

  def show
    the_id = params.fetch("path_id")

    matching_deliveries = Delivery.where({ :id => the_id })

    @the_delivery = matching_deliveries.at(0)

    render({ :template => "deliveries/show" })
  end

  def create
    the_delivery = Delivery.new
    the_delivery.user_id = current_user.id
    the_delivery.description = params.fetch("query_description")
    the_delivery.supposed_arrival_date = params.fetch("query_supposed_arrival_date")
    the_delivery.details = params.fetch("query_details")

    if the_delivery.valid?
      the_delivery.save
      redirect_to("/", { :notice => "Added to list." })
    else
      redirect_to("/", { :alert => the_delivery.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_delivery = Delivery.where({ :id => the_id }).at(0)

    the_delivery.status = "delivered"

    if the_delivery.valid?
      the_delivery.save
      redirect_to("/", { :notice => "Marked as received."} )
    else
      redirect_to("/", { :alert => the_delivery.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_delivery = Delivery.where({ :id => the_id }).at(0)

    the_delivery.destroy

    redirect_to("/", { :notice => "Deleted."} )
  end
end

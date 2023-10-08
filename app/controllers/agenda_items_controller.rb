class AgendaItemsController < ApplicationController


  # index: Display all agenda items for a specific call session
  def index
    @call_session = CallSession.find(params[:call_session_id])
    @agenda_items = @call_session.agenda_items
    render json: @agenda_items
  end

  # create: Add an agenda item to a call session.
  def create
    @call_session = CallSession.find(params[:call_session_id])
    @agenda_item = @call_session.agenda_items.new(agenda_item_params)
    
    if @agenda_item.save
      render json: @agenda_item, status: :created
    else
      render json: @agenda_item.errors, status: :unprocessable_entity
    end
  end

  
  # update: Modify an existing agenda item.
  def update
    @agenda_item = AgendaItem.find(params[:id])
    
    if @agenda_item.update(agenda_item_params)
      render json: @agenda_item
    else
      render json: @agenda_item.errors, status: :unprocessable_entity
    end
  end

  # destroy: Remove an agenda item.
  def destroy
    @agenda_item = AgendaItem.find(params[:id])
    @agenda_item.destroy
    head :no_content
  end
  

  
end

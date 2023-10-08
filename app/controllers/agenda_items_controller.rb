class AgendaItemsController < ApplicationController
  before_action :set_agenda_item, only: [:update, :destroy]
  before_action :set_call_session, only: [:index, :create]
  before_action :authorize_agenda_item, only: [:update, :destroy]

  # index: Display all agenda items for a specific call session
  def index
    @agenda_items = @call_session.agenda_items
    render json: @agenda_items
  end

  # create: Add an agenda item to a call session.
  def create
    @agenda_item = @call_session.agenda_items.new(agenda_item_params)
    
    if @agenda_item.save
      render json: @agenda_item, status: :created
    else
      render json: @agenda_item.errors, status: :unprocessable_entity
    end
  end

  # update: Modify an existing agenda item.
  def update
    if @agenda_item.update(agenda_item_params)
      render json: @agenda_item
    else
      render json: @agenda_item.errors, status: :unprocessable_entity
    end
  end

  # destroy: Remove an agenda item.
  def destroy
    @agenda_item.destroy
    head :no_content
  end

  private

  def set_agenda_item
    @agenda_item = AgendaItem.find(params[:id])
  end

  def set_call_session
    @call_session = CallSession.find(params[:call_session_id])
  end

  def authorize_agenda_item
    authorize_resource_owner!(@agenda_item.call_session)
  end
end

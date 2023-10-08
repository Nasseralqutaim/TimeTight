class CallSessionsController < ApplicationController

  # index: List all call sessions for a user
  def index 
    @call_sessions = current_user.call_sessions
    render json: @call_sessions
  end 

  # show: Display details of a specific call session
  def show
    @call_session = CallSession.find(params[:id])
    render json: @call_session
  end

  # create: Initiate a new call session
  def create
    @call_session = current_user.call_sessions.new(call_session_params)
    
    if @call_session.save
      render json: @call_session, status: :created
    else
      render json: @call_session.errors, status: :unprocessable_entity
    end
  end

  # update: Modify an existing call session, e.g., extend call time 
  def update
    @call_session = CallSession.find(params[:id])
    
    if @call_session.update(call_session_params)
      render json: @call_session
    else
      render json: @call_session.errors, status: :unprocessable_entity
    end
  end

  # destroy: Terminate a call session.
  def destroy
    @call_session = CallSession.find(params[:id])
    @call_session.destroy
    head :no_content
  end
  
  
  
end

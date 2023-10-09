class FeedbacksController < ApplicationController
  before_action :set_call_session, only: [:create]
  before_action :set_feedback, only: [:show, :update, :destroy]
  before_action :authorize_feedback, only: [:update, :destroy]

  # POST /call_sessions/:call_session_id/feedbacks
  def create
    @feedback = @call_session.feedbacks.new(feedback_params)

    if @feedback.save
      render json: @feedback, status: :created
    else
      render json: @feedback.errors, status: :unprocessable_entity
    end
  end

  # GET /call_sessions/:call_session_id/feedbacks/:id
  def show
    render json: @feedback
  end

  # PATCH/PUT /call_sessions/:call_session_id/feedbacks/:id
  def update
    if @feedback.update(feedback_params)
      render json: @feedback
    else
      render json: @feedback.errors, status: :unprocessable_entity
    end
  end

  # DELETE /call_sessions/:call_session_id/feedbacks/:id
  def destroy
    @feedback.destroy
    head :no_content
  end

  private

  def set_call_session
    @call_session = CallSession.find(params[:call_session_id])
  end

  def set_feedback
    @feedback = Feedback.find(params[:id])
  end

  def authorize_feedback
    authorize_resource_owner!(@feedback.call_session)
  end

  def feedback_params
    params.require(:feedback).permit(:content)
  end
end

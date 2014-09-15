class EventsController < ApplicationController
  def index
    user   = User.find(params[:user_id])
    @events = user.attendances.full_event

    respond_to do |format|
      format.html { render :layout => !request.xhr? }
    end
  end
end

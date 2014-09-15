class UsersController < ApplicationController
  def index
    since = params[:since] || nil

    if since
      since = Date.strptime(since, "%Y:%m:%d")
      @users = User.with_stats.where('scheduled > ?', since)
    else
      @users = User.with_stats
    end
  end
end

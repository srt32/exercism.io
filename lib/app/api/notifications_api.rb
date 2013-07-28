class ExercismApp < Sinatra::Base
  get '/api/v1/notifications' do
    notifications = Dispatch.notifications_for_user(notification_user)
    NotificationsPresenter.new(notifications).to_json
  end

  private
  def notification_user
    if params[:key]
      User.find_by(:key, params[:key])
    elsif session[:github_id]
      current_user
    else
      no_user_error
    end
  end

  def no_user_error
    halt 401, { error: "Please provide API key or valid session" }.to_json
  end
end


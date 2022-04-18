class App
  def call(env)
    request = Rack::Request.new(env)

    if request.get? && request.path == '/time'
      formatted_time(request)
    else 
      page_not_found
    end
  end

  private

  def formatted_time(request)
    user_time_format = FormatTime.new(request.params['format'])
    user_time_format.call

    if user_time_format.errors_in_formats.any?
      page_unknown_format(user_time_format.errors_in_formats)
    else
      page_user_format_time(user_time_format.time_now)
    end
  end

  def page_not_found
    status = 404
    body = ["Page not found (#{status})"]
    create_response(status, body)
  end

  def page_unknown_format(errors)
    status = 400
    body = ["Unknown format #{errors.join} (#{status})"]
    create_response(status, body)
  end

  def page_user_format_time(time_now)
    status = 200
    body = [time_now]
    create_response(status, body)
  end

  def create_response(status, body)
    response = Rack::Response.new
    response.status = status
    response['Content-Type'] = 'text/plain'
    response.body = body
    response.finish
  end
end

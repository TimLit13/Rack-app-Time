class App
  def call(env)
    request = Rack::Request.new(env)

    if request.get? && request.path == '/time'
      formatted_time(request)
    else 
      create_response(404, ["Page not found (404)"])
    end
  end

  private

  def formatted_time(request)
    user_time_format = FormatTime.new(request.params['format'])
    user_time_format.call

    if user_time_format.valid?
      create_response(400, ["Unknown format #{user_time_format.errors_in_formats.join} (400)"])
    else
      create_response(200, [user_time_format.time_now])
    end
  end

  def create_response(status, body)
    response = Rack::Response.new
    response.status = status
    response['Content-Type'] = 'text/plain'
    response.body = body
    response.finish
  end
end

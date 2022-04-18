class App
  def call(env)
    [status, headers, body]
  end

  private

  def status
    200
  end

  def headers
    {'Content-type' => 'text/plain'}
  end

  def body
    ["Just for looking that it's work!\n"]
  end
end

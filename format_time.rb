class FormatTime
  TIME_FORMATS = { year:   "%Y", 
                   month:  "%m", 
                   day:    "%d",
                   hour:   "%H", 
                   minute: "%M", 
                   second: "%S" }.freeze

  attr_reader :errors_in_formats

  def initialize(params)
    @params = params
    @user_formats = []
    @errors_in_formats = []
  end

  def call(*env)
    query_string = parse_formats(@params)
    
    query_string.each do |format|
      format_sym = format.to_sym
      TIME_FORMATS[format_sym] ? @user_formats.push(TIME_FORMATS[format_sym]) : @errors_in_formats.push(format)
    end
  end

  def time_now
    time_format = @user_formats.join('-')
    Time.now.strftime(time_format)
  end
  
  private

  def parse_formats(query_string)
    query_string.nil? ? Array.new : query_string.split(',')
  end
end
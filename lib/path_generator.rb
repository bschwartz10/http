require_relative 'diagnostics'
require_relative 'path_destination'
class PathGenerator

  def initialize
    @diagnostics = Diagnostics.new
    @destination = PathDestination.new
    @number_of_requests = 0
  end

  def path_generator(request_lines)
    path = request_lines[0].split[1]
    case path
      when '/'
        @number_of_requests += 1
        @diagnostics.response(request_lines)
      when '/hello'
        @number_of_requests += 1
        response = @destination.hello + @diagnostics.response(request_lines)
      when '/datetime'
        @number_of_requests += 1
        response = @destination.date_time + @diagnostics.response(request_lines)
      when '/shutdown'
        response = @destination.shut_down(@number_of_requests)
    end
  end


end

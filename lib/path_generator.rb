require_relative 'diagnostics'
require_relative 'path_destination'

class PathGenerator
attr_reader :destination

  def initialize
    @diagnostics = Diagnostics.new
    @destination = PathDestination.new
    @number_of_requests = 0
  end

  def path_checker(path)
    if path.split('?').include?('/word_search')
      '/word_search'
    else
      path
    end
  end

  def path_generator(request_lines)
    path = request_lines[0].split[1]
    input_word = path.split('=')[1]
    path = path_checker(path)
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
      when '/word_search'
        @number_of_requests += 1
        response = @destination.word_search(input_word) + @diagnostics.response(request_lines)
      when '/shutdown'
        response = @destination.shut_down(@number_of_requests) + @diagnostics.response(request_lines)
      else
        response = "404 Error"
    end
  end

end

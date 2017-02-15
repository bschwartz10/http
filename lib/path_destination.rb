class PathDestination
attr_reader :close

def initialize
  @server_should_exit = false
  @counter = 0
  @close = false
end

  def hello
    @counter += 1
    "<h1> Hello, World! (#{@counter}) </h1>"
  end

  def date_time
    "<h1>#{Time.now.strftime('%H:%M%p on %A, %B %e, %Y')}</h1>"
  end

  def shut_down(number_of_requests)
    @close = true
    "<h1>Total Requests: #{number_of_requests}</h1>"
  end

end

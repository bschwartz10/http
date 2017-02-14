class PathDestination

def initialize
  @server_should_exit = false
  @counter = 0
end

  def hello
    @counter += 1
    "<h1> Hello, World! (#{@counter}) </h1>"
  end

  def date_time
    "<h1>#{Time.now.strftime('%H:%M%p on %A, %B %e, %Y')}</h1>"
  end
end

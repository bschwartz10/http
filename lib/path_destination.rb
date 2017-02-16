class PathDestination
attr_reader :close, :server_should_exit

def initialize
  @server_should_exit = false
  @counter = 0
  @close = false
  @dictionary = File.read("/usr/share/dict/words").split("\n")
end

  def hello
    @counter += 1
    "<h1> Hello, World! (#{@counter}) </h1>"
  end

  def date_time
    "<h1>#{Time.now.strftime('%H:%M%p on %A, %B %e, %Y')}</h1>"
  end

  def word_search(input_word)
    if @dictionary.include?(input_word)
      "<h1>#{input_word} is a known word</h1>"
    else
      "<h1>#{input_word} is not a known word</h1>"
    end
  end

  def shut_down(number_of_requests)
    @close = true
    "<h1>Total Requests: #{number_of_requests}</h1>"
  end

end

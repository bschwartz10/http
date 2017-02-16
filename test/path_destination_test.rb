require './lib/path_destination'
require 'minitest/autorun'
require 'minitest/pride'

class PathDestinationTest < Minitest::Test

  def test_it_exists
    destination = PathDestination.new

    assert_instance_of PathDestination, destination
  end

  def test_hello_is_running_correctly
    destination = PathDestination.new

    assert_equal "<h1> Hello, World! (1) </h1>", destination.hello
  end

  def test_date_time_is_running_correctly
    destination = PathDestination.new

    assert_equal "<h1>#{Time.now.strftime('%H:%M%p on %A, %B %e, %Y')}</h1>", destination.date_time
  end

  def test_word_search_is_running_correctly
    destination = PathDestination.new

    assert_equal "water is a known word", destination.word_search("water")
    assert_equal "dsds is not a known word", destination.word_search("dsds")
  end

  def test_shut_down_is_running_correctly
    destination = PathDestination.new

    assert_equal "<h1>Total Requests: 1</h1>", destination.shut_down(1)
  end

end

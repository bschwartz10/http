require 'faraday'
require 'minitest/autorun'
require 'minitest/pride'

class ServerTest < Minitest::Test

  def test_responds_200
    skip
    response = Faraday.get 'http://127.0.0.1:9292/'
    assert_equal 200, response.status
  end

  def test_it_can_follow_path_to_hello
    skip
    response = Faraday.get('http://localhost:9292/hello')
    assert response.body.include?("Hello")
  end

  def test_it_increments_the_counter
    skip
    response = Faraday.get 'http://127.0.0.1:9292/hello'
    assert response.body.include?("1")
    skip
    response = Faraday.get 'http://127.0.0.1:9292/hello'
    assert response.body.include?("2")
  end

  def test_it_can_follow_path_to_datetime
    skip
    response = Faraday.get('http://localhost:9292/datetime')
    assert response.body.include?("2017")
    assert response.body.include?("February")
  end

  def test_it_runs_word_seach_when_passed_path_and_params

    response = Faraday.get('http://localhost:9292/word_search?word=water')
    assert response.body.include?("water is a known word")
  end

end

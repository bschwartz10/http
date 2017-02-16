require 'faraday'
require 'minitest/autorun'
require 'minitest/pride'

class ServerTest < Minitest::Test
  i_suck_and_my_tests_are_order_dependent!

  def test_responds_200
    response = Faraday.get 'http://127.0.0.1:9292/'
    assert_equal 200, response.status
  end

  def test_aa_it_can_follow_path_to_hello
    response = Faraday.get('http://localhost:9292/hello')
    assert response.body.include?("Hello")
  end

  def test_ab_it_increments_the_hello_counter
    response = Faraday.get 'http://127.0.0.1:9292/hello'
    assert response.body.include?("2")

    response = Faraday.get 'http://127.0.0.1:9292/hello'
    assert response.body.include?("3")
  end

  def test_it_can_follow_path_to_datetime
    response = Faraday.get('http://localhost:9292/datetime')

    assert response.body.include?("2017")
    assert response.body.include?("February")
  end

  def test_it_can_follow_path_to_random_path
    response = Faraday.get('http://localhost:9292/random')

    assert response.body.include?("404 Error")
  end

  def test_it_runs_word_search
    response = Faraday.get('http://localhost:9292/word_search?word=water')

    assert response.body.include?("water is a known word")
  end

  def test_z_it_runs_shut_down
    response = Faraday.get('http://localhost:9292/shutdown')

    assert response.body.include?("Total Requests:")
  end

end

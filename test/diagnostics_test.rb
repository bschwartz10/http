require './lib/diagnostics'
require 'minitest/autorun'
require 'minitest/pride'

class DiagnosticsTest < Minitest::Test

  def setup
    @request_lines = ["GET /shutdown HTTP/1.1",
      "Host: 127.0.0.1:9292",
      "Connection: keep-alive",
      "Cache-Control: no-cache",
      "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.87 Safari/537.36",
      "Postman-Token: 50365def-de37-4ee1-7ad4-8eea3f95c0fd",
      "Accept: */*", "Accept-Encoding: gzip, deflate, sdch, br",
      "Accept-Language: en-US,en;q=0.8"]
  end

  def test_parses_through_request_lines
    diagnostic = Diagnostics.new
    result = "<pre>\nVerb: GET\nPath: /shutdown\nProtocol: HTTP/1.1\nHost: 127.0.0.1\nPort: 9292\nOrigin: 127.0.0.1\nAccept: */*\n</pre>"
    assert_equal result, diagnostic.response(@request_lines)
  end

end

require 'socket'
require_relative 'path_destination'
require_relative 'path_generator'
class Server
attr_reader :tcp_server, :counter, :number_of_requests


  def initialize(port_number)
    @tcp_server = TCPServer.new(9292)
    @number_of_requests = 0
    @generator = PathGenerator.new
  end

  def run_request_response
    until @generator.destination.close
      puts "Ready for a request"
      client = @tcp_server.accept

      request_lines = []
      while line = client.gets and !line.chomp.empty?
        request_lines << line.chomp
      end
      puts "Got this request:"
      puts request_lines.inspect

      response = @generator.path_generator(request_lines)

      puts "Sending response."

      output = "<html><head></head><body>#{response}</body></html>"
      headers = ["http/1.1 200 ok",
                "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
                "server: ruby",
                "content-type: text/html; charset=iso-8859-1",
                "content-length: #{output.length}\r\n\r\n"].join("\r\n")
      client.puts headers
      client.puts output

      puts ["Wrote this response:", headers, output].join("\n")

      puts "\nResponse complete, exiting."
    end
    client.close
  end
end

new_server = Server.new(9292)
new_server.run_request_response

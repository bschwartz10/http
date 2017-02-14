require 'socket'
require_relative 'path_destination'
class Server
attr_reader :tcp_server, :counter, :number_of_requests


  def initialize(port_number)
    @tcp_server = TCPServer.new(9292)
    @number_of_requests = 0
    @destination = PathDestination.new
    @path = ""
  end

  def diagnostics(request_lines)
    verb = request_lines[0].split[0]
    @path = request_lines[0].split[1]
    protocol = request_lines[0].split[2]
    host = request_lines[1].split(":")[1].lstrip
    port = request_lines[1].split(":")[2]
    origin = host
    accept = request_lines[-3].split(":")[1].lstrip

    "<pre>\nVerb: #{verb}\nPath: #{@path}\nProtocol: #{protocol}\nHost: #{host}\nPort: #{port}\nOrigin: #{origin}\nAccept: #{accept}\n</pre>"
  end

  def run_request_response
    until @server_should_exit
      puts "Ready for a request"
      client = @tcp_server.accept

      request_lines = []
      while line = client.gets and !line.chomp.empty?
        request_lines << line.chomp
      end
      diagnostics(request_lines)

      puts "Got this request:"
      puts request_lines.inspect

      @number_of_requests += 1
      response = path_generator(request_lines)


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

  def path_generator(request_lines)
    case @path
      when '/'
        response = diagnostics(request_lines)
      when '/hello'
        response = @destination.hello
      when '/datetime'
        response = @destination.date_time
      when '/shutdown'
        response = shut_down
    end
  end

  def shut_down
    @server_should_exit = true
    "<h1>Total Requests: #{@number_of_requests}</h1>"
  end

end

new_server = Server.new(9292)
new_server.run_request_response

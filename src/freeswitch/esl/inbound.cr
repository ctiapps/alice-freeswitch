require "socket"
require "socket/tcp_socket"
require "mutex"

module Alice
  module Freeswitch
    module ESL
      class Inbound
        @conn = TCPSocket.new
        @conn_lock = Mutex.new

        def initialize(@host = "127.0.0.1", @port : String | Int32 = 5038, @auth = "")
        end

        def start
        end

        def stop
          close
        end

        def connect
          @conn = TCPSocket.new(@host, @port)
          @conn.sync = true
          @conn.keepalive = false
          auth
        end

        def close
          @conn.close
        end

        def auth
          if read_response != ["Content-Type: auth/request"]
            puts "AUTH ERROR"
          else
            @conn.print "auth #{@auth}\n\n"
            # expeting:
            # Content-Type: command/reply
            # Reply-Text: +OK accepted
            read_response
          end
        end

        def read_response
          headers = [] of String

          loop do
            data = @conn.gets(delimiter: "\n", chomp: true).to_s
            break if data.empty?
            puts "RECEIVED: #{data}"
            headers.push data
          end
          puts "READ_RESPONSE: finished, data:\n#{headers.pretty_inspect}\n---"

          headers
        end
      end
    end
  end
end

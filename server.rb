require 'em-websocket'

EM.run {
  EM::WebSocket.run(:host => "localhost", :port => 8001) do |ws|
    ws.onopen { |handshake|
      puts "WebSocket connection open"

      # Access properties on the EM::WebSocket::Handshake object, e.g.
      # path, query_string, origin, headers

      # Publish message to the client
      # ws.send "Hello Client, you connected to #{handshake.path}"
    }

    ws.onclose { puts "Connection closed" }

    ws.onmessage { |msg|
      puts "Mensagem Recebida: #{msg}"

      if msg.to_i != ''
        arq = File.open("listanomes.txt", 'a')
        arq.write msg + ";\n"
        arq.close
        ws.send "Nome cadastrado com sucesso!"
        ws.close
      else
        arq = File.open("Grêmio.txt", 'w')
        arq.write "falha"
        arq.close
        ws.send "falha"
      end
    }
  end
}

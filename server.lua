-- Relay pin as output
gpio.mode(1, gpio.OUTPUT)

-- Include url_parser module
local parser = require "url_parser"

-- Create server
srv=net.createServer(net.TCP) 

srv:listen(80,function(conn) 
  conn:on("receive",function(conn,payload) 
    
    -- Parse request
    parsed_request = parser.parse(payload)

    if parsed_request == 'on' then gpio.write(1, gpio.HIGH) end
    if parsed_request == 'off' then gpio.write(1, gpio.LOW) end

    -- Display main page
    conn:send('<head>')
    conn:send('<script src="https://code.jquery.com/jquery-2.1.3.min.js"></script>')
    conn:send('<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">')
    conn:send('</head>')
    
    conn:send('<div class="container">')
    conn:send("<h1>Relay Control</h1>")
    conn:send('<div class="row">')
    
    conn:send('<div class="col-md-2"><input class="btn btn-block btn-lg btn-primary" type="button" value="On" onclick="on()"></div>')
    conn:send('<div class="col-md-2"><input class="btn btn-block btn-lg btn-danger" type="button" value="Off" onclick="off()"></div>')

    conn:send('</div></div>')
    
    conn:send('<script>function on() {$.get("/on");}</script>')
    conn:send('<script>function off() {$.get("/off");}</script>')
  end) 
  conn:on("sent",function(conn) conn:close() end)
end)
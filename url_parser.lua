-- Module declaration
local parser = {}

function parser.parse(request)

     -- Find start
     local e = string.find(request, "/")
     local request_handle = string.sub(request, e + 1)
     
     -- Cut end
     e = string.find(request_handle, "HTTP")
     request_handle = string.sub(request_handle, 0, (e-2))

     return request_handle

end

return parser
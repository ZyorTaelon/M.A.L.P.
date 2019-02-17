local os = require('os');
local url = os.getenv('SERVER_LOCATION') .. '/';
local filenames = {}
filenames["remote/malp.lua"] = "malp.lua"
filenames["shared/json.lua"] = "lib/json.lua"
filenames["shared/tunnel.lua"] = "lib/tunnel.lua"

local M = {};

function M.downloadAll()
  print("Starting file downloads...")
  for src, dest in pairs(filenames) do
    M.download(src, dest);
  end
end

-- rapid reuse may result in receiving cached pages
function M.download(src, dest)
  os.execute('wget -f ' .. url .. src .. ' /home/' .. dest);
end

return M;
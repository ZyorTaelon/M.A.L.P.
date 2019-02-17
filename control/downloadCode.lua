local os = require('os');
local url = os.getenv('SERVER_LOCATION') .. '/';
local filenames = {}
filenames["control/sgc.lua"] = "sgc.lua"
filenames["shared/tunnel.lua"] = "lib/tunnel.lua"

local M = {};

function M.downloadAll()
  print("Starting file downloads...")
  for src, dest in pairs(filenames) do
    print("src: " .. src)
    print("dest: " .. dest)
    M.download(src, dest);
  end
end

-- rapid reuse may result in receiving cached pages
function M.download(src, dest)
  print("downloading '" .. src .. "' to '" .. dest .. "'")
  local dlCmd = 'wget -f ' .. url .. src .. ' /home/' .. dest;
  print('executing ' .. dlCmd)
  os.execute(dlCmd);
end

return M;
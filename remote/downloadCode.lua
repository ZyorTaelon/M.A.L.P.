local os = require('os');

local url = os.getenv('SERVER_LOCATION') .. '/';
local filenames = {
  'malp.lua',
  'shared/tunnel'
};

local M = {};

function M.downloadAll(location)
  for index, name in pairs(filenames) do
    M.download(name, location);
  end
end

-- rapid reuse may result in receiving cached pages
function M.download(name, location)
  os.execute('wget -f ' .. url .. name .. ' ' .. location .. '/' .. name);
end

return M;
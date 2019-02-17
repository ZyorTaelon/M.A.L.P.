local tunnel = require("tunnel")



local M = {};

function M.turnLeft()
  print("sending turnLeft command...")
  tunnel.write({["command"]="turnLeft"});
end

return M;
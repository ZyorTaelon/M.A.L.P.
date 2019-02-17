local tunnel = require("tunnel")



local M = {};

function M.turnLeft()
  print("sending turnLeft command...")
  tunnel.write({["command"]="turnLeft"});
end

function M.turnRight()
  print("sending turnRight command...")
  tunnel.write({["command"]="turnRight"});
end

function M.moveUp()
  print("sending moveUp command...")
  tunnel.write({["command"]="moveUp"});
end

function M.moveDown()
  print("sending moveDown command...")
  tunnel.write({["command"]="moveDown"});
end

function M.moveForward()
  print("sending moveDown command...")
  tunnel.write({["command"]="moveForward"});
end

function M.moveBack()
  print("sending moveBack command...")
  tunnel.write({["command"]="moveBack"});
end

function M.moveLeft()
  print("sending moveLeft command...")
  tunnel.write({["command"]="moveLeft"});
end

function M.moveRight()
  print("sending moveRight command...")
  tunnel.write({["command"]="moveRight"});
end

return M;
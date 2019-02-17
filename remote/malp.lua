local component = require("component")
local robot = component.robot
local tunnel = component.tunnel;
local event = require("event")
connection = require('tunnel');

function turnLeft()
  robot.turnLeft();
end

function turnRight()
  robot.turnRight()
end

function executeCommand()
  local data = connection.read();
  local result = commandMap[data['name']](unpack(data['parameters']));
  connection.write({['command result']={data['name'], result}});
  connection.write({['power level']=computer.energy()/computer.maxEnergy()});
end


continueLoop = true;

local cleanup_thread = thread.create(function()
  event.pull("interrupted")
  continueLoop = false
  print("Interrupt received. Exiting")
end)

local main_thread = thread.create(function()
  print("Waiting for incoming commands:")
  while continueLoop do
    local success, message = executeCommand() -- pcall(executeCommand);
    if not success then
      print(message);
      connection.close();
      -- unloading 'computer' breaks stuff, it can't be required again for some reason
      local loadedPackages = {'tunnel', 'trackPosition', 'sendScan', 'doToArea', 'commandMap'};
      for index, p in pairs(loadedPackages) do
        package.loaded[p] = nil;
      end
      -- wait for server to come back up
      os.sleep(5);
      -- reconnect to server
      loadPackages();
    end
  end
end)
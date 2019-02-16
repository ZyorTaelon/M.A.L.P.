function loadPackages()
  connection = require('tcp');
  commandMap = require('commandMap');
  dta = require('doToArea');
  int = require('interact');
  sendScan = require('sendScan');
  pos = require('trackPosition');
  
end
loadPackages();

local thread = require("thread");
local event = require("event");
local scanDirection = require('scanDirection');
local orient = require('trackOrientation');
local mas = require('moveAndScan');
local robot = require('robot');
local adj = require('adjacent');
local craft = require('craft');
local computer = require('computer');
local config = require('config');
local raw = config.get(config.path).components.raw;
local rawBool = (raw == "true" or raw == true) and true or false;

function runInTerminal(commandText)
  local file = assert(io.popen(commandText, 'r'));
  local output = file:read('*all');
  file:close();
  return output;
end

function unpack (t, i)
  i = i or 1;
  if t[i] ~= nil then
    return t[i], unpack(t, i + 1);
  end
end

-- wait until a command exists, grab it, execute it, and send result back
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
  while continueLoop do
    local success, message = pcall(executeCommand);
    if not success then
      print(message);
      connection.close();
      -- unloading 'computer' breaks stuff, it can't be required again for some reason
      local loadedPackages = {'tcp', 'trackPosition', 'sendScan', 'doToArea', 'commandMap'};
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

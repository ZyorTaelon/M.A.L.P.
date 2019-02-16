local tunnel = require('tunnel');
local event = require("event")
local JSON = require("json");
local config = require('config');
local conf = config.get(config.path);

-- local handle = internet.open(conf.serverIP, tonumber(conf.tcpPort));
-- handle:setvbuf('line');
-- handle:setTimeout('10');

local delimiter = '\n';

local M = {};

function M.read()
  -- reads delimited by newlines
  local _, _, from, port, _, message = event.pull("modem_message")
  return JSON:decode(message);
end

function M.write(data)
  local status, result = pcall(function()
    -- without the newline the write will wait in the buffer
    tunnel.send(JSON:encode(data));
  end);
  if not status then
    local errorMessage = {['message']='Failed to serialize result!'};
    tunnel.send(JSON:encode(errorMessage));
  end
  return status;
end

function M.close()
  return true;
end

M.write({id={account=conf.accountName, robot=conf.robotName}});

return M;

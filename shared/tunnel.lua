local component = require("component")
local tunnel = component.tunnel;
local event = require("event")
local JSON = require("json");

local delimiter = '\n';

local M = {};

function M.read()
  -- reads delimited by newlines
  local _, _, from, port, _, message = event.pull("modem_message")
  print("received message from server: " .. message)
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

return M;

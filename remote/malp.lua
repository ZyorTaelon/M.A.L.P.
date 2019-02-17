local component = require("component")
local robot = component.robot
local tunnel = component.tunnel;
local event = require("event")
local thread = require("thread")
connection = require('tunnel');

function turnLeft()
  print("Telling robot to turn left...")
  robot.turn(false);
end

function turnRight()
  robot.turn(true)
end

function moveUp()
  robot.up()
end

function moveDown()
  robot.down()
end

function executeCommand()
  local data = connection.read();
  print("received command: " .. data["command"])
  local cmd = data["command"]
  if cmd == "turnLeft" then
    turnLeft()
    return true
  elseif cmd == "turnRight" then
    turnRight()
    return true
  elseif cmd == "moveUp" then
    moveUp()
    return true
  elseif cmd == "moveDown" then
    moveDown()
    return true
  end
--  connection.write({['command result']={data['name'], result}});
--  connection.write({['power level']=computer.energy()/computer.maxEnergy()});
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
    end
  end
end)
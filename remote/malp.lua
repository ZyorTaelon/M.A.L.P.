local component = require("component")
local robot = require("robot")
local sides = require("sides")
local tunnel = component.tunnel;
local event = require("event")
local thread = require("thread")
connection = require('tunnel');

function turnLeft()
  return robot.turnLeft();
end

function turnRight()
  return robot.turnRight()
end

function moveUp()
  return robot.up()
end

function moveDown()
  return robot.down()
end

function moveForward()
  return robot.forward()
end

function moveBack()
  return robot.back()
end

function moveLeft()
  turnLeft()
  moveForward()
  return turnRight()
end

function moveRight()
  turnRight()
  moveForward()
  return turnLeft()
end

function executeCommand()
  local data = connection.read();
  print("received command: " .. data["command"])
  local cmd = data["command"]
  if cmd == "turnLeft" then
    return turnLeft()
  elseif cmd == "turnRight" then
    return turnRight()
  elseif cmd == "moveUp" then
    return moveUp()
  elseif cmd == "moveDown" then
    return moveDown()
  elseif cmd == "moveForward" then
    return moveForward()
  elseif cmd == "moveBack" then
    return moveBack()
  elseif cmd == "moveLeft" then
    return moveLeft()
  elseif cmd == "moveRight" then
    return moveRight()
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
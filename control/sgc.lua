local event = require("event") -- load event table and store the pointer to it in event
local thread = require("thread")
local movement = require("movement")
 
local char_space = string.byte(" ") -- numerical representation of the space char
local char_w = string.byte("w") -- numerical representation of the w char
local char_a = string.byte("a") -- numerical representation of the a char
local char_s = string.byte("s") -- numerical representation of the s char
local char_d = string.byte("d") -- numerical representation of the d char
local char_j = string.byte("j") -- numerical representation of the j char
local char_l = string.byte("l") -- numerical representation of the l char
local char_i = string.byte("i") -- numerical representation of the i char
local char_k = string.byte("k") -- numerical representation of the k char
local running = true -- state variable so the loop can terminate
 
function unknownEvent()
  -- do nothing if the event wasn't relevant
end
 
-- table that holds all event handlers
-- in case no match can be found returns the dummy function unknownEvent
local myEventHandlers = setmetatable({}, { __index = function() return unknownEvent end })
 
-- Example key-handler that simply sets running to false if the user hits space
function myEventHandlers.key_up(adress, char, code, playerName)
  if (char == char_space) then
    running = false
  elseif (char == char_w) then
    movement.moveForward();
  elseif (char == char_a) then
    movement.moveLeft()
  elseif (char == char_s) then
    movement.moveBack()
  elseif (char == char_d) then
    movement.moveRight()
  elseif (char == char_j) then
    movement.turnLeft()
  elseif (char == char_l) then
    movement.turnRight()
  elseif (char == char_i) then
    movement.moveUp()
  elseif (char == char_k) then
    movement.moveDown()
  else
    print("key pressed: " .. char)
  end
end
 
-- The main event handler as function to separate eventID from the remaining arguments
function handleEvent(eventID, ...)
  if (eventID) then -- can be nil if no event was pulled for some time
    myEventHandlers[eventID](...) -- call the appropriate event handler with all remaining arguments
  end
end

local cleanup_thread = thread.create(function()
  event.pull("interrupted")
  running = false
  print("Interrupt received. Exiting")
end)

-- main event loop which processes all events, or sleeps if there is nothing to do
local main_thread = thread.create(function()
  while running do
    handleEvent(event.pull()) -- sleeps until an event is available, then process it
  end
end)
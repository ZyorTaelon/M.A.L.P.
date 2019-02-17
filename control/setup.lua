local os = require('os');
local filesystem = require("filesystem")
os.setenv('SERVER_LOCATION', 'https://raw.githubusercontent.com/ZyorTaelon/M.A.L.P./master')
local codeURL = os.getenv('SERVER_LOCATION');
local fileName = '/downloadCode.lua'

if not filesystem.exists('/home/lib') then
  filesystem.makeDirectory('/home/lib')
end
  
local command = 'wget -f ' .. codeURL .. fileName .. ' ' .. '/home/lib' .. fileName
print("executing command: '" .. command .. "'")
os.execute(command);
local dl = require("downloadCode");
dl.downloadAll();

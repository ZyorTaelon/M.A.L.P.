local os = require('os');
os.setenv('SERVER_LOCATION', 'https://raw.githubusercontent.com/ZyorTaelon/M.A.L.P./master/control')
local codeURL = os.getenv('SERVER_LOCATION');
local fileName = '/downloadCode.lua'
local command = 'wget -f ' .. codeURL .. fileName .. ' ' .. '/home/lib' .. fileName
print("executing command: '" .. command .. "'")
os.execute(command);
local dl = require("downloadCode");
dl.downloadAll();

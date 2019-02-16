local path = '/home/lib';
local os = require('os');
os.setenv('SERVER_LOCATION', 'https://raw.githubusercontent.com/ZyorTaelon/M.A.L.P./master/bin')
local codeURL = os.getenv('SERVER_LOCATION');
local fileName = '/downloadCode.lua'
os.execute('wget -f ' .. codeURL .. fileName .. ' ' .. path .. fileName);
local dl = require("downloadCode");
dl.downloadAll(path);
-- local config = require("config");
-- config.easy(config.path);
-- require('commandLoop');

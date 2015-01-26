-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here


-- hide the status bar
display.setStatusBar( display.HiddenStatusBar )
 
-- Set up some global variables for our game
screenW, screenH, halfW, halfH = display.contentWidth, display.contentHeight, display.contentWidth*0.5, display.contentHeight*0.5
 
-- include the Corona "storyboard" module
local storyboard = require "storyboard"
 
-- load menu screen
storyboard.gotoScene("scripts.menu")
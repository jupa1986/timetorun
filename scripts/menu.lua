
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
 
local screen = nil

 function scene:createScene(event)
 	screen = self.view
 	local bg = display.newImageRect("images/bgInicio.png", 1280, 720) --change to background image
	bg.x = display.contentWidth/2
	bg.y = display.contentHeight/2
	screen:insert(bg)

	local function inicioListener( event )
	    if (event.phase == "began") then
	    	storyboard.gotoScene("scripts.level1")
			storyboard.removeScene( "scripts.menu" ) 
	    end
	    return true  --prevents touch propagation to underlying objects
	end
	local startButton = display.newImage("images/play_button.png")
	startButton.x = 200
	startButton.y = 450
	startButton:addEventListener("touch", inicioListener)  --add a "touch" listener to the object
	screen:insert(startButton)
 end

 scene:addEventListener( "createScene", scene )
 return scene
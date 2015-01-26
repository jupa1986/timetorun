	
local storyboard = require("storyboard")
local scene = storyboard.newScene()
local physics = require "physics";
local sounds = require ("scripts.soundsfile")
-- Clear previous scene
-- storyboard.removeAll()
-- physics.start();

local screen = nil
playgameMusic(gamebgmusic)

function scene:createScene(event)
	
	screen = self.view
	local flagJump = false
	local physicsGroup = display.newGroup()
	local RandomObject = {}
	local RandomSpawnSheep = {}
	local RandomPig = {}
	local transitionTime = 4000

	screen:insert(physicsGroup)

	-- NOTE:
	-- initially we are going to create our bodies as static, and keep the world gravity as 0
	-- this is a good idea when building complex structures in box2d. After you are happy with the positioning of everything, go back and change things to dynamic

	physics.start()
	local speedChange ={}
	speedChange.speed = 0

	-- physics.setGravity(0, 9.8)
	--physics.setDrawMode("hybrid") -- other draw modes are "normal" (default), and "debug"	

	-----------------------------------------------------------
	-- Create Background Parallax
	local background = display.newImage("images/bg.png");
	--background.anchorX = 0
	--background.anchorY = 1
	background.x = display.contentCenterX
	background.y = display.contentCenterY

	local city1 = display.newImage("images/city1.png");
	-- city1:setReferencePoint(display.BottomLeftReferencePoint)
	city1.anchorX = 0
	city1.anchorY = 1
	city1.x = 0
	city1.y = display.contentHeight-20
	city1.speed = 2

	local city2 = display.newImage("images/city1.png");
	--city2:setReferencePoint(display.BottomLeftReferencePoint)
	city2.anchorX = 0
	city2.anchorY = 1
	city2.x = 1280
	city2.y = display.contentHeight-20
	city2.speed = 2

	local city3 = display.newImage("images/city2.png");
	--city3:setReferencePoint(display.BottomLeftReferencePoint)
	city3.anchorX = 0
	city3.anchorY = 1
	city3.x = 0
	city3.y = display.contentHeight-20
	city3.speed = 3

	local city4 = display.newImage("images/city2.png");
	city4.anchorX = 0
	city4.anchorY = 1
	city4.x = 1280;
	city4.y = display.contentHeight-20
	city4.speed = 3

	---------------------------------------------
	-- Obstacles
	--[[
	local sheep = display.newImage("images/sheep-128.png");
	sheep.anchorX = 0
	sheep.anchorY = 1
	sheep.x = display.contentWidth/2
	sheep.y = display.contentHeight-20
	sheep.speed = 2
	--]]
	---------------------------------------------

	--------------------------------------------------------------------------
	-- create the floor
	--local floor = display.newRect(0, 0, display.contentWidth, 40)
	--floor:setFillColor(0,128,128)
	local floor1 = display.newImage("images/Floor.png")
	floor1.x, floor1.y = display.contentCenterX, display.contentHeight-20
	floor1.speed = 3
	floor1.myName = "floor"
	
	--[[
	local floor2 = display.newImage("images/Floor.png")
	floor2.x, floor2.y = 1280, display.contentHeight-20
	floor2.speed = 2
	floor2.myName = "floor"
	--]]
	physics.addBody(floor1, "static", { friction=0.5, bounce=0.3}) -- create a default physics body for the floor
	--physics.addBody(floor2, "static", { friction=0.5, bounce=0.3}) -- create a default physics body for the floor
	
	--------------------------------------------------------------------------

	function scrollCity(self, event)
		if self.x < -1275 then
			self.x = 1280
		else 
			self.x = self.x - self.speed
		end
	end

	function changeSpeed(self,event)
		if self.speed == 100 then
			self.speed = 0;
			city1.speed = city1.speed + 0.4
			city2.speed = city2.speed + 0.4
			city3.speed = city3.speed + 0.4
			city4.speed = city4.speed + 0.4
			--floor1.speed = floor1.speed + 0.4
			--floor2.speed = floor2.speed + 0.4
			--sheep.speed = sheep.speed + 0.4
		else
			self.speed = self.speed + 1
		end
	end

	---------------------------------------------------
	-- Create Random sheeps
	local w = display.contentWidth

	function animateobj(i,delay,sw)
		if(sw == 1)then
			transition.to(RandomObject[i],{time=transitionTime,delay=delay,x=-100})
			transition.to(RandomSpawnSheep[i],{time=transitionTime,delay=delay,x=-100})
		else
			transition.to(RandomPig[i],{time=transitionTime,delay=delay,x=-100})
		end
	end

	local delay,t,dist,sw=300,nil,1350,nil
	
	for i=1, 100 do
		sw = math.random(1,2)
		if(sw == 1)then
			RandomObject[i] = display.newImage("images/oveja.png")
			RandomObject[i].x = dist
			RandomObject[i].y = display.contentHeight-104
			
			RandomSpawnSheep[i] = display.newRect(0,0,116,128)
			RandomSpawnSheep[i]:setFillColor(255,0,0)
			RandomSpawnSheep[i].x = dist
			RandomSpawnSheep[i].y = display.contentHeight-104
			RandomSpawnSheep[i].myName = "oveja"
			RandomSpawnSheep[i].alpha = 0
			
			physics.addBody(RandomSpawnSheep[i],"static",{density=0.5, friction=0.5, bounce=0.3})
		else
			RandomPig[i] = display.newImage("images/Sprite2.png")
			RandomPig[i].x = 1350
			RandomPig[i].y = math.random(250,420)
			RandomPig[i].myName = "cerdo"

			physics.addBody(RandomPig[i],"static",{density=0.5, friction=0.5, bounce=0.3})
		end
		t = math.random(2000,3500)
		animateobj(i,delay,sw)
		delay = delay + t
	end
	---------------------------------------------------

	speedChange.enterFrame = changeSpeed
	Runtime:addEventListener( "enterFrame", speedChange) 

	city1.enterFrame = scrollCity
	Runtime:addEventListener( "enterFrame", city1 )

	city2.enterFrame = scrollCity
	Runtime:addEventListener( "enterFrame", city2 )

	city3.enterFrame = scrollCity
	Runtime:addEventListener( "enterFrame", city3 )

	city4.enterFrame = scrollCity
	Runtime:addEventListener( "enterFrame", city4 )

	--floor1.enterFrame = scrollCity
	--Runtime:addEventListener("enterFrame", floor1)
	
	--floor2.enterFrame = scrollCity
	--Runtime:addEventListener("enterFrame", floor2)
	-------------------------------------------------------------------------

	screen:insert(background)
	screen:insert(city1)
	screen:insert(city2)
	screen:insert(city3)
	screen:insert(city4)

	--------------------------------------------------------
	-- SPRITE PERSON ANIMATION 
	local options = {
	   width = 192,
	   height = 192,
	   numFrames = 10
	}

	local mySheet = graphics.newImageSheet( "images/Sprite.png", options )
	local sequenceData={
		{name = "normalRun", start=1, count=8, time=1000},
		{name = "fastRun", frames={1,2,4,5,6,7}, time=600},
		{name = "jump", frames={9}, time=250},
		{name = "down", frames={10}, time=250, loopCount = 1},
	}

	animation = display.newSprite(mySheet, sequenceData)
	animation.x = 250
	animation.y = display.contentHeight-30
	animation.myName = "person"

	animation:setSequence("fastRun")
	animation:play()

	physics.addBody(animation,{density=0.5, friction=0.5, bounce=0.3})

	screen:insert(animation)
	screen:insert(floor1)
	-----------------------------------------------------------

	-----------------------------------------------------------
	-- TOUCH LISTENER
	local function jumpListener( event )
	    if (event.phase == "began" and animation.y>=550) then
			animation:applyForce( 0, -7500, animation.x, animation.y)
			animation:setSequence("jump")
	    	animation:play()
	    	flagJump=true
	    end
	    return true  --prevents touch propagation to underlying objects
	end

	local function restartRun()
		animation:setSequence("fastRun")
		animation:play()
	end


	local function downListener(event)
	    if (event.phase == "began" and animation.y>=550) then
	    	print("DOWNLISTENER---------------")
			animation:setSequence("down")
	    	animation:play()
	    	timer.performWithDelay(1000,restartRun,1)
	    end
	    return true  --prevents touch propagation to underlying objects
	end	

	local jumpButton = display.newImage("images/up.png")
	jumpButton.x = display.contentWidth-64
	jumpButton.y = 320
	jumpButton:addEventListener( "touch", jumpListener )  --add a "touch" listener to the object

	local downButton = display.newImage("images/down.png")
	downButton.x = 64
	downButton.y = 320
	downButton:addEventListener( "touch", downListener)  --add a "touch" listener to the object

	screen:insert(jumpButton)
	screen:insert(downButton)
	-- END OF TOUCH LISTENER
	-----------------------------------------------------------------------

	------------------------------------------------------------------------
	-- OnCollision
	local function onCollision( event )
	    if ( event.phase == "began") then
	    	if(flagJump and (event.object1.myName == "floor" and event.object2.myName == "person") or (event.object2.myName == "floor" and event.object1.myName == "person"))then
	        		print("JUMP--------------")
	        		animation:setSequence("fastRun")
	        		animation:play()
	        		flagJump = false
	    	else
	    		if((event.object1.myName == "oveja" and event.object2.myName == "person") or (event.object2.myName == "oveja" and event.object1.myName == "person"))then
	    			-- storyboard.gotoScene("scripts.menu")
	    			storyboard.gotoScene( "scripts.menu", "slideLeft", 500) 
	    			storyboard.removeScene( "scripts.level1" )
	    			--animation.destroy()
					for i=1,100 do
						display.remove(RandomObject[i])
						display.remove(RandomSpawnSheep[i])
						display.remove(RandomPig[i])
					end
				else
					if((event.object1.myName == "cerdo" and event.object2.myName == "person") or (event.object2.myName == "cerdo" and event.object1.myName == "person"))then
						storyboard.gotoScene( "scripts.menu", "slideLeft", 500) 
						storyboard.removeScene( "scripts.level1" )
						--animation.destroy()
						-- storyboard.state.score = storyboard.state.score + 1 
						for i=1,100 do
							display.remove(RandomObject[i])
							display.remove(RandomSpawnSheep[i])
							display.remove(RandomPig[i])
						end
					end
	    		end
	    	end
	    end
	end

	Runtime:addEventListener( "collision", onCollision)

	------------------------------------------------------------------------------
	--screen:insert(RandomSpawnSheep)
	--screen:insert(RandomObject)
	-- ACCELEROMETER
	--[[
	Circle = display.newCircle( 0, 0, 40)
	Circle:setFillColor(255)
	centerX = 640
	centerY = 360

	Circle.x = centerX
	Circle.y = centerY
	function onAccelerate(event)
		frameUpdate = false  -- update done
		-- Move our object based on the accelerator values
		Circle.x = centerX + (centerX * event.xGravity)
		Circle.y = centerY + (centerY * event.yGravity* -1)
	end

	-- Function called every frame
	-- Sets update flag to time our color changes
	--
	local function onFrame()
		frameUpdate = true
	end

	-- Set up the accelerometer to provide measurements 60 times per second.
	-- Note that this matches the frame rate set int he "config.lua" file.

	system.setAccelerometerInterval(60)
	-- Add runtime listener
	--
	Runtime:addEventListener("accelerometer", onAccelerate)
	Runtime:addEventListener("enterFrame", onFrame)
	--]]
end


scene:addEventListener( "createScene", scene )

return scene

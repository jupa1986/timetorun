
ButtonSound = {};
ButtonSound.new = function(params)
	
	local btn = display.newGroup();
	
	local offIMG = params and params.off or "images/plays.png";
	local onIMG = params and params.on or "images/pause.png";
	
	local off = display.newImageRect(offIMG, 100, 100);
	local on = display.newImageRect(onIMG, 100, 100);
	

	on.alpha = 0;
	
	btn:insert(off);
	btn:insert(on);
	
	btn.x = params and params.x or 0;
	btn.y = params and params.y or 0;
	
	function btn:touch(e)
		if(e.phase == "began") then
			on.alpha = 1;
			display.getCurrentStage():setFocus(self);
			self.hasFocus = true;
			pauseMusic (gamebgmusic)
			
		elseif(self.hasFocus) then
			if(e.phase == "ended") then
				on.alpha = 0;
				display.getCurrentStage():setFocus(nil);
				self.hasFocus = false;
			end
		end
	end
	
	btn:addEventListener("touch",btn);
	
	return btn;
end --end Button class declaration

--local fooBarButton = Button.new();
--fooBarButton.x = _W * 0.5;
--fooBarButton.y = _H * 0.5;
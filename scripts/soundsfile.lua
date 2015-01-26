--soundeffects 
audiolaunchbear = audio.loadSound ("audio/BackGround.mp3")
audiowinsound = audio.loadSound ("audio/BackGround.mp3")
audioclick = audio.loadSound ("audio/BackGround.mp3")
audiolever = audio.loadSound ("audio/BackGround.mp3")
gamebgmusic = audio.loadStream ("audio/BackGround.mp3")


soundisOn = true 
musicisOn = true 

audio.reserveChannels (1) -- one audio channel we need to reserve for the background music 


function playSFX (soundfile, volumelevel)

 	if soundisOn == true then 
		local volumelevel = volumelevel or 0.5
		audio.play(soundfile)
		audio.setVolume(volumelevel, {soundfile} )
	end 
	
end 

function playgameMusic (soundfile)
	musicisOn = true 
	if musicisOn == true then 
	audio.play (soundfile, {channel = 1, loops = -1 , fadein=2500})
	end

end

function resetMusic (soundfile)

	if musicisOn == true then 
		audio.stop(1)
		audio.rewind (gamebgmusic)	
	end

end

function pauseMusic (soundfile)
	if musicisOn == true then 
	audio.pause()
	end
end

function resumeMusic (channel)
	if musicisOn == true then 
	audio.resume(channel)
	end
end
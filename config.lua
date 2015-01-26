application =
{

	content =
	{
		--graphicsCompatibility = 1,
		width = 720,
		height = 1280, 
		scale = "letterBox",
		fps = 40,
		
		--[[
		imageSuffix =
		{
			    ["@2x"] = 2,
		},
		--]]
	},

	--[[
	-- Push notifications
	notification =
	{
		iphone =
		{
			types =
			{
				"badge", "sound", "alert", "newsstand"
			}
		}
	},
	--]]    
}

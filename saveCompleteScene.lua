-----------------------------------------------------------------------------------------
--
-- saveScene.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	

	local sceneGroup = self.view

	local saveCompleteBox = display.newImageRect("image/component/(임시)저장완료.png", 500, 400)
	saveCompleteBox.x, saveCompleteBox.y = display.contentCenterX, display.contentCenterY
	sceneGroup:insert(saveCompleteBox)

	--메뉴창 닫기버튼 그림--
	local menuCloseButton = display.newImage("image/component/menu_close.png")
	menuCloseButton.x, menuCloseButton.y = display.contentCenterX*1.4, display.contentCenterY*0.4
	sceneGroup:insert(menuCloseButton)

	--메뉴닫기--
	local function menuClose(event)
		if(event.phase == "began") then
			if(composer.getVariable("sceneName") == home) then

			else
				dialogueBox:addEventListener("tap", nextScript)
			end
			composer.hideOverlay()
		end
	end
	menuCloseButton:addEventListener("touch", menuClose)
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
	end	
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end
end

function scene:destroy( event )
	local sceneGroup = self.view
	
	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene
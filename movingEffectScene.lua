-----------------------------------------------------------------------------------------
--
-- 스토리 폐허 파트 상.lua
--
-----------------------------------------------------------------------------------------

local composer = require("composer")
local scene = composer.newScene()

function scene:create(event)
	local sceneGroup = self.view
	
-------------------변수-------------------------------------------------------------------------------

	--배경 그림--

	local background = display.newRect(display.contentWidth/2, display.contentHeight/2, display.contentWidth, display.contentHeight)
	background:setFillColor(black)
	sceneGroup:insert(background)

	local text = display.newText("저장 위치로 이동 중입니다...", display.contentCenterX, display.contentCenterY, "fonts/GowunBatang-Bold", 25)
	text:setFillColor(1)
	sceneGroup:insert(text)


	local targetScene = event.params.targetScene
	local scriptNum = event.params.scriptNum

	print("moving.. targetScene: ", targetScene)
	print("moving.. scriptNum", scriptNum)

	local loadOption =
	{
	    effect = "fade",
	    time = 400,
	    params = {
	        scriptNum = scriptNum
	    }
	}

	local function afterTimer()
		print("afterTimer runs!")
		composer:gotoScene(targetScene, loadOption)
	end	

	-- 텍스트 출력동안 대기
	timer.performWithDelay( 1500, afterTimer)
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
		print("movingEffectScene: show")
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
		composer.removeScene("movingEffectScene")
		print("movingEffectScene: hide")
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
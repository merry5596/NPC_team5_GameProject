-----------------------------------------------------------------------------------------
--
-- 메뉴창.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
	
-------------------변수--------------------------------------------------------------------------

	--배경 그림--
	local background = display.newRect(display.contentCenterX, display.contentCenterY, 
		display.contentWidth, display.contentHeight)
	background:setFillColor(1, 0.5)

	--메뉴창 그림--
	local menuBox = display.newImage("image/component/menu_box.png")
	menuBox.x, menuBox.y = display.contentCenterX, display.contentCenterY

	--메뉴창 닫기버튼 그림--
	local menuCloseButton = display.newImage("image/component/menu_close.png")
	menuCloseButton.x, menuCloseButton.y = display.contentCenterX*1.635, display.contentCenterY*0.55

	--메뉴창 시작화면으로 그림--
	local menuTitleScreen = display.newImage("image/component/menu_gotomain.png")
	menuTitleScreen.x, menuTitleScreen.y = display.contentCenterX, display.contentCenterY*0.65

	--메뉴창 저장하기 그림--
	local menuSave = display.newImage("image/component/menu_save.png")
	menuSave.x, menuSave.y = display.contentCenterX, display.contentCenterY

	--메뉴창 불러오기 그림--
	local menuLoad = display.newImage("image/component/menu_import.png")
	menuLoad.x, menuLoad.y = display.contentCenterX, display.contentCenterY*1.35

-------------------함수----------------------------------------------------------------------------

	--메뉴닫기--
	local function menuClose(event)
		if(event.phase == "began") then
			sceneGroup:insert(background)
			sceneGroup:insert(menuBox)
			sceneGroup:insert(menuCloseButton)
			sceneGroup:insert(menuTitleScreen)
			sceneGroup:insert(menuSave)
			sceneGroup:insert(menuLoad)
			composer.hideOverlay("menuScene")
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
		-- parent:create()
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
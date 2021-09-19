local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	--배경--
	local background = display.newImageRect("image/background/quest.png", display.contentWidth, display.contentHeight)
	background.x, background.y = display.contentWidth*0.5, display.contentHeight*0.5
	sceneGroup:insert(background)

	local menuButton = display.newImage("image/component/menu_button.png")
	menuButton.x, menuButton.y = display.contentWidth*0.92, display.contentHeight*0.1
	sceneGroup:insert(menuButton)

	-- 퀘스트 클리어 박스--
	local qclearBox = display.newImageRect("image/component/퀘스트클리어(수정).png", 800, 270)
	qclearBox.x, qclearBox.y = display.contentCenterX, display.contentCenterY
	sceneGroup:insert(qclearBox)

	--퀘스트 클리어
	local qclear = display.newText("다음 스토리 해금", display.contentCenterX, display.contentCenterY+40, "fonts/GowunBatang-Bold.ttf", 30)
	sceneGroup:insert(qclear)

	local inventoryBox = display.newImage("image/component/inventory_box.png")
	inventoryBox.x, inventoryBox.y = display.contentWidth*0.365, display.contentHeight*0.58
	inventoryBox.isVisible = false
	sceneGroup:insert(inventoryBox)

	local scrollbar = display.newImage("image/component/inventory_scroll.png")
	scrollbar.x, scrollbar.y = display.contentWidth*0.6736, display.contentHeight*0.35
	scrollbar.isVisible = false
	sceneGroup:insert(scrollbar)

	local function fitImage( displayObject, fitWidth, fitHeight, enlarge )

	local scaleFactor = fitHeight / displayObject.height 
	local newWidth = displayObject.width * scaleFactor
		if newWidth > fitWidth then
			scaleFactor = fitWidth / displayObject.width 
		end
		if not enlarge and scaleFactor > 1 then
			return
		end
		displayObject:scale( scaleFactor, scaleFactor )
	end

	local closeButton = display.newImage("image/component/menu_close.png")
	fitImage( closeButton, 50, 50, true )
	closeButton.x, closeButton.y = display.contentWidth*0.6736, display.contentHeight*0.24
	closeButton.isVisible = false
	sceneGroup:insert(closeButton)

	--메뉴열기--
	local function menuOpen(event)
	  	if(event.phase == "began") then
	  		composer.setVariable("sceneName", home)
	  		composer.showOverlay("menuScene")
	  	end
	end
	menuButton:addEventListener("touch", menuOpen)

	--메뉴 시작화면으로 버튼 클릭시 장면 닫고 타이틀화면으로 이동--
	function scene:closeScene()
		composer.removeScene("homeScene") --현재 장면 이름 넣기 ex)storyScene
		composer.gotoScene("scene1")
	end

	local questNum = composer.getVariable("questNum")
	local targetScene = "homeScene"
	if questNum == 1 then
		targetScene = "story_forest1_1"
	elseif questNum == 2 then
		targetScene = "story_forest1_2"
	elseif questNum == 3 then
		targetScene = "story_ruins_2"
	elseif questNum == 4 then
		targetScene = "story_ruins_3"
	elseif questNum == 5 then
		targetScene = "story_forest2_2"
	elseif questNum == 6 then
		targetScene = "story_before_ending"
	end
	print(targetScene)

	local loadsave = require( "loadsave" )

	local userSettings = loadsave.loadTable("userSettings.json")

	userSettings.presentScene = targetScene
	loadsave.saveTable(userSettings, "userSettings.json")

	local loadOption =
	{
	    effect = "fade",
	    time = 400
	}

	local function afterTimer()
		print("afterTimer runs!")
		composer:gotoScene(targetScene, loadOption)
	end	

	-- 텍스트 출력동안 대기
	timer.performWithDelay( 3000, afterTimer)
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
		composer.removeScene("quest_clear")

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

return scene


local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
	local loadsave = require( "loadsave" )

	local userSettings = loadsave.loadTable("userSettings.json")
	userSettings.questInfo = {
    	questNum = 6,
    	questName = "무덤가에 피는 꽃", 
    	maxJewerlyNum = 5,
    	targetLevel = 252,
    	areaName = "무덤가",
    	backgroundImage = "image/background/tomb.png"
	}
	loadsave.saveTable(userSettings, "userSettings.json")
	
	--배경--
	local background = display.newImageRect("image/background/quest.png", display.contentWidth, display.contentHeight)
	background.x, background.y = display.contentWidth*0.5, display.contentHeight*0.5
	sceneGroup:insert(background)

	-- local menuButton = display.newImage("image/component/menu_button.png")
	-- menuButton.x, menuButton.y = display.contentWidth*0.92, display.contentHeight*0.1
	-- sceneGroup:insert(menuButton)

	-- 퀘스트 제시 박스--
	local quest = display.newImageRect("image/component/퀘스트제시(수정).png", 700, 600)
	quest.x, quest.y = display.contentCenterX, display.contentCenterY
	sceneGroup:insert(quest)

	local options = 
	{
	    text = "무덤가에 피는 꽃\n\n선생님의 방에서 약도를 찾았다.\n\n선생님 동료들의 무덤가가 있는 장소인 듯하다.\n\n일단 가보는 것이 좋겠지...\n\n선생님의 말씀을 되새겨보며 가보도록 하자.",
	    x = display.contentCenterX,
	    y = display.contentCenterY+30,
	    font = "fonts/GowunBatang-Bold.ttf",
	    fontSize = 24,
	    align = "center"
	}

	local myText = display.newText( options )
	myText:setFillColor( 1 )
	sceneGroup:insert(myText)

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
	-- local function menuOpen(event)
	--   	if(event.phase == "began") then
	--   		composer.setVariable("sceneName", home)
	--   		composer.showOverlay("menuScene")
	--   	end
	-- end
	-- menuButton:addEventListener("touch", menuOpen)

	--메뉴 시작화면으로 버튼 클릭시 장면 닫고 타이틀화면으로 이동--
	function scene:closeScene()
		composer.removeScene("homeScene") --현재 장면 이름 넣기 ex)storyScene
		composer.gotoScene("scene1")
	end

	local loadOption =
	{
	    effect = "fade",
	    time = 400, 
	    params = {
	    	questNum = 6,
	    	questName = "설원 위 숨바꼭질", 
	    	maxJewerlyNum = 5,
	    	targetLevel = 252,
	    	areaName = "무덤가",
	    	backgroundImage = "image/background/tomb.png"
	    }
	}

	local function afterTimer()
		print("afterTimer runs!")
		composer:gotoScene("homeScene", loadOption)
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
		composer.removeScene("home")

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
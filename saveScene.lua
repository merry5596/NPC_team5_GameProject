-----------------------------------------------------------------------------------------
--
-- saveScene.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	

	local sceneGroup = self.view

	-- save slot position --
	local slotPosX = {370, 640, 910, 370, 640, 910, 370, 640, 910}
	local slotPosY = {250, 250, 250, 405, 405, 405, 560, 560, 560}
	
	-- 배경 --
	local background = display.newRect(display.contentWidth/2, display.contentHeight/2, display.contentWidth, display.contentHeight)
	background:setFillColor(1, 0.5) --반투명 배경으로 수정
	sceneGroup:insert(background)

	-- 세이브 창 --
	local saveBox = display.newImage("image/component/세이브창.png")
	saveBox.x, saveBox.y = display.contentWidth*0.5, display.contentHeight*0.5
	sceneGroup:insert(saveBox)

	--메뉴창 닫기버튼 그림--
	local menuCloseButton = display.newImage("image/component/menu_close.png")
	menuCloseButton.x, menuCloseButton.y = display.contentCenterX*1.56, display.contentCenterY*0.33
	sceneGroup:insert(menuCloseButton)

	--overlayOption: overlay 화면의 액션 이 씬에 전달 X
	local overlayOption =
	{
	    isModal = true
	}


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

	local loadsave = require( "loadsave" )
	local saveDatas = loadsave.loadTable("saveDatas.json")

	-- json 테이블에 저장될 세이브 리스트
	local saveList = {}
	if saveDatas == nil then
		saveList = {"", "", "", "", "", "", "", "", ""}
	else
		saveList = saveDatas.saveList
	end

	-- 화면에 슬롯 출력
	local slotList = {}
	for i = 1, #saveList do
		if saveList[i] ~= "" then
			saveSlot = display.newImage("image/component/저장된데이터.png")
			saveSlot.x, saveSlot.y = slotPosX[i], slotPosY[i]
			-- local saveDate = display.newText(saveList[i].date, slotPosX[i], slotPosY[i])
			local sceneTest = display.newText(saveList[i].scene, slotPosX[i], slotPosY[i])
			local slotGroup = display.newGroup()
			slotGroup:insert(saveSlot)
			-- slotGroup:insert(saveDate)
			slotGroup:insert(sceneTest)
			sceneGroup:insert(slotGroup)
			slotList[i] = slotGroup
		else
			-- 빈슬롯
			local emptySlot = display.newImage("image/component/빈슬롯데이터.png")
			emptySlot.x, emptySlot.y = slotPosX[i], slotPosY[i]
			sceneGroup:insert(emptySlot)
			slotList[i] = emptySlot
		end
	end

	-- save 이벤트 함수
	local function save(event)
    	print("save function!")
		-- 현재 씬 이름
		print(composer.getSceneName( "current" ))
		-- local gameSettings = {
		--     -- musicOn = true,
		--     -- soundOn = true,
		--     -- difficulty = "easy",
		--     -- highScore = 10000,
		--     -- highestLevel = 7
		-- }


		local saveContent = {
			-- 현재 씬 저장
			scene = composer.getSceneName( "current" ),
			-- 현재 시간 저장
			date = "2021-09-08 12:24"
		}

		local index = 0
		for i = 1, #slotList do
			if slotList[i] == event.target then
				index = i
				break
			end
		end

		saveList[index] = saveContent

		local saveDatas = {
			saveList = saveList
		}

		-- loadsave.saveTable( gameSettings, "settings.json" )
		loadsave.saveTable(saveDatas, "saveDatas.json")

		composer.showOverlay("saveCompleteScene", overlayOption)
	end

	-- 슬롯마다 이벤트 리스너
	-- 반복문으로 못하는 이유는...?
	for i = 1, #slotList do
		slotList[i]:addEventListener("tap", save)
	end
	-- slotList[1]:addEventListener("tap", save(1))
	-- slotList[2]:addEventListener("tap", save(2))
	-- slotList[3]:addEventListener("tap", save(3))
	-- slotList[4]:addEventListener("tap", save(4))
	-- slotList[5]:addEventListener("tap", save(5))
	-- slotList[6]:addEventListener("tap", save(6))
	-- slotList[7]:addEventListener("tap", save(7))
	-- slotList[8]:addEventListener("tap", save(8))
	-- slotList[9]:addEventListener("tap", save(9))

	--composer.gotoScene("view2")

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
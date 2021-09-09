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
	local loadBox = display.newImage("image/component/로드창.png")
	loadBox.x, loadBox.y = display.contentWidth*0.5, display.contentHeight*0.5
	sceneGroup:insert(loadBox)

	--메뉴창 닫기버튼 그림--
	local menuCloseButton = display.newImage("image/component/menu_close.png")
	menuCloseButton.x, menuCloseButton.y = display.contentCenterX*1.56, display.contentCenterY*0.33
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

	local loadsave = require( "loadsave" )
	local saveDatas = loadsave.loadTable("saveDatas.json")

	-- 세이브 리스트
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

	-- load 이벤트 함수
	local function load(event)
    	print("load function!")
		-- 현재 씬 이름
		print(composer.getSceneName( "current" ))
 
		local index = 0
		for i = 1, #slotList do
			if slotList[i] == event.target then
				index = i
				break
			end
		end

		-- 저장 위치(씬 이름) 출력
		print("저장 위치: ", saveList[index].scene)
		local targetScene = saveList[index].scene
		local currentScene = composer.getSceneName( "current" )
		composer.hideOverlay("loadScene")
		if targetScene == currentScene then
			print("target == current!")
		else
			composer:gotoScene(saveList[index].scene)
		end
	end

	-- 슬롯마다 이벤트 리스너
	for i = 1, #slotList do
		if saveList[i] ~= "" then
			slotList[i]:addEventListener("tap", load)
		end
		-- slotList[2]:addEventListener("tap", load)
		-- slotList[3]:addEventListener("tap", load)
		-- slotList[4]:addEventListener("tap", load)
		-- slotList[5]:addEventListener("tap", load)
		-- slotList[6]:addEventListener("tap", load)
		-- slotList[7]:addEventListener("tap", load)
		-- slotList[8]:addEventListener("tap", load)
		-- slotList[9]:addEventListener("tap", load)
	end

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
		print("loadScene open")
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
		print("loadScene hide")
	elseif phase == "did" then
		-- Called when the scene is now off screen
		-- composer.removeScene("home")

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
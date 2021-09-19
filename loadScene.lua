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
	local bounds_close = menuCloseButton.contentBounds
	local isOut_close
  	local function closeMenu(event)
  		if event.phase == "began" then
  			isOut_close = 0 	-- 이벤트 시작 시에는 이벤트가 버튼 안에 있음 (초기값)

  			display.getCurrentStage():setFocus( event.target )
    	    self.isFocus = true
    	    
    	    menuCloseButton:scale(0.9, 0.9) 	-- 버튼 작아짐
    	elseif self.isFocus then
    		if event.phase == "moved" then
    			-- 1. 이벤트가 버튼 밖에 있지만 isOut_close == 0인 경우(방금까지 안에 있었을 경우)에만 수행 (처음 밖으로 나갈 때 한 번 수행)
    			if (event.x < bounds_close.xMin or event.x > bounds_close.xMax or event.y < bounds_close.yMin or event.y > bounds_close.yMax) and isOut_close == 0 then
    				menuCloseButton:scale(1.1, 1.1)	-- 버튼 커짐
    				isOut_close = 1 	-- 이벤트가 버튼 밖에 있음을 상태로 저장

    			-- 2. 이벤트가 버튼 안에 있지만 isOut_close == 1인 경우(방금까지 밖에 있었을 경우)에만 수행 (처음 안으로 들어올 때 한 번 수행)
    			elseif (event.x >= bounds_close.xMin and event.x <= bounds_close.xMax and event.y >= bounds_close.yMin and event.y <= bounds_close.yMax) and isOut_close == 1 then
    				menuCloseButton:scale(0.9, 0.9) 	-- 버튼 작아짐
    				isOut_close = 0 	-- 이벤트가 버튼 안에 있음을 상태로 저장
    			end
	        elseif event.phase == "ended" or event.phase == "cancelled" then
	            display.getCurrentStage():setFocus( nil )
	            self.isFocus = false

	        	-- 버튼 안에서 손을 뗐을 시에만 메뉴 실행
  				if event.x >= bounds_close.xMin and event.x <= bounds_close.xMax and event.y >= bounds_close.yMin and event.y <= bounds_close.yMax then
		        	menuCloseButton:scale(1.1, 1.1)
		        	-- 여기부터가 실질적인 action에 해당
		        	if(composer.getVariable("sceneName") == home) then

					else
						dialogueBox:addEventListener("tap", nextScript)
					end
					composer.hideOverlay()
				end	
			end
	    end	
  	end
	menuCloseButton:addEventListener("touch", closeMenu)

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
			local saveDate = display.newText(saveList[i].date, slotPosX[i], slotPosY[i], "fonts/GowunBatang-Bold", 22)
			saveDate:setFillColor( 0.3, 0.2, 0.2 )
			local saveTime = display.newText(saveList[i].time, slotPosX[i], slotPosY[i] + 30, "fonts/GowunBatang-Bold", 22)
			saveTime:setFillColor( 0.3, 0.2, 0.2 )
			-- local sceneTest = display.newText(saveList[i].scene, slotPosX[i], slotPosY[i])
			local slotGroup = display.newGroup()
			slotGroup:insert(saveSlot)
			slotGroup:insert(saveDate)
			slotGroup:insert(saveTime)
			-- slotGroup:insert(sceneTest)
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
		if event.phase == "ended" or event.phase == "cancelled" then
	    	print("load function!")
			-- 현재 씬 이름
			print(composer.getSceneName( "current" ))
	 
   	    	audio.stopWithDelay(100, { channel = 10 })
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

			print("loadScene: 이동 위치: ", saveList[index].scriptNum)
			local loadOption =		-- loadOption
			{
			    effect = "fade",
			    time = 400,
			    params = {
			    	targetScene = targetScene, 
			        scriptNum = saveList[index].scriptNum
			    }
			}
			local userSettings = saveDatas.saveList[index].userSettings
			loadsave.saveTable(userSettings, "userSettings.json") 	-- 로드할때 그 때의 유저 세팅을 현재 유저 세팅으로 저장
			composer:gotoScene("movingEffectScene", loadOption)
		end
	end

	-- 슬롯마다 이벤트 리스너
	for i = 1, #slotList do
		if saveList[i] ~= "" then
			slotList[i]:addEventListener("touch", load)
		end
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
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

	--sound
	local buttonSound = audio.loadSound("sound/buttonSound.mp3")
	local savingSound = audio.loadSound( "sound/savingSound.mp3" )

	--overlayOption: overlay 화면의 액션 이 씬에 전달 X
	local overlayOption =
	{
	    isModal = true
	}


	--메뉴닫기--
	local bounds_close = menuCloseButton.contentBounds
	local isOut_close
  	local function closeMenu(event)
  		if event.phase == "began" then
  			isOut_close = 0 	-- 이벤트 시작 시에는 이벤트가 버튼 안에 있음 (초기값)

  			display.getCurrentStage():setFocus( event.target )
    	    self.isFocus = true
    	    
    	    menuCloseButton:scale(0.9, 0.9) 	-- 버튼 작아짐
    	    audio.play( buttonSound )
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

	-- save 이벤트 함수
  	local function save(event)
        if event.phase == "ended" or event.phase == "cancelled" then
        	audio.play( savingSound )

	    	print("save function!")
			-- 현재 씬 이름
			-- print(composer.getSceneName( "current" ))

			-- local gameSettings = {
			--     -- musicOn = true,
			--     -- soundOn = true,
			--     -- difficulty = "easy",
			--     -- highScore = 10000,
			--     -- highestLevel = 7
			-- }

			-- 날짜와 시간 저장
			local date = os.date( "*t" )    -- Returns table of date & time values in local time
			-- print( date.year, date.month )  -- Print year and month
			-- print( date.hour, date.min )    -- Print hour and minutes
			local savingDate = date.year .. "-" .. date.month .. "-" .. date.day
			local min = date.min
			-- 0~9분은 00~09분으로 표기
			if min / 10 < 1 then
				min = 0 .. min
			end
			local savingTime = date.hour .. ":" .. min

			-- 현재 대사 위치 저장
			local scriptNum = composer.getVariable("scriptNum")
			local userSettings = composer.getVariable("userSettings")
			print("saveScene: 현재 위치: ", scriptNum)

			local saveContent = {
				-- 현재 씬 저장
				scene = composer.getSceneName( "current" ),
				-- 현재 시간 저장
				date = savingDate,
				time = savingTime, 
				scriptNum = scriptNum,
				userSettings = userSettings
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

			-- 저장 완료시 텍스트 띄움
			local completeBox = display.newRect(display.contentCenterX, display.contentCenterY, 500, 100)
			completeBox:setFillColor(1)
			completeBox.alpha = 0.5
			local completeText = display.newText("저장 완료", display.contentCenterX, display.contentCenterY, "fonts/GowunBatang-Bold", 25)
			completeText:setFillColor(0.2)
			completeText.alpha = 1

			local completeGroup = display.newGroup()
			completeGroup:insert(completeBox)
			completeGroup:insert(completeText)

			-- 세이브창 안보이게(hide는 아님) 하며 저장 완료 텍스트 출력
			sceneGroup.alpha = 0
			transition.to(completeGroup, {time = 600, delay=600, alpha = 0})
			
			-- 아래의 타이머 완료 후 completeGroup을 sceneGroup에 넣고 hide
			local function afterTimer()
				print("afterTimer runs!")
				sceneGroup:insert(completeGroup)
				composer.hideOverlay()
			end

			-- 텍스트 출력동안 대기
			timer.performWithDelay( 1200, afterTimer)
	    end	
  	end
  	-- 슬롯마다 이벤트 리스너
	for i = 1, #slotList do
		slotList[i]:addEventListener("touch", save)
	end
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
		if composer.getSceneName("current") == "homeScene" then
			parent:resumeTimer() --이전 장면의 함수 실행
		end	
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
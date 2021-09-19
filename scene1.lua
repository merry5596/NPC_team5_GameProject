-----------------------------------------------------------------------------------------
--
-- scene1.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create(event)
	print("scene1 create")

	local sceneGroup = self.view

-------------------변수---------------------------------------------------------------------------------

	--배경 이미지 흰 바탕으로 대체
	local background = display.newRect(display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight)
	background:setFillColor(1)
	sceneGroup:insert(background)

	--타이틀 이미지 텍스트로 대체
	local Title = "이비의 모험 : 선생님을 찾아서"
	local showTitle = display.newText(Title, display.contentWidth/2, display.contentHeight/2-50) 
	showTitle:setFillColor(0) 
	showTitle.size = 80
	sceneGroup:insert(showTitle)

	-- 불러오기 버튼
	local load_button = display.newImageRect("image/component/menu_import.png", 350, 85)
	load_button.x, load_button.y = display.contentWidth/2, display.contentHeight/2+150
	sceneGroup:insert(load_button)

	-- 시작하기 버튼 불러오기 버튼으로 대체
	local start_button = display.newImageRect("image/component/menu_import.png", 350, 85)
	start_button.x, start_button.y = display.contentWidth/2, display.contentHeight/2+260
	sceneGroup:insert(start_button)		

	local resetButton = display.newImageRect("image/component/menu_import.png", 350, 85)
	resetButton.x, resetButton.y = display.contentWidth/2 + 150, display.contentHeight/2-150
	sceneGroup:insert(resetButton)

	 local overlayOption =
	{
	    isModal = true
	}

-------------------함수----------------------------------------------------------------------------------
	-- scene group 담기
	-- local function inSceneGroup()
	-- 	sceneGroup:insert(background)
	-- 	sceneGroup:insert(showTitle)
	-- 	sceneGroup:insert(load_button)
	-- 	sceneGroup:insert(start_button)		
	-- end

	--불러오기 버튼 클릭시 장면 전환
	local bounds_load = load_button.contentBounds
	local isOut_load
  	local function saveFileListOpen(event)
  		if event.phase == "began" then
  			isOut_load = 0 	-- 이벤트 시작 시에는 이벤트가 버튼 안에 있음 (초기값)

  			display.getCurrentStage():setFocus( event.target )
    	    self.isFocus = true
    	    
    	    load_button:scale(0.9, 0.9) 	-- 버튼 작아짐
    	elseif self.isFocus then
    		if event.phase == "moved" then
    			-- 1. 이벤트가 버튼 밖에 있지만 isOut_load == 0인 경우(방금까지 안에 있었을 경우)에만 수행 (처음 밖으로 나갈 때 한 번 수행)
    			if (event.x < bounds_load.xMin or event.x > bounds_load.xMax or event.y < bounds_load.yMin or event.y > bounds_load.yMax) and isOut_load == 0 then
    				load_button:scale(1.1, 1.1)	-- 버튼 커짐
    				isOut_load = 1 	-- 이벤트가 버튼 밖에 있음을 상태로 저장

    			-- 2. 이벤트가 버튼 안에 있지만 isOut_load == 1인 경우(방금까지 밖에 있었을 경우)에만 수행 (처음 안으로 들어올 때 한 번 수행)
    			elseif (event.x >= bounds_load.xMin and event.x <= bounds_load.xMax and event.y >= bounds_load.yMin and event.y <= bounds_load.yMax) and isOut_load == 1 then
    				load_button:scale(0.9, 0.9) 	-- 버튼 작아짐
    				isOut_load = 0 	-- 이벤트가 버튼 안에 있음을 상태로 저장
    			end
	        elseif event.phase == "ended" or event.phase == "cancelled" then
	            display.getCurrentStage():setFocus( nil )
	            self.isFocus = false

	        	-- 버튼 안에서 손을 뗐을 시에만 메뉴 실행
  				if event.x >= bounds_load.xMin and event.x <= bounds_load.xMax and event.y >= bounds_load.yMin and event.y <= bounds_load.yMax then
		        	load_button:scale(1.1, 1.1)
		        	-- 여기부터가 실질적인 action에 해당
		        	-- inSceneGroup()
					composer.showOverlay("loadScene", overlayOption)				
				end	
			end
	    end	
  	end
	load_button:addEventListener("touch", saveFileListOpen)

	--시작하기 버튼 클릭시 장면 전환
	local bounds_start = start_button.contentBounds
	local isOut_start
  	local function gameStart(event)
  		if event.phase == "began" then
  			isOut_start = 0 	-- 이벤트 시작 시에는 이벤트가 버튼 안에 있음 (초기값)

  			display.getCurrentStage():setFocus( event.target )
    	    self.isFocus = true
    	    
    	    start_button:scale(0.9, 0.9) 	-- 버튼 작아짐
    	elseif self.isFocus then
    		if event.phase == "moved" then
    			-- 1. 이벤트가 버튼 밖에 있지만 isOut_start == 0인 경우(방금까지 안에 있었을 경우)에만 수행 (처음 밖으로 나갈 때 한 번 수행)
    			if (event.x < bounds_start.xMin or event.x > bounds_start.xMax or event.y < bounds_start.yMin or event.y > bounds_start.yMax) and isOut_start == 0 then
    				start_button:scale(1.1, 1.1)	-- 버튼 커짐
    				isOut_start = 1 	-- 이벤트가 버튼 밖에 있음을 상태로 저장

    			-- 2. 이벤트가 버튼 안에 있지만 isOut_start == 1인 경우(방금까지 밖에 있었을 경우)에만 수행 (처음 안으로 들어올 때 한 번 수행)
    			elseif (event.x >= bounds_start.xMin and event.x <= bounds_start.xMax and event.y >= bounds_start.yMin and event.y <= bounds_start.yMax) and isOut_start == 1 then
    				start_button:scale(0.9, 0.9) 	-- 버튼 작아짐
    				isOut_start = 0 	-- 이벤트가 버튼 안에 있음을 상태로 저장
    			end
	        elseif event.phase == "ended" or event.phase == "cancelled" then
	            display.getCurrentStage():setFocus( nil )
	            self.isFocus = false

	        	-- 버튼 안에서 손을 뗐을 시에만 메뉴 실행
  				if event.x >= bounds_start.xMin and event.x <= bounds_start.xMax and event.y >= bounds_start.yMin and event.y <= bounds_start.yMax then
		        	start_button:scale(1.1, 1.1)
		        	-- 여기부터가 실질적인 action에 해당
		        	-- inSceneGroup()
					local loadsave = require( "loadsave" )
					local userSettings = loadsave.loadTable("userSettings.json")
		        	if userSettings then
		        		composer.gotoScene(userSettings.presentScene)
		        	else
						composer.gotoScene("storyScene_gameIntro")
					end
				end	
			end
	    end	
  	end
	start_button:addEventListener("touch", gameStart)

	-- 초기화 가능 (ui 없으면 테스트용으로 사용)
	function reset(event)
		print("reset")
		local json = require( "json" )
		local destDir = system.DocumentsDirectory
		local result1, reason1 = os.remove( system.pathForFile( "saveDatas.json", destDir ) )
  		local result2, reason2 = os.remove( system.pathForFile( "userSettings.json", destDir ) )

		if result1 or result2 then
		   print( "File removed" )
		elseif result2 then		-- 1 존재
		   print( "File does not exist", reason1 )  --> File does not exist    apple.txt: No such file or directory
		elseif result1 then 	-- 2 존재
			rint( "File does not exist", reason2 )  --> File does not exist    apple.txt: No such file or directory
		end
	end
	resetButton:addEventListener("touch", reset)

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
		print("scene1 closed")

	elseif phase == "did" then
		-- Called when the scene is now off screen
		composer.removeScene("scene1")
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






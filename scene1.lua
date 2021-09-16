-----------------------------------------------------------------------------------------
--
-- scene1.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create(event)

	local sceneGroup = self.view

-------------------변수---------------------------------------------------------------------------------

	--배경 이미지 흰 바탕으로 대체
	local background = display.newRect(display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight)
	background:setFillColor(1)

	--타이틀 이미지 텍스트로 대체
	local Title = "이비의 모험 : 선생님을 찾아서"
	local showTitle = display.newText(Title, display.contentWidth/2, display.contentHeight/2-50) 
	showTitle:setFillColor(0) 
	showTitle.size = 80

	-- 불러오기 버튼
	local load_button = display.newImageRect("image/component/menu_import.png", 350, 85)
	load_button.x, load_button.y = display.contentWidth/2, display.contentHeight/2+150

	-- 시작하기 버튼 불러오기 버튼으로 대체
	local start_button = display.newImageRect("image/component/menu_import.png", 350, 85)
	start_button.x, start_button.y = display.contentWidth/2, display.contentHeight/2+260

-------------------함수----------------------------------------------------------------------------------
	-- scene group 담기
	local function inSceneGroup()
		sceneGroup:insert(background)
		sceneGroup:insert(showTitle)
		sceneGroup:insert(load_button)
		sceneGroup:insert(start_button)		
	end

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
		        	inSceneGroup()
					composer.showOverlay("loadScene")				
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
		        	inSceneGroup()
					composer.gotoScene("storyScene_gameIntro")
				end	
			end
	    end	
  	end
	start_button:addEventListener("touch", gameStart)

end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene






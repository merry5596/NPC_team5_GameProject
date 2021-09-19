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
	sceneGroup:insert(background)

	--메뉴창 그림--
	local menuBox = display.newImage("image/component/menu_box.png")
	menuBox.x, menuBox.y = display.contentCenterX, display.contentCenterY
	sceneGroup:insert(menuBox)

	--메뉴창 닫기버튼 그림--
	local menuCloseButton = display.newImage("image/component/menu_close.png")
	menuCloseButton.x, menuCloseButton.y = display.contentCenterX*1.635, display.contentCenterY*0.55
	sceneGroup:insert(menuCloseButton)

	--메뉴창 시작화면으로 그림--
	local menuTitleScreen = display.newImage("image/component/menu_gotomain.png")
	menuTitleScreen.x, menuTitleScreen.y = display.contentCenterX, display.contentCenterY*0.65
	sceneGroup:insert(menuTitleScreen)

	--메뉴창 저장하기 그림--
	local menuSave = display.newImage("image/component/menu_save.png")
	menuSave.x, menuSave.y = display.contentCenterX, display.contentCenterY
	sceneGroup:insert(menuSave)

	--메뉴창 불러오기 그림--
	local menuLoad = display.newImage("image/component/menu_import.png")
	menuLoad.x, menuLoad.y = display.contentCenterX, display.contentCenterY*1.35
	sceneGroup:insert(menuLoad)

	--sound
	local buttonSound = audio.loadSound( "sound/buttonSound.mp3" )

	--overlayOption: overlay 화면의 액션 이 씬에 전달 X
	local overlayOption =
	{
	    isModal = true
	}
-------------------함수----------------------------------------------------------------------------
	
	--변수들 sceneGroup에 포함--
	-- local function inSceneGroup()
	-- 	sceneGroup:insert(background)
	-- 	sceneGroup:insert(menuBox)
	-- 	sceneGroup:insert(menuCloseButton)
	-- 	sceneGroup:insert(menuTitleScreen)
	-- 	sceneGroup:insert(menuSave)
	-- 	sceneGroup:insert(menuLoad)
	-- end

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
		        	-- inSceneGroup()
					-- dialogueBox:addEventListener("tap", nextScript)
					-- if(composer.getVariable("sceneName") == home) then
					-- else
					-- 	dialogueBox:addEventListener("tap", nextScript)
					-- end
					print(composer.getSceneName( "current" ))
					if composer.getSceneName("current") == "homeScene" then
						parent:resumeTimer() --이전 장면의 함수 실행
					end	
					composer.hideOverlay("menuScene")
				end	
			end
	    end	
  	end
	menuCloseButton:addEventListener("touch", closeMenu)

	--시작화면으로 버튼 클릭시 타이틀화면으로 이동--
	local loadOption =
	{
	    effect = "fade",
	    time = 400,
	}
	local bounds_title = menuTitleScreen.contentBounds
	local isOut_title
  	local function goTitleScreen(event)
  		if event.phase == "began" then
  			isOut_title = 0 	-- 이벤트 시작 시에는 이벤트가 버튼 안에 있음 (초기값)

  			display.getCurrentStage():setFocus( event.target )
    	    self.isFocus = true
    	    
    	    menuTitleScreen:scale(0.9, 0.9) 	-- 버튼 작아짐	
    	    audio.play( buttonSound )

    	elseif self.isFocus then
    		if event.phase == "moved" then
    			-- 1. 이벤트가 버튼 밖에 있지만 isOut_title == 0인 경우(방금까지 안에 있었을 경우)에만 수행 (처음 밖으로 나갈 때 한 번 수행)
    			if (event.x < bounds_title.xMin or event.x > bounds_title.xMax or event.y < bounds_title.yMin or event.y > bounds_title.yMax) and isOut_title == 0 then
    				menuTitleScreen:scale(1.1, 1.1)	-- 버튼 커짐
    				isOut_title = 1 	-- 이벤트가 버튼 밖에 있음을 상태로 저장

    			-- 2. 이벤트가 버튼 안에 있지만 isOut_title == 1인 경우(방금까지 밖에 있었을 경우)에만 수행 (처음 안으로 들어올 때 한 번 수행)
    			elseif (event.x >= bounds_title.xMin and event.x <= bounds_title.xMax and event.y >= bounds_title.yMin and event.y <= bounds_title.yMax) and isOut_title == 1 then
    				menuTitleScreen:scale(0.9, 0.9) 	-- 버튼 작아짐
    				isOut_title = 0 	-- 이벤트가 버튼 안에 있음을 상태로 저장
    			end
	        elseif event.phase == "ended" or event.phase == "cancelled" then
	            display.getCurrentStage():setFocus( nil )
	            self.isFocus = false

	        	-- 버튼 안에서 손을 뗐을 시에만 메뉴 실행
  				if event.x >= bounds_title.xMin and event.x <= bounds_title.xMax and event.y >= bounds_title.yMin and event.y <= bounds_title.yMax then
		        	menuTitleScreen:scale(1.1, 1.1)
		        	-- 여기부터가 실질적인 action에 해당
		        	-- inSceneGroup()
					-- composer.hideOverlay("menuScene")
					parent:closeScene() --이전 장면의 함수 실행	
					composer.gotoScene("scene1", loadOption)
				end	
			end
	    end	
  	end
  	menuTitleScreen:addEventListener("touch", goTitleScreen)

	--저장하기 버튼 클릭시 세이브화면으로 이동--
	local bounds_save = menuSave.contentBounds
	local isOut_save
  	local function saveSceneOpen(event)
  		if event.phase == "began" then
  			isOut_save = 0 	-- 이벤트 시작 시에는 이벤트가 버튼 안에 있음 (초기값)

  			display.getCurrentStage():setFocus( event.target )
    	    self.isFocus = true
    	    
    	    menuSave:scale(0.9, 0.9) 	-- 버튼 작아짐	
    	    audio.play( buttonSound )

    	elseif self.isFocus then
    		if event.phase == "moved" then
    			-- 1. 이벤트가 버튼 밖에 있지만 isOut_save == 0인 경우(방금까지 안에 있었을 경우)에만 수행 (처음 밖으로 나갈 때 한 번 수행)
    			if (event.x < bounds_save.xMin or event.x > bounds_save.xMax or event.y < bounds_save.yMin or event.y > bounds_save.yMax) and isOut_save == 0 then
    				menuSave:scale(1.1, 1.1)	-- 버튼 커짐
    				isOut_save = 1 	-- 이벤트가 버튼 밖에 있음을 상태로 저장

    			-- 2. 이벤트가 버튼 안에 있지만 isOut_save == 1인 경우(방금까지 밖에 있었을 경우)에만 수행 (처음 안으로 들어올 때 한 번 수행)
    			elseif (event.x >= bounds_save.xMin and event.x <= bounds_save.xMax and event.y >= bounds_save.yMin and event.y <= bounds_save.yMax) and isOut_save == 1 then
    				menuSave:scale(0.9, 0.9) 	-- 버튼 작아짐
    				isOut_save = 0 	-- 이벤트가 버튼 안에 있음을 상태로 저장
    			end
	        elseif event.phase == "ended" or event.phase == "cancelled" then
	            display.getCurrentStage():setFocus( nil )
	            self.isFocus = false

	        	-- 버튼 안에서 손을 뗐을 시에만 메뉴 실행
  				if event.x >= bounds_save.xMin and event.x <= bounds_save.xMax and event.y >= bounds_save.yMin and event.y <= bounds_save.yMax then
		        	menuSave:scale(1.1, 1.1)
		        	-- 여기부터가 실질적인 action에 해당
		        	-- inSceneGroup()
					-- local scriptNum = composer.getVariable("scriptNum")
					-- print("menuScene: 현재 위치: ", scriptNum)
					-- composer.setVariable("scriptNum", scriptNum)
					composer.showOverlay("saveScene", overlayOption)
				end	
			end
	    end	
  	end
	menuSave:addEventListener("touch", saveSceneOpen)

	--불러오기 버튼 클릭시 세이브파일목록화면으로 이동--
	local bounds_load = menuLoad.contentBounds
	local isOut_load
  	local function saveFileListOpen(event)
  		if event.phase == "began" then
  			isOut_load = 0 	-- 이벤트 시작 시에는 이벤트가 버튼 안에 있음 (초기값)

  			display.getCurrentStage():setFocus( event.target )
    	    self.isFocus = true
    	    
    	    menuLoad:scale(0.9, 0.9) 	-- 버튼 작아짐	
    	    audio.play( buttonSound )

    	elseif self.isFocus then
    		if event.phase == "moved" then
    			-- 1. 이벤트가 버튼 밖에 있지만 isOut_load == 0인 경우(방금까지 안에 있었을 경우)에만 수행 (처음 밖으로 나갈 때 한 번 수행)
    			if (event.x < bounds_load.xMin or event.x > bounds_load.xMax or event.y < bounds_load.yMin or event.y > bounds_load.yMax) and isOut_load == 0 then
    				menuLoad:scale(1.1, 1.1)	-- 버튼 커짐
    				isOut_load = 1 	-- 이벤트가 버튼 밖에 있음을 상태로 저장

    			-- 2. 이벤트가 버튼 안에 있지만 isOut_load == 1인 경우(방금까지 밖에 있었을 경우)에만 수행 (처음 안으로 들어올 때 한 번 수행)
    			elseif (event.x >= bounds_load.xMin and event.x <= bounds_load.xMax and event.y >= bounds_load.yMin and event.y <= bounds_load.yMax) and isOut_load == 1 then
    				menuLoad:scale(0.9, 0.9) 	-- 버튼 작아짐
    				isOut_load = 0 	-- 이벤트가 버튼 안에 있음을 상태로 저장
    			end
	        elseif event.phase == "ended" or event.phase == "cancelled" then
	            display.getCurrentStage():setFocus( nil )
	            self.isFocus = false

	        	-- 버튼 안에서 손을 뗐을 시에만 메뉴 실행
  				if event.x >= bounds_load.xMin and event.x <= bounds_load.xMax and event.y >= bounds_load.yMin and event.y <= bounds_load.yMax then
		        	menuLoad:scale(1.1, 1.1)
		        	-- 여기부터가 실질적인 action에 해당
		        	-- inSceneGroup()
					composer.showOverlay("loadScene", overlayOption)
				end	
			end
	    end	
  	end
	menuLoad:addEventListener("touch", saveFileListOpen)

end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	parent = event.parent --이전 장면

	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc
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
		print("menu closed")
		composer.removeScene("menuScene")
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
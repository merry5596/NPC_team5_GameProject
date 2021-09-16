-----------------------------------------------------------------------------------------
--
-- homeScene.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
	
	-- 배경 --
	-- local background = display.newRect(display.contentWidth/2, display.contentHeight/2, display.contentWidth, display.contentHeight)
	-- background:setFillColor(1)
	
	-- 임시 배경 --
	local background = display.newImageRect("image/background/forest임시배경.png", display.contentWidth, display.contentHeight)
	background.x, background.y = display.contentWidth*0.5, display.contentHeight*0.5
	sceneGroup:insert(background)

	local evy = display.newImage("image/component/evy.png")
	evy.x, evy.y = display.contentWidth*0.5, display.contentHeight*0.6

	sceneGroup:insert(evy)

	local menuButton = display.newImage("image/component/menu_button.png")
   	menuButton.x, menuButton.y = display.contentWidth*0.92, display.contentHeight*0.1
	sceneGroup:insert(menuButton)

	local level = display.newImage("image/component/level.png")
   	level.x, level.y = display.contentWidth*0.095, display.contentHeight*0.115
	sceneGroup:insert(level)

	local area = display.newImage("image/component/area.png")
	area.x, area.y = display.contentWidth*0.31, display.contentHeight*0.115
	sceneGroup:insert(area)

	local money = display.newImage("image/component/money.png")
	money.x, money.y = display.contentWidth*0.47, display.contentHeight*0.115
	sceneGroup:insert(money)

	local bag = display.newImage("image/component/bag.png")
	bag.x, bag.y = display.contentWidth*0.07, display.contentHeight*0.275
	sceneGroup:insert(bag)


	local inventoryBox = display.newImage("image/component/inventory_box.png")
	inventoryBox.x, inventoryBox.y = display.contentWidth*0.365, display.contentHeight*0.58
	inventoryBox.isVisible = false
	sceneGroup:insert(inventoryBox)

	local scrollbar = display.newImage("image/component/inventory_scroll.png")
	scrollbar.x, scrollbar.y = display.contentWidth*0.6736, display.contentHeight*0.35
	scrollbar.isVisible = false
	sceneGroup:insert(scrollbar)

	local function fitImage( displayObject, fitWidth, fitHeight, enlarge )
		--
		-- first determine which edge is out of bounds
		--
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

	-- 소지품 열기
	local bounds_bag = bag.contentBounds
	local isOut_bag
  	local function openBag(event)
  		if event.phase == "began" then
  			isOut_bag = 0 	-- 이벤트 시작 시에는 이벤트가 버튼 안에 있음 (초기값)

  			display.getCurrentStage():setFocus( event.target )
    	    self.isFocus = true
    	    
    	    bag:scale(0.9, 0.9) 	-- 버튼 작아짐
    	elseif self.isFocus then
    		if event.phase == "moved" then
    			-- 1. 이벤트가 버튼 밖에 있지만 isOut_bag == 0인 경우(방금까지 안에 있었을 경우)에만 수행 (처음 밖으로 나갈 때 한 번 수행)
    			if (event.x < bounds_bag.xMin or event.x > bounds_bag.xMax or event.y < bounds_bag.yMin or event.y > bounds_bag.yMax) and isOut_bag == 0 then
    				bag:scale(1.1, 1.1)	-- 버튼 커짐
    				isOut_bag = 1 	-- 이벤트가 버튼 밖에 있음을 상태로 저장

    			-- 2. 이벤트가 버튼 안에 있지만 isOut_bag == 1인 경우(방금까지 밖에 있었을 경우)에만 수행 (처음 안으로 들어올 때 한 번 수행)
    			elseif (event.x >= bounds_bag.xMin and event.x <= bounds_bag.xMax and event.y >= bounds_bag.yMin and event.y <= bounds_bag.yMax) and isOut_bag == 1 then
    				bag:scale(0.9, 0.9) 	-- 버튼 작아짐
    				isOut_bag = 0 	-- 이벤트가 버튼 안에 있음을 상태로 저장
    			end
	        elseif event.phase == "ended" or event.phase == "cancelled" then
	            display.getCurrentStage():setFocus( nil )
	            self.isFocus = false

	        	-- 버튼 안에서 손을 뗐을 시에만 메뉴 실행
  				if event.x >= bounds_bag.xMin and event.x <= bounds_bag.xMax and event.y >= bounds_bag.yMin and event.y <= bounds_bag.yMax then
		        	bag:scale(1.1, 1.1)
		        	-- 여기부터가 실질적인 action에 해당
		        	inventoryBox.isVisible = true
					scrollbar.isVisible = true
					closeButton.isVisible = true
				end	
			end
	    end	
  	end
	bag:addEventListener("touch", openBag)

	-- 소지품 닫기
	local bounds_close = closeButton.contentBounds
	local isOut_close
  	local function closeBag(event)
  		if event.phase == "began" then
  			isOut_close = 0 	-- 이벤트 시작 시에는 이벤트가 버튼 안에 있음 (초기값)

  			display.getCurrentStage():setFocus( event.target )
    	    self.isFocus = true
    	    
    	    closeButton:scale(0.9, 0.9) 	-- 버튼 작아짐
    	elseif self.isFocus then
    		if event.phase == "moved" then
    			-- 1. 이벤트가 버튼 밖에 있지만 isOut_close == 0인 경우(방금까지 안에 있었을 경우)에만 수행 (처음 밖으로 나갈 때 한 번 수행)
    			if (event.x < bounds_close.xMin or event.x > bounds_close.xMax or event.y < bounds_close.yMin or event.y > bounds_close.yMax) and isOut_close == 0 then
    				closeButton:scale(1.1, 1.1)	-- 버튼 커짐
    				isOut_close = 1 	-- 이벤트가 버튼 밖에 있음을 상태로 저장

    			-- 2. 이벤트가 버튼 안에 있지만 isOut_close == 1인 경우(방금까지 밖에 있었을 경우)에만 수행 (처음 안으로 들어올 때 한 번 수행)
    			elseif (event.x >= bounds_close.xMin and event.x <= bounds_close.xMax and event.y >= bounds_close.yMin and event.y <= bounds_close.yMax) and isOut_close == 1 then
    				closeButton:scale(0.9, 0.9) 	-- 버튼 작아짐
    				isOut_close = 0 	-- 이벤트가 버튼 안에 있음을 상태로 저장
    			end
	        elseif event.phase == "ended" or event.phase == "cancelled" then
	            display.getCurrentStage():setFocus( nil )
	            self.isFocus = false

	        	-- 버튼 안에서 손을 뗐을 시에만 메뉴 실행
  				if event.x >= bounds_close.xMin and event.x <= bounds_close.xMax and event.y >= bounds_close.yMin and event.y <= bounds_close.yMax then
		        	closeButton:scale(1.1, 1.1)
		        	-- 여기부터가 실질적인 action에 해당
		        	inventoryBox.isVisible = false
					scrollbar.isVisible = false
					closeButton.isVisible = false
				end	
			end
	    end	
  	end
	closeButton:addEventListener("touch", closeBag)

	local overlayOption =
	{
	    isModal = true
	}

	--메뉴열기--	
	local bounds = menuButton.contentBounds
	local isOut
  	local function openMenu(event)
  		if event.phase == "began" then
  			isOut = 0 	-- 이벤트 시작 시에는 이벤트가 버튼 안에 있음 (초기값)

  			display.getCurrentStage():setFocus( event.target )
    	    self.isFocus = true
    	    
    	    menuButton:scale(0.9, 0.9) 	-- 버튼 작아짐
    	elseif self.isFocus then
    		if event.phase == "moved" then
    			-- 1. 이벤트가 버튼 밖에 있지만 isOut == 0인 경우(방금까지 안에 있었을 경우)에만 수행 (처음 밖으로 나갈 때 한 번 수행)
    			if (event.x < bounds.xMin or event.x > bounds.xMax or event.y < bounds.yMin or event.y > bounds.yMax) and isOut == 0 then
    				menuButton:scale(1.1, 1.1)	-- 버튼 커짐
    				isOut = 1 	-- 이벤트가 버튼 밖에 있음을 상태로 저장

    			-- 2. 이벤트가 버튼 안에 있지만 isOut == 1인 경우(방금까지 밖에 있었을 경우)에만 수행 (처음 안으로 들어올 때 한 번 수행)
    			elseif (event.x >= bounds.xMin and event.x <= bounds.xMax and event.y >= bounds.yMin and event.y <= bounds.yMax) and isOut == 1 then
    				menuButton:scale(0.9, 0.9) 	-- 버튼 작아짐
    				isOut = 0 	-- 이벤트가 버튼 안에 있음을 상태로 저장
    			end
	        elseif event.phase == "ended" or event.phase == "cancelled" then
	            display.getCurrentStage():setFocus( nil )
	            self.isFocus = false

	        	-- 버튼 안에서 손을 뗐을 시에만 메뉴 실행
  				if event.x >= bounds.xMin and event.x <= bounds.xMax and event.y >= bounds.yMin and event.y <= bounds.yMax then
		        	menuButton:scale(1.1, 1.1)
		        	-- 여기부터가 실질적인 action에 해당
		  			composer.setVariable("scriptNum", 0)
  					composer.showOverlay("menuScene", overlayOption)
				end	
			end
	    end	
  	end
  	menuButton:addEventListener("touch", openMenu)

  	--메뉴 시작화면으로 버튼 클릭시 장면 닫고 타이틀화면으로 이동--
	function scene:closeScene()
		composer.removeScene("homeScene") --현재 장면 이름 넣기 ex)storyScene
		composer.gotoScene("scene1")
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

-----------------------------------------------------------------------------------------

return scene
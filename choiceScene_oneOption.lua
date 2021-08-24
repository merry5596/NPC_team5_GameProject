-----------------------------------------------------------------------------------------
--
-- view2.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
	
	-- Called when the scene's view does not exist.
	-- 
	-- INSERT code here to initialize the scene
	-- e.g. add display objects to 'sceneGroup', add touch listeners, etc.
	
	-- create a white background to fill screen

	--반투명 배경 그림--
	-- local background = display.newRect(display.contentCenterX, display.contentCenterY, 
	-- 	display.contentWidth, display.contentHeight)
	-- background:setFillColor(1, 0.5)
	
	-- 혜연 수정: 이전 scene에서 setVariable로 저장한 선택지 배열을 받아옴 --
	local options = composer.getVariable("options")
	

	--선택지 그림--
	local choiceBox = display.newImage("image/component/story_option.png")
	choiceBox.x, choiceBox.y = display.contentCenterX, display.contentCenterY*0.71
	sceneGroup:insert(choiceBox)

	local optionText = display.newText(options[1], display.contentCenterX, display.contentCenterY*0.71, native.systemFont, 24)
	sceneGroup:insert(optionText)

	-- if i == 2 then
	-- 	choiceBox[i].y = display.contentCenterY
	-- 	optionText[i].y = display.contentCenterY
	-- end

	-- 혜연 수정 --
	-- 1번 선택지 선택 시 --
	local function selectOption1(event)
		print("tap1")
		composer.hideOverlay() -- 이때 scene:hide( event ) 호출
	end

	-- 혜연 수정 --
	-- 선택지 선택 이벤트리스너 --
	choiceBox:addEventListener("tap", selectOption1)

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

	-- 혜연 수정 --
	local parent = event.parent -- 이전 scene을 뜻함
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
		
		-- 혜연 수정 --
		parent:resumeGame() -- 이전 scene에 function scene:resumeGame()이라는 함수를 만들어 돌아갔을 때의 액션을 정의

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

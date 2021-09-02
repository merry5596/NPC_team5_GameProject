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
	local background = display.newRect(display.contentCenterX, display.contentCenterY, 
	display.contentWidth, display.contentHeight)
	background:setFillColor(0, 0.5)
	sceneGroup:insert(background)
	
	-- 혜연 수정: 이전 scene에서 setVariable로 저장한 선택지 배열을 받아옴 --
	local options = composer.getVariable("options")
	local optionText = {}

	-- 혜연 수정: 선택지 그룹 --
	local selectGroup = display.newGroup()

	--선택지 그림--
	local choiceBox = { }
	for i = 1, #options do
		choiceBox[i] = display.newImage(selectGroup,"image/component/story_option.png")
		choiceBox[i].x, choiceBox[i].y = display.contentCenterX, display.contentCenterY * 0.71
		if i == 2 then
			choiceBox[1].y = display.contentCenterY * 0.6
			choiceBox[i].y = display.contentCenterY
		end
		if i == 3 then
			choiceBox[1].y = display.contentCenterY * 0.3
			choiceBox[2].y = display.contentCenterY * 0.7
			choiceBox[3].y = display.contentCenterY * 1.1
		end
	end

	--선택지에 option 내용 삽입--
	for i = 1, #options do
		optionText[i] = display.newText(options[i], choiceBox[i].x, choiceBox[i].y, "fonts/GowunBatang-Bold.ttf", 21)
		selectGroup:insert(optionText[i])
	end

	sceneGroup:insert(selectGroup)


	-- 혜연 수정 --
	-- 1번 선택지 선택 시 --
	local function selectOption1(event)
		print("tap1")
		composer.setVariable("selectedOption", 1) -- selectedOption에 1 저장
		composer.hideOverlay() -- 이때 scene:hide( event ) 호출
	end

	-- 2번 선택지 선택 시 --
	local function selectOption2(event)
		print("tap2")
		composer.setVariable("selectedOption", 2) -- selectedOption에 2 저장
		composer.hideOverlay() -- 이때 scene:hide( event ) 호출
	end

	-- 3번 선택지 선택 시 --
	local function selectOption3(event)
		print("tap3")
		composer.setVariable("selectedOption", 3) -- selectedOption에 2 저장
		composer.hideOverlay() -- 이때 scene:hide( event ) 호출
	end

	-- 혜연 수정 --
	-- 선택지 선택 이벤트리스너 --
	choiceBox[1]:addEventListener("tap", selectOption1)
	if #choiceBox >= 2 then
		choiceBox[2]:addEventListener("tap", selectOption2)
	end
	if #choiceBox == 3 then
		choiceBox[3]:addEventListener("tap", selectOption3)
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
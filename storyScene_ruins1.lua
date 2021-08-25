-----------------------------------------------------------------------------------------
--
-- 스토리 폐허 파트 상.lua
--
-----------------------------------------------------------------------------------------

local composer = require("composer")
local scene = composer.newScene()

function scene:create(event)
	local sceneGroup = self.view
	
-------------------변수-------------------------------------------------------------------------------

	--배경 그림--
	local background = display.newImage("image/background/ruins_nature.jpg", display.contentWidth, display.contentHeight)
	background.x, background.y = display.contentCenterX, display.contentCenterY

	--플레이어 그림--
	local player = display.newImage("image/component/evy.png")
	player.x, player.y = display.contentCenterX, display.contentCenterY*1.3
	player.isVisible = false

	--대사창 그림--
	dialogueBox = display.newImage("image/component/story_box.png")
	dialogueBox.x, dialogueBox.y = display.contentCenterX, display.contentCenterY*1.6

	--대사창 위 이름칸 그림--
	local nameBox = display.newImage("image/component/story_name.png")
	nameBox.x, nameBox.y = display.contentCenterX*0.35, display.contentCenterY*1.333

	--대사창 위 스킵버튼 그림--
	local skipButton = display.newImage("image/component/story_skip.png")
	skipButton.x, skipButton.y = display.contentCenterX*1.75, display.contentCenterY*1.33

	--대사창 위 빨리가기 버튼 그림--
	local fastforwardButton = display.newImage("image/component/story_fast.png")
	fastforwardButton.x, fastforwardButton.y = display.contentCenterX*1.63, display.contentCenterY*1.33

	--대사창 그룹--
	local dialogueBoxGroup = display.newGroup()
	dialogueBoxGroup:insert(dialogueBox)
	dialogueBoxGroup:insert(nameBox)
	dialogueBoxGroup:insert(skipButton)
	dialogueBoxGroup:insert(fastforwardButton)

	--메뉴버튼 그림--
	local menuButton = display.newImage("image/component/menu_button.png")
  	menuButton.x, menuButton.y = display.contentWidth*0.92, display.contentHeight*0.1

-------------------텍스트---------------------------------------------------------------------------------

  	--내래이션과 대사--
  	local dialogue = {" ", "얼마나 오래 걸었을까요? 숲을 가득 채우던 나무가 하나씩 시야에서 사라지고 있어요.",
  				"은근한 흙먼지 향내가 코끝에 감돌고, 지내온 숲과는 다른 풍경이 당신 앞에 펼쳐집니다.",
  				"어째 점점 황량한 배경이 이어지는 것 같아요.",
  				"숲과 멀어지면... 건물의 잔해와 이끼가 뒤엉켜 바스라진 광경이 눈에 들어옵니다.",
  				"이게 바로 시멘트라는 걸까요?\n건물의 벽을 이루고 있었던 시멘트덩이 사이를 잡초가 비집고 들어간 것 같네요.",
  				"우뚝 솟은 잡초들이 시들시들해 보여요.",
  				"숲 밖은 모두 이렇게 생명의 흔적이 사라지고 있는 걸까요.",
  				"... 아무도 없는 건가? 주위를 둘러봐도 사람이 없네.",
  				"생각해보면, 선생님께서는 다른 사람들에 대한 이야기를 당신께 일절 하지 않았습니다.	",
  				"목소리를 높여 사람들을 불러봐도 메아리만 칠 뿐, 아무도 당신 곁에 다가오질 않아요.",
  				"사람이 없다는 것이 더 정확한 표현이겠죠.",
  				"이상합니다. 더 살펴보는 게 좋겠어요."}

	--대사 구성--
	local showDialogue = {}
	local showDialogueGroup = display.newGroup()
	for i = 1, #dialogue do
		showDialogue[i] = display.newText(showDialogueGroup, dialogue[i], dialogueBox.x, dialogueBox.y, 1000, 0, "fonts/GowunBatang-Bold.ttf", 26)
		showDialogue[i]:setFillColor(1)
		showDialogue[i].alpha = 0
	end

	--이름창 글자--
	local name = "이비"
	local showName = display.newText(name, nameBox.x, nameBox.y*0.993, native.systemFontBold, 35)

	--이름창+이름글자 그룹--
	local nameGroup = display.newGroup()
	nameGroup:insert(nameBox)
	nameGroup:insert(showName)
	nameGroup.isVisible = false

-------------------함수----------------------------------------------------------------------------------
	
	--클릭으로 대사 전환--
	i = 1
	function nextScript(event)
		showDialogue[i].alpha = 0
		if(i < #dialogue) then
			i = i + 1
		end
		showDialogue[i].alpha = 1
		if(i == 9) then
			nameGroup.isVisible = true
			player.isVisible = true
		elseif(i == 10) then
			nameGroup.isVisible = false
			player.isVisible = false
		end
	end
	dialogueBox:addEventListener("tap", nextScript)

  	--메뉴열기--
  	local function menuOpen(event)
  		if(event.phase == "began") then
  			dialogueBox:removeEventListener("tap", nextScript)
  			composer.showOverlay("menuScene")
  		end
  	end
  	menuButton:addEventListener("touch", menuOpen)

  	--메뉴 시작화면으로 버튼 클릭시 장면 닫고 타이틀화면으로 이동--
	function scene:closeScene()
		sceneGroup:insert(background)
		sceneGroup:insert(player)
		sceneGroup:insert(dialogueBoxGroup)
		sceneGroup:insert(menuButton)
		sceneGroup:insert(showDialogueGroup)
		sceneGroup:insert(nameGroup)
		composer.removeScene("storyScene_ruins1")
		composer.gotoScene("scene1")
	end

	-- composer.loadScene("choiceScene")
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
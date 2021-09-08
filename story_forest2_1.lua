-----------------------------------------------------------------------------------------
--
-- 숲2 파트 상.lua
--
-----------------------------------------------------------------------------------------

local composer = require("composer")
local scene = composer.newScene()

function scene:create(event)
	local sceneGroup = self.view

-------------------변수-------------------------------------------------------------------------------
	
	--배경 그림--
	local background = display.newImage("image/background/forest(겨울).png", display.contentWidth, display.contentHeight)
	background.x, background.y = display.contentCenterX, display.contentCenterY
	sceneGroup:insert(background)

	--플레이어 그림--
	local player = display.newImage("image/component/evy.png")
	player.x, player.y = display.contentCenterX, display.contentCenterY*1.5
	player:scale(1.2, 1.2)
	player.isVisible = false
	sceneGroup:insert(player)

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
	sceneGroup:insert(dialogueBoxGroup)

	--메뉴버튼 그림--
	local menuButton = display.newImage("image/component/menu_button.png")
  	menuButton.x, menuButton.y = display.contentWidth*0.92, display.contentHeight*0.1
	sceneGroup:insert(menuButton)

-------------------텍스트---------------------------------------------------------------------------------

	--내래이션과 대사--
  	local dialogue = {" ", "숲으로 돌아오니 아니나 다를까, 소복소복 눈이 쌓여있습니다.",
  					"완연한 겨울이 당신을 맞이합니다.",
  					"당연한 일이죠. 이상기후의 발생은 늘 있던 일이니까요.",
  					"찬 겨울 바람을 그대로 맞으며 오두막으로 걸어갑니다.",
  					"큰 마음을 먹고 숲 밖으로 나가봤건만, 선생님의 흔적은 무슨! 그 발자취의 실마리조차 찾지 못했습니다.",
  					"그래도 이쯤이면 선생님께서 돌아온 후일 것 같지 않나요?",
  					"오래 찾아다니게 만들었으니, 만나면 여러 핀잔을 내뱉어봅시다. 선생님은 웃으며 늘 당신을 받아줬으니까요.",
  					"눈밭에 발자국을 남기며 걸어갈까요."}

  	--대사 구성--
	local showDialogue = {}
	local showDialogueGroup = display.newGroup()
	for i = 1, #dialogue do
		showDialogue[i] = display.newText(showDialogueGroup, dialogue[i], dialogueBox.x, dialogueBox.y, 1000, 0, "fonts/GowunBatang-Bold.ttf", 27)
		showDialogue[i]:setFillColor(1)
		showDialogue[i].alpha = 0
	end
	sceneGroup:insert(showDialogueGroup)

	--이름창 글자--
	local name = "이비"
	local showName = display.newText(name, nameBox.x, nameBox.y*0.993, "fonts/GowunBatang-Bold.ttf", 30)

	--이름창+이름글자 그룹--
	local nameGroup = display.newGroup()
	nameGroup:insert(nameBox)
	nameGroup:insert(showName)
	nameGroup.isVisible = false
	sceneGroup:insert(nameGroup)

-------------------함수----------------------------------------------------------------------------------

	--클릭으로 대사 전환--
	local fastforward_state = 0 --빨리감기상태 0꺼짐 1켜짐

	local playerTime = 400 --플레이어와 이름창 페이드인 시간
	local dialogueFadeInTime = 400 --대사 페이드인과 배경 전환 시간
	local dialogueFadeOutTime = 200 --대사와 이름창 페이드아웃 시간
	i = 1
	function nextScript(event)
		if(fastforward_state == 0) then
			showDialogue[i].alpha = 0
			if(i < #dialogue) then
				i = i + 1
			end
			showDialogue[i].alpha = 1

			playerTime = 200
		else
			transition.fadeOut(showDialogue[i], { time = dialogueFadeOutTime })
			if(i < #dialogue) then
				i = i + 1
			end
			transition.fadeIn(showDialogue[i], { time = dialogueFadeInTime })
		end
	end
	dialogueBox:addEventListener("tap", nextScript)

	--빨리감기기능--
	local function scriptFastForward()
		print("i: ", i)
		nextScript()
	end

	function fastforward(event)
		if(fastforward_state == 0) then
			fastforward_state = 1
			dialogueBox:removeEventListener("tap", nextScript)
			skipButton:removeEventListener("tap", skip)
			timer1 = timer.performWithDelay(1000, scriptFastForward, 0, "sFF")
		else
			fastforward_state = 0
			dialogueBox:addEventListener("tap", nextScript)
			skipButton:addEventListener("tap", skip)
			timer.pause("sFF")
	
			return true
		end
	end
	fastforwardButton:addEventListener("tap", fastforward)

	--빨리감기종료함수--
	function stopFastForward()
		fastforward_state = 0
		dialogueBox:addEventListener("tap", nextScript)
		skipButton:addEventListener("tap", skip)
		timer.pause(timer1)
	end

	--스킵기능--
	function skip(event)
		showDialogue[i].alpha = 0
		i = #dialogue
		showDialogue[i].alpha = 1
		
		print("i: ", i)
	end
	skipButton:addEventListener("tap", skip)

  	--메뉴열기--
  	local function menuOpen(event)
  		if(event.phase == "began") then
  			if fastforward_state == 1 then --메뉴오픈시 빨리감기종료
				stopFastForward()
			end
  			dialogueBox:removeEventListener("tap", nextScript)
  			composer.showOverlay("menuScene")
  		end
  	end
  	menuButton:addEventListener("touch", menuOpen)

  	--메뉴 시작화면으로 버튼 클릭시 장면 닫고 타이틀화면으로 이동--
	function scene:closeScene()
		composer.removeScene("story_forest2_1") --현재 장면 이름 넣기 ex)storyScene
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
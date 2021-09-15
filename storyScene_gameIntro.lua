-----------------------------------------------------------------------------------------
--
-- 스토리 Game Intro.lua
--
---------------------------------s--------------------------------------------------------

local composer = require("composer")
local scene = composer.newScene()

function scene:create(event)
	local sceneGroup = self.view
	
-------------------변수---------------------------------------------------------------------------------

	--배경 그림--
	local background1 = display.newImage("image/background/inside_cabin_임시.jpg", display.contentWidth, display.contentHeight)
	background1.x, background1.y = display.contentCenterX, display.contentCenterY
	local background2 = display.newImage("image/background/outside_cabin_임시.jpg", display.contentWidth, display.contentHeight)
	background2.x, background2.y = display.contentCenterX, display.contentCenterY
	background2.alpha = 0
	sceneGroup:insert(background1)
	sceneGroup:insert(background2)

	--플레이어 그림--
	local player = display.newImage("image/component/evy.png")
	player.x, player.y = display.contentCenterX, display.contentCenterY*1.5
	player:scale(1.2, 1.2)
	player.alpha = 0
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

-------------------텍스트--------------------------------------------------------------------------------

  	--내래이션과 대사--
  	local dialogue = {" ", "깊은 숲 어딘가의 작은 오두막.",
  				"어린아이와 그를 돌보는 선생님만이 머무는 곳.", --3
  				"늘상 평온할 줄 알았으나, 오늘은 어째 무슨 일이 있나봅니다.",
  				"선생님? 어디에 계세요?",
  				"계속해서 찾아다녀도 보이질 않는 선생님.", --6
  				"오두막부터 시작해서 앞마당까지 돌아다녔건만.......",
  				"선생님의 흔적조차 찾을 수 없습니다.",
  				"숲 밖으로 잠시 떠나셨나?", --9
  				"말도 않고 외출하실 분이 아닌데... 그래도 기다려보자.",
  				"시간은 흐르고 흘러 다음날이 되었고",
  				"당신의 선생님은 아직도 돌아오시지 않았어요.", --12
  				"어딘가 이상하지 않나요?",
  				"선생님이 당신을 두고 사라지셨을 리가 없습니다.",
  				"그야, 당신을 애지중지하며 키운 이가 바로 선생님이니까요.",
  				"분명 선생님께서 숲 밖은 위험하니 그 내부에서만 돌아다니라고 말씀하셨죠?",
  				"그러니까 선생님을 찾으러 숲 내부를 돌아다니는 것도 괜찮을 것 같아요.	",
  				"그럼... 가볼까요?" --18
  			}

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
	local showName = display.newText(name, nameBox.x, nameBox.y, "fonts/GowunBatang-Bold.ttf", 30)

	--이름창+이름글자 그룹--
	local nameGroup = display.newGroup()
	nameGroup:insert(nameBox)
	nameGroup:insert(showName)
	nameGroup.alpha = 0
	sceneGroup:insert(nameGroup)

-------------------함수-------------------------------------------------------------------------------

	--클릭으로 대사 전환--
	local fastforward_state = 0 --빨리감기상태 0꺼짐 1켜짐

	local playerTime = 400 --플레이어와 이름창 페이드인 시간
	local dialogueFadeInTime = 400 --대사 페이드인과 배경 전환 시간
	local dialogueFadeOutTime = 200 --대사와 이름창 페이드아웃 시간
	i = 1

	-- 대사 상태가 변경되었을 때 캐릭터와 배경 상태 setting
	function changeCharAndBack()
		if(i == 5) then
			transition.fadeIn(nameGroup, { time = playerTime })
			transition.fadeIn(player, { time = playerTime })
			transition.dissolve(background1, background2, dialogueFadeInTime) --배경전환
		elseif(i == 9 or i == 10) then
			transition.fadeIn(nameGroup, { time = playerTime })
			transition.fadeIn(player, { time = playerTime })
		elseif(i == 6 or i == 11) then
			transition.fadeOut(nameGroup, { time = dialogueFadeOutTime })
		end
	end
	
	-- 저장 load시 캐릭터와 배경 상태 setting
	function setCharAndBack()
		changeCharAndBack()
		if i > 5 then	-- i > 5이면 배경이 background2, 이비 alpha=1
			transition.dissolve(background1, background2, dialogueFadeInTime) --배경전환
			player.alpha = 1
		end
	end

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

		changeCharAndBack()
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
		if(player.alpha == 0) then
			transition.fadeIn(player, { time = playerTime })
		end
		if(nameGroup.alpha == 1) then
			transition.fadeOut(nameGroup, { time = dialogueFadeOutTime })
		end
		if(i < 5) then
			transition.dissolve( background1, background2, dialogueFadeInTime)
		end

		transition.fadeOut(showDialogue[i], { time = dialogueFadeOutTime })
		i = #dialogue
		transition.fadeIn(showDialogue[i], { time = dialogueFadeInTime })
		
		print("i: ", i)

		return true
	end
	skipButton:addEventListener("tap", skip)

	local overlayOption =
	{
	    isModal = true
	}

  	--메뉴열기--
  	local function menuOpen(event)
  		if(event.phase == "began") then
  			if fastforward_state == 1 then --메뉴오픈시 빨리감기종료
				stopFastForward()
			end
			-- dialogueBox:removeEventListener("tap", nextScript)
			-- 현재 대사 위치 파라미터로 저장
			composer.setVariable("scriptNum", i)
  			composer.showOverlay("menuScene")
  		end
  	end
  	menuButton:addEventListener("touch", menuOpen)

	--메뉴 시작화면으로 버튼 클릭시 장면 닫고 타이틀화면으로 이동--
	function scene:closeScene()
		composer.removeScene("storyScene_gameIntro")
		composer.gotoScene("scene1")
	end

	-- scriptNum를 params으로 받은 경우: 저장을 load한 경우이므로 특정 대사로 이동
    if event.params then
    	if event.params.scriptNum then
			i = event.params.scriptNum
			showDialogue[1].alpha = 0
			showDialogue[i].alpha = 1
			setCharAndBack()
		end
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
		composer.removeScene("storyScene_gameIntro")
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
-----------------------------------------------------------------------------------------
--
-- 숲 1파트 상.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	print("story_forest1_1: create")

	-- 임시 배경 --
	local background = display.newImageRect("image/background/forest임시배경.png", display.contentWidth, display.contentHeight)
	background.x, background.y = display.contentWidth*0.5, display.contentHeight*0.5
	sceneGroup:insert(background)

	--플레이어 그림--
	local player = display.newImage("image/component/evy.png")
	player.x, player.y = display.contentCenterX, display.contentCenterY*1.5
	player:scale(1.2, 1.2)
	player.alpha = 0
	sceneGroup:insert(player)

	--대사창 그림--
	dialogueBox = display.newImage("image/component/story_box.png") --local 빼기 수정
	dialogueBox.x, dialogueBox.y = display.contentCenterX, display.contentCenterY*1.6

	--대사창 위 이름칸 그림--
	local nameBox = display.newImage("image/component/story_name.png")
	nameBox.x, nameBox.y = display.contentCenterX*0.35, display.contentCenterY*1.333

	--대사창 위 이름--
	local name = display.newText("이비", display.contentCenterX*0.35, display.contentCenterY*1.333, "fonts/GowunBatang-Bold.ttf", 30)

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

	--이름 그룹--
	local nameGroup = display.newGroup()
	nameGroup:insert(nameBox)
	nameGroup:insert(name)
	nameGroup.alpha = 0
	sceneGroup:insert(nameGroup)

	--메뉴버튼 그림--
	local menuButton = display.newImage("image/component/menu_button.png")
  	menuButton.x, menuButton.y = display.contentWidth*0.92, display.contentHeight*0.1
  	sceneGroup:insert(menuButton)
  
  	--overlayOption: overlay 화면의 액션 이 씬에 전달 X
	local overlayOption =
	{
	    isModal = true
	}


  	local scripts = {
        "나무 그늘 아래를 둘러보고, 개울 위까지 살펴보러 떠나봅시다.",					
        "선생님은 대체 어디에 계신 걸까요? 살랑살랑 흩날리던 선생님의 머리칼이 그리워져요!",				
        "늘상 평온한 날이 이어질 것이라 생각했으나, 오늘은 무슨 일이 생기려는 걸까요.",				
        "푹신한 이끼를 밟으며 걸어가면 분명 언젠가 선생님을 찾을 수 있겠지.......",			
        "당신은 걷고, 또 걷습니다. 검은 나뭇잎이 하늘을 가릴 쯤에 무릎에서 끽끽 소리가 흘러나와요.",			
        "묘하게 삐그덕거리는 게, 아무래도 무리해서 돌아다닌 것 같아요.",
        "조금 쉬어보는 게 어때요?", --7 선택지
        "차가운 공기가 비강을 비집고 들어옵니다.", --8 선택지 답1
        "신선한 공기인 것을 단번에 알아차립니다.",
        "숲 밖의 지역도 이렇게 상쾌한 공기가 가득할까요?",
        "목이 말랐는데, 다행히 개울이 있네요.", --11 선택지 답2
        "선생님께 배웠던 물 정화 마법으로 갈증을 해소합니다.",
        "휴식을 취하니 힘이 생기는 것 같네.", --13 공통
        "선생님은 숲 밖으로 외출하신 것일 수도 있겠네요.",
        "이렇게까지 꽁꽁 숨어버리시면 찾는 제자가 고생이라니까요.",
        "그렇다고 숲을 나가기엔 선생님께서 절대 안 된다고 말리셨으니까요......",
        "다시 선생님을 찾아다니는 것도 괜찮을 것 같아요."
 	}

 	local options1 = {
 		"이끼에 앉아 숨을 들이켜보자.", 
 		"개울가에 다가가 목을 축여보자."
 	}

 	local options2 = {
 		"이끼에 앉아 숨을 들이켜보자."
 	}

    local curScript = {}
    local curScriptGroup = display.newGroup() --대사배열그룹 작성 추가
    local curScriptNum = 1
 	
 	for i = 1, #scripts, 1 do
 		curScript[i] = display.newText(curScriptGroup, scripts[i], display.contentCenterX, display.contentCenterY*1.6, 1000, 0, "fonts/GowunBatang-Bold.ttf", 27)
		curScript[i].alpha = 0
	end

	curScript[1].alpha = 1
	sceneGroup:insert(curScriptGroup)

	--클릭으로 대사 전환 수정--
	local fastforward_state = 0 --빨리감기상태 0꺼짐 1켜짐 추가

	local playerTime = 400 --플레이어와 이름창 페이드인 시간 추가
	local dialogueFadeInTime = 400 --대사 페이드인과 배경 전환 시간 추가
	local dialogueFadeOutTime = 200 --대사와 이름창 페이드아웃 시간 추가
  
	function changeCharAndBack()
		--플레이어와 이름창 변화 효과 수정--
		if curScriptNum == 4 or curScriptNum == 13 then
			transition.fadeIn(nameGroup, { time = playerTime })
			transition.fadeIn(player, { time = playerTime })
		end
		if curScriptNum == 5 or curScriptNum == 14 or curScriptNum == 15 or
           curScriptNum == 16 or curScriptNum ==17 then
			transition.fadeOut(nameGroup, { time = dialogueFadeOutTime })
		end
	end

	-- 저장 load시 캐릭터와 배경 상태 setting
	function setCharAndBack()
		changeCharAndBack()
		if curScriptNum > 4 then
			player.alpha = 1
		end
		if curScriptNum ~= 4 and curScriptNum ~= 13 then
			nameGroup.alpha = 0
		end
	end

	function nextScript(event) --local 빼기 수정
		print(#scripts)
		print("curScriptNum: ", curScriptNum)
		if curScriptNum == 7 then
			if fastforward_state == 1 then --선택지에서 빨리감기종료 추가
				stopFastForward()
			end

			composer.setVariable("options", options1)
			composer.showOverlay("choiceScene", overlayOption)
		elseif curScriptNum == 12 then
			if fastforward_state == 1 then --선택지에서 빨리감기종료 추가
				stopFastForward()
			end

			composer.setVariable("options", options2)
			composer.showOverlay("choiceScene", overlayOption)
		elseif curScriptNum < #scripts then
			if curScriptNum ~= 0 then
				curScript[curScriptNum].alpha = 0
			end

			--빨리감기상태따른 text 전환 수정--
			if(fastforward_state == 0) then
				curScript[curScriptNum].alpha = 0
				if curScriptNum == 10 then
					curScriptNum = 13
				else
					curScriptNum = curScriptNum + 1
				end
				curScript[curScriptNum].alpha = 1

				playerTime = 200
			else
				transition.fadeOut(curScript[curScriptNum], { time = dialogueFadeOutTime })
				if curScriptNum == 10 then
					curScriptNum = 13
				else
					curScriptNum = curScriptNum + 1
				end
				transition.fadeIn(curScript[curScriptNum], { time = dialogueFadeInTime })
			end
			changeCharAndBack()
		end

	end

	dialogueBox:addEventListener("tap", nextScript) --dialogueBoxGroup -> dialogueBox 수정

	function scene:resumeGame()
		if curScriptNum == 7 then
			local selectedOption = composer.getVariable("selectedOption")
			print(selectedOption)
			curScript[curScriptNum].alpha = 0
			if selectedOption == 1 then
				curScriptNum = 8
			elseif selectedOption == 2 then
				curScriptNum = 11
			end
		elseif curScriptNum == 12 then
			curScript[curScriptNum].alpha = 0
				curScriptNum = 13
				nameGroup.alpha = 1
		end

		print("curScriptNum: ", curScriptNum)
		curScript[curScriptNum].alpha = 1
	end

	--빨리감기기능(추가)--
	local function scriptFastForward()
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

	--빨리감기종료함수 추가--
	function stopFastForward()
		fastforward_state = 0
		dialogueBox:addEventListener("tap", nextScript)
		skipButton:addEventListener("tap", skip)
		timer.pause(timer1)
	end

	--스킵기능(추가)--
	function skip(event)
		if(nameGroup.isVisible == true) then
			transition.fadeOut(nameGroup, { time = dialogueFadeOutTime })
		end

		curScript[curScriptNum].alpha = 0
		if(curScriptNum <= 7) then
			curScriptNum = 7
			transition.fadeIn(player, { time = playerTime })
		elseif(curScriptNum == 11) then
			curScriptNum = 12
		elseif((curScriptNum >= 8 and curScriptNum <= 10) or curScriptNum >= 13) then
			curScriptNum = #scripts
		end
		curScript[curScriptNum].alpha = 1
		-- print("curScriptNum: ", curScriptNum)
	end
	skipButton:addEventListener("tap", skip)

	--메뉴열기--
  	local function menuOpen(event)
  		if(event.phase == "began") then
  			if fastforward_state == 1 then --메뉴오픈시 빨리감기종료 추가
				stopFastForward()
			end
      		-- dialogueBox:removeEventListener("tap", nextScript) --메뉴오픈시 탭 이벤트 제거 추가
      		-- 현재 대사 위치 파라미터로 저장
	      	composer.setVariable("scriptNum", curScriptNum)
  			composer.showOverlay("menuScene", overlayOption)
  		end
  	end
  	menuButton:addEventListener("touch", menuOpen)

	--메뉴의 시작화면으로 버튼 클릭시 현재 장면 닫고 타이틀화면으로 이동 (추가)--
	function scene:closeScene()
		composer.removeScene("story_forest1_1")
		composer.gotoScene()
	end

	-- scriptNum를 params으로 받은 경우: 저장을 load한 경우이므로 특정 대사로 이동
    if event.params then
    	if event.params.scriptNum then
			curScriptNum = event.params.scriptNum
			curScript[1].alpha = 0
			curScript[curScriptNum].alpha = 1
			setCharAndBack()
		end
	end

	-- composer.loadScene("choiceScene")
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase

	print("story_forest1_1: show")
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
		print("story_forest1_1: hide")
	elseif phase == "did" then
		-- Called when the scene is now off screen
		composer.removeScene("story_forest1_1")
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
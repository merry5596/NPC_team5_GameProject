-----------------------------------------------------------------------------------------
--
-- view1.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
	
	-- 임시 배경 --
	local background = display.newImageRect("image/background/오두막내부임시배경.jpg", display.contentWidth, display.contentHeight)
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
  		"해가 떨어진 지 오래네요. 그럼에도 선생님을 마주칠 수 없었어요.", 
  		"살랑살랑 흔들리는 머리카락, 언제나 온화한 미소를 지어주시는 나의 선생님, 대체 어디에 계신 걸까요?", 
 		"아무래도 걱정이 되기 시작합니다.", 
 		"이렇게까지 오래 안 오신 경우는 없었는데...",  -- 4 (evy)
 		"숲 밖까지 돌아다니진 말라는 얘기를 들었지만, 어쩔 수 없을 것 같네요.", 
 		"날이 밝고도 돌아오지 않으신다면 숲을 벗어나보는 것도... 어쩌면 괜찮은 선택일 수도 있겠네요.", 
 		"그런 생각을 하며 당신은 밤을 보냅니다......", 
 		"......", -- 8 (evy)
 		"아직도 돌아오지 않으셨네.", 
 		"아침이 밝았습니다만 오두막에선 아직도 당신의 목소리만이 울리고 있습니다.", 
 		"무슨 일이 있는 게 틀림이 없어요.", 
 		"무릎이 아플 때마다 바르라고 했던 기름 연고를 가방에 주섬주섬 넣고는 밖으로 나갈 채비를 합시다.", 
 		"정말로 숲 밖으로 나서볼까요?", -- 13 (options1)
 		"미지의 공간이라니, 난생 처음 겪는 모험입니다.", -- 14
  		"어떤가요? 두근두근하지 않나요?", 
 		"숲 밖의 세계는 어떨까요. 아주 멋있을 거예요.", -- 16 (go to 19)
 		"기다리고 또 기다렸지만, 날만 저물었습니다. 다시 해가 떠오르기 시작해요.", -- 17
		"정말로 떠나지 않을 건가요?", -- 18 (options2)
		"그렇게 짧은 모험을 떠나기로 합니다." --19
 	}

 	local options1 = {
 		"숲 밖으로 간다.", 
 		"선생님을 더 기다려본다."
 	}

 	local options2 = {
 		"숲 밖으로 간다."
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


	--클릭으로 대사 전환--
	local fastforward_state = 0 --빨리감기상태 0꺼짐 1켜짐 추가

	local playerTime = 400 --플레이어와 이름창 페이드인 시간 추가
	local dialogueFadeInTime = 400 --대사 페이드인과 배경 전환 시간 추가
	local dialogueFadeOutTime = 200 --대사와 이름창 페이드아웃 시간 추가

	function nextScript(event) --local 빼기 수정
		print(#scripts)
		print("curScriptNum: ", curScriptNum)
		if curScriptNum == 13 then
			if fastforward_state == 1 then --선택지에서 빨리감기종료 추가
				stopFastForward()
			end

			composer.setVariable("options", options1)
			composer.showOverlay("choiceScene", overlayOption)
		elseif curScriptNum == 18 then
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
				if curScriptNum == 16 then
					curScriptNum = 19
				else
					curScriptNum = curScriptNum + 1
				end
				curScript[curScriptNum].alpha = 1

				playerTime = 200
			else
				transition.fadeOut(curScript[curScriptNum], { time = dialogueFadeOutTime })
				if curScriptNum == 16 then
					curScriptNum = 19
				else
					curScriptNum = curScriptNum + 1
				end
				transition.fadeIn(curScript[curScriptNum], { time = dialogueFadeInTime })
			end

			--플레이어와 이름창 변화 효과 수정--
			if curScriptNum == 4 or curScriptNum == 8 then
				transition.fadeIn(nameGroup, { time = playerTime })
				transition.fadeIn(player, { time = playerTime })
			end
			if curScriptNum == 5 or curScriptNum == 10 then
				transition.fadeOut(nameGroup, { time = dialogueFadeOutTime })
			end
		end
	end

	dialogueBox:addEventListener("tap", nextScript) --dialogueBoxGroup -> dialogueBox 수정

	function scene:resumeGame()
		if curScriptNum == 13 then
			local selectedOption = composer.getVariable("selectedOption")
			print(selectedOption)
			curScript[curScriptNum].alpha = 0
			if selectedOption == 1 then
				curScriptNum = 14
			elseif selectedOption == 2 then
				curScriptNum = 17
			end
		elseif curScriptNum == 18 then
			curScript[curScriptNum].alpha = 0
				curScriptNum = 19
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

	--스킵기능 (추가)--
	function skip(event)
		if(nameGroup.alpha == 0) then
			transition.fadeIn(nameGroup, { time = playerTime })
		end

		curScript[curScriptNum].alpha = 0
		if(curScriptNum <= 13) then
			curScriptNum = 13
			transition.fadeIn(player, { time = playerTime })
		elseif(curScriptNum == 17) then
			curScriptNum = 18
		elseif(curScriptNum >= 14 and curScriptNum <= 16) then
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
  			composer.showOverlay("menuScene", overlayOption)
  		end
  	end
  	menuButton:addEventListener("touch", menuOpen)

	--메뉴의 시작화면으로 버튼 클릭시 현재 장면 닫고 타이틀화면으로 이동 (추가)--
	function scene:closeScene()
		composer.removeScene("story_forest1_2")
		composer.gotoScene("scene1")
	end

	-- composer.loadScene("choiceScene")
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase

	print("show")
	
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
		composer.removeScene("story_forest1_2")
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
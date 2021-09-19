-----------------------------------------------------------------------------------------
--
-- 엔딩분기.lua
--
-----------------------------------------------------------------------------------------

local composer = require("composer")
local scene = composer.newScene()

function scene:create(event)
	local sceneGroup = self.view

-------------------유저 정보 로드---------------------------------------------------------------------------------
	local loadsave = require( "loadsave" )

	local userSettings = loadsave.loadTable("userSettings.json")

	userSettings.presentScene = "story_before_ending"
	loadsave.saveTable(userSettings, "userSettings.json")
-------------------변수-------------------------------------------------------------------------------
	
	--배경 그림--
	local background1 = display.newImage("image/background/forest(winter).png", display.contentWidth, display.contentHeight)
	background1.x, background1.y = display.contentCenterX, display.contentCenterY
	local background2 = display.newImage("image/background/tomb.png", display.contentWidth, display.contentHeight)
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

-------------------텍스트---------------------------------------------------------------------------------

	--내래이션과 대사--
  	local dialogue = {" ", "무덤가로 가는 길은 그리 멀지 않을 겁니다.",
  					"무덤 근처에 다다르기 전, 하늘을 흘겨보면 겨울임에도 화창하다는 사실을 알 수 있습니다.", --3
  					"희고 푸릅니다. 세상은 온통 하얀데, 홀로 설원 위에 서 있는 기분이 듭니다.",
  					"걸음하는 자리마다 눈에 발이 묻혀 선명하게 발자국이 남습니다.",
  					"그대로 걸어갑니다.", --6
  					"선생님을 찾으러 걸음을 떠난 처음과 같이, 계속 걸어갑니다.",
  					"수많은 나무를 지나고 언덕을 넘어 꽁꽁 얼어버린 개울가를 지나칠 무렵이면,", --8 배경전환
  					"......선생님?", --9 이비대사
  					"무덤가를 발견할 수 있습니다.",
  					"무덤으로 추정되는 새하얀 언덕들 사이에서 누군가가 누워있습니다.",
  					"무덤으로 추정되는 새하얀 언덕들 사이에서 누군가가 누워있습니다.", --12 선택지1 중복
  					"눈 가득 쌓인 언덕 사이에 누군가가 누워있습니다.", --13 선택지1 진행
  					"옅은 채도의 머리카락, 희고 얇은 손가락. 눈을 파헤쳐보면 익숙한 얼굴이 있습니다.",
  					"옅은 채도의 머리카락, 희고 얇은 손가락. 눈을 파헤쳐보면 익숙한 얼굴이 있습니다.", --15 선택지2 중복
  					"얼음장입니다. 응당 살아있는 사람이라면 뛸 맥박이 느껴지지 않습니다.", --16 선택지2 진행
  					"이 사람도 옛날엔 혈관 아래 작은 고동을 품고 숨을 들이키며 살아갔었겠죠.",
  					"생을 마친 이의 온기임에 틀림이 없습니다.",
  					"생을 마친 이의 온기임에 틀림이 없습니다.", --19 선택지3 중복
  					"얕은 얼굴 주름과 온화한 얼굴, 눈송이에 덮여 윤기를 잃은 장발, 다정하고도 굳게 감긴 두 눈.", --20 선택지3 진행
  					"은은하게 기름 냄새를 풍기는 소매, 직감합니다. 당신이 찾던 사람입니다.",
  					"그토록 찾던 당신의 선생님, 스페스입니다.",
  					"선생님은 편안한 얼굴로 잠들어 있습니다.", --23
  					"늘 약을 입에 달고 살며 미간을 한껏 찌푸리던 때의 고통은 깨끗하게 잊었다는 듯이, 정말로 편안해 보입니다.",
  					"선생님을 찾아다니기 위한 모험이 막을 내렸습니다.",
  					"선생님 곁에 영원히 남을 수도 있고, 다시 길을 떠날 수도 있겠죠.", --26
  					"이젠 당신을 걱정할 지성체는 지상 위에 남아있지 않을 테니까요.",
  					"어떻게 하고 싶나요?",
  					"어떻게 하고 싶나요?" --29 선택지4 엔딩분기
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
	local showName = display.newText(name, nameBox.x, nameBox.y*0.993, "fonts/GowunBatang-Bold.ttf", 30)

	--이름창+이름글자 그룹--
	local nameGroup = display.newGroup()
	nameGroup:insert(nameBox)
	nameGroup:insert(showName)
	nameGroup.alpha = 0
	sceneGroup:insert(nameGroup)

	--선택지 내용--
	local options1 = {
 		"누군가에게 다가간다."
 	}

 	local options2 = {
 		"손을 잡아본다."
 	}

 	local options3 = {
 		"소복히 쌓인 눈을 헤집어 살펴본다."
 	}

 	local options4 = {
 		"스페스 곁에 남는다.",
 		"스페스 곁을 떠난다."
 	}

  	--overlayOption: overlay 화면의 액션 이 씬에 전달 X
	local overlayOption =
	{
	    isModal = true
	}

-------------------함수----------------------------------------------------------------------------------

	local fastforward_state = 0 --빨리감기상태 0꺼짐 1켜짐

	local playerTime = 400 --플레이어와 이름창 페이드인 시간
	local dialogueFadeInTime = 400 --대사 페이드인과 배경 전환 시간
	local dialogueFadeOutTime = 200 --대사와 이름창 페이드아웃 시간

	--선택지 제시 함수--
	function showOptions(optionsName)
		composer.setVariable("options", optionsName)
		composer.showOverlay("choiceScene", overlayOption)
	end

	-- 대사 상태가 변경되었을 때 캐릭터와 배경 상태 setting
	function changeCharAndBack()
		if(i == 8) then
			transition.dissolve(background1, background2, dialogueFadeInTime) --배경전환
		elseif(i == 9) then
			transition.fadeIn(nameGroup, { time = playerTime })
			transition.fadeIn(player, { time = playerTime })
		elseif(i == 10) then
			transition.fadeOut(nameGroup, { time = dialogueFadeOutTime })
		end
	end


	-- 저장 load시 캐릭터와 배경 상태 setting
	function setCharAndBack()
		changeCharAndBack()
		if(i > 8) then
			transition.dissolve(background1, background2, dialogueFadeInTime) --배경전환
		end
		if i > 9 then
			player.alpha = 1
		end
	end

	--클릭으로 대사 전환--
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

		changeCharAndBack()

		--선택지 제시
		if(i == 12) then
			if fastforward_state == 1 then --선택지에서 빨리감기종료 추가
				stopFastForward()
			end
			showOptions(options1)
		elseif(i == 15) then
			if fastforward_state == 1 then --선택지에서 빨리감기종료 추가
				stopFastForward()
			end
			showOptions(options2)
		elseif(i == 19) then
			if fastforward_state == 1 then --선택지에서 빨리감기종료 추가
				stopFastForward()
			end
			showOptions(options3)
		elseif(i == 29) then
			if fastforward_state == 1 then --선택지에서 빨리감기종료 추가
				stopFastForward()
			end
			showOptions(options4)
		end
	end
	dialogueBox:addEventListener("tap", nextScript)


	--선택지 선택 후 스토리 진행--
	function scene:resumeGame()
		showDialogue[i].alpha = 0
		if(i == 12) then
			i = 13
		elseif(i == 15) then
			i = 16
		elseif(i == 19) then
			i = 20
		elseif(i == 29) then
			local selectedOption = composer.getVariable("selectedOption")
			print("selectedOption:", selectedOption)
			if selectedOption == 1 then
				composer.gotoScene("story_ending1")
			elseif selectedOption == 2 then
				composer.gotoScene("story_ending2")
			end
		end
		showDialogue[i].alpha = 1
	end

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
		if(i < 8) then
			transition.dissolve( background1, background2, dialogueFadeInTime)
		end

		showDialogue[i].alpha = 0
		if(i <= 11) then --대사
			i = 11
		elseif(i > 12 and i <= 14) then
			i = 14
		elseif(i > 15 and i <= 18) then
			i = 18
		elseif(i >= 20 and i < #dialogue) then
			i = #dialogue - 1
		end
		showDialogue[i].alpha = 1
		
		print("i: ", i)

		return true
	end
	skipButton:addEventListener("tap", skip)

  	--메뉴열기--
	local bounds = menuButton.contentBounds
	local isOut
  	local function menuOpen(event)
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
		        	if fastforward_state == 1 then --메뉴오픈시 빨리감기종료 추가
						stopFastForward()
					end
		      		-- dialogueBox:removeEventListener("tap", nextScript) --메뉴오픈시 탭 이벤트 제거 추가
		      		-- 현재 대사 위치 파라미터로 저장
			      	composer.setVariable("scriptNum", i)
			      	composer.setVariable("userSettings", userSettings)
		  			composer.showOverlay("menuScene", overlayOption)
				end	
			end
	    end	
  	end
  	menuButton:addEventListener("touch", menuOpen)

  	--메뉴 시작화면으로 버튼 클릭시 장면 닫고 타이틀화면으로 이동--
	function scene:closeScene()
		composer.removeScene("story_before_ending") --현재 장면 이름 넣기 ex)storyScene
		-- composer.gotoScene("scene1")
	end
	
	-- scriptNum를 params으로 받은 경우: 저장을 load한 경우이므로 특정 대사로 이동
    if event.params then
    	if event.params.scriptNum then
			i = event.params.scriptNum
			showDialogue[1].alpha = 0
			showDialogue[i].alpha = 1
			-- setCharAndBack()
		end
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
		composer.removeScene("story_before_ending")
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
-----------------------------------------------------------------------------------------
--
-- 엔딩1.lua
--
---------------------------------s--------------------------------------------------------

local composer = require("composer")
local scene = composer.newScene()

function scene:create(event)
	local sceneGroup = self.view
	
-------------------변수---------------------------------------------------------------------------------

	--배경 그림--
	local background = display.newImage("image/background/tomb_임시.jpg", display.contentWidth, display.contentHeight)
	background.x, background.y = display.contentCenterX, display.contentCenterY
	sceneGroup:insert(background)

	--밝은 플레이어 그림--
	local player = display.newImage("image/component/evy.png")
	player.x, player.y = display.contentCenterX, display.contentCenterY*1.5
	player:scale(1.2, 1.2)
	player.alpha = 0
	sceneGroup:insert(player)

	--어두운 플레이어 그림--
	local player_dark = display.newImage("image/component/evy.png")
	player_dark.x, player_dark.y = display.contentCenterX, display.contentCenterY*1.5
	player_dark:scale(1.2, 1.2)
	player_dark:setFillColor(0.5)
	player_dark.alpha = 0
	sceneGroup:insert(player_dark)

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
  	local dialogue = {" ", "잘 들어보세요, 이비. 세상에는 이별이라는 것이 있는데...",
  				"운명이라는 것은 세계를 순환하기에 완전한 이별이란 존재하지 않습니다.", --3
  				"인연은 언제까지나 이어지는 것이니까요.",
  				"다시 볼 수 없는 곳으로 떠나지만 않으면 이 짧은 생에서라도 만남을 가질 수 있을 겁니다.",
  				"늘 이 말 뒤에 따라붙었던 선생님의 말씀이 있었죠.", --6
  				"오늘은 혼자 놀아보도록 할래, 이비?'",
  				"그러니 마지막으로 선생님 옆에서 놀음을 가지도록 해봅시다.",
  				"당신이 안드로이드라는 사실은 이미 짐작하고 있겠죠.", --9
  				"직감할 수 있습니다. 선생님의 곁에 영원히 머물러 늘과 같은 봄을 꿈꾸기 위해서라면......",
  				"눈을 감고, 머리 구석 어딘가에 백업해둔 정보의 흐름을 뒤적여봅시다.",
  				"그러곤 선생님과의 마지막 놀이를 위해 외쳐볼까요.", --12
  				"이비, 시스템 가동 종료.", --13 이비대사
  				"인연이란 누군가와의 연결이 끊기기 전까지 이어지는 것.",
  				"분명 선생님과의 인연의 끈은 튼튼하니까, 언제까지나 함께하는 거에요.", --15
  			}

  	local ending = {"Ending 1: 마지막 인류와 안드로이드"}

	--대사 구성--
	local showDialogue = {}
	local showDialogueGroup = display.newGroup()
	for i = 1, #dialogue do
		showDialogue[i] = display.newText(showDialogueGroup, dialogue[i], dialogueBox.x, dialogueBox.y, 1000, 0, "fonts/GowunBatang-Bold.ttf", 27)
		showDialogue[i]:setFillColor(1)
		showDialogue[i].alpha = 0
	end
	sceneGroup:insert(showDialogueGroup)

	--엔딩 문장--
	local showEnding = {}
	endingNum = 0
	showEnding[1] = display.newText(ending[1], dialogueBox.x, dialogueBox.y, 1000, 0, "fonts/국립박물관문화재단클래식B.ttf", 27)
	showEnding[1]:setFillColor(1)
	showEnding[1].alpha = 0

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
		if(i == 2) then
			transition.fadeIn(player, { time = playerTime })
		elseif(i == 13) then
			transition.fadeIn(nameGroup, { time = playerTime })
			transition.fadeIn(player_dark, { time = playerTime })
		elseif(i == 14) then
			transition.fadeOut(nameGroup, { time = dialogueFadeOutTime })
		end
	end
	
	-- 저장 load시 캐릭터와 배경 상태 setting
	function setCharAndBack()
		changeCharAndBack()
		if i > 2 and i < 12 then	-- i > 5이면 배경이 background2, 이비 alpha=1
			player.alpha = 1
		end
		if i > 13 then
			player_dark.alpha = 1
		end
	end

	function nextScript(event)
		if(fastforward_state == 0) then
			showDialogue[i].alpha = 0
			if(endingNum == 0) then
				if(i < #dialogue) then
					i = i + 1
					if(i == #dialogue) then
						endingNum = 1
					end
				end
				showDialogue[i].alpha = 1
			else
				showEnding[1].alpha = 1
			end

			playerTime = 200
		else
			transition.fadeOut(showDialogue[i], { time = dialogueFadeOutTime })
			if(endingNum == 0) then
				if(i < #dialogue) then
					i = i + 1
					if(i == #dialogue) then
						endingNum = 1
					end
				end
				transition.fadeIn(showDialogue[i], { time = dialogueFadeInTime })
			else
				transition.fadeIn(showEnding[1], { time = dialogueFadeInTime })
			end
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

		transition.fadeOut(showDialogue[i], { time = dialogueFadeOutTime })
		transition.fadeIn(showEnding[1], { time = dialogueFadeInTime })
		
		print("i: ", i)

		return true
	end
	skipButton:addEventListener("tap", skip)

	local overlayOption =
	{
	    isModal = true
	}

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
		  			composer.showOverlay("menuScene", overlayOption)
				end	
			end
	    end	
  	end
  	menuButton:addEventListener("touch", menuOpen)

	--메뉴 시작화면으로 버튼 클릭시 장면 닫고 타이틀화면으로 이동--
	function scene:closeScene()
		composer.removeScene("story_ending1")
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
		composer.removeScene("story_ending1")
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
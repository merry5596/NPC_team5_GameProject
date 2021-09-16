-----------------------------------------------------------------------------------------
--
-- 엔딩2.lua
--
---------------------------------s--------------------------------------------------------

local composer = require("composer")
local scene = composer.newScene()

function scene:create(event)
	local sceneGroup = self.view
	
-------------------변수---------------------------------------------------------------------------------

	--배경 그림--
	local background1 = display.newImage("image/background/tomb_임시.jpg", display.contentWidth, display.contentHeight)
	background1.x, background1.y = display.contentCenterX, display.contentCenterY
	local background2 = display.newImage("image/background/forest(겨울).png", display.contentWidth, display.contentHeight)
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
  	local dialogue = {" ", "잘 들어보세요, 이비. 세상에는 이별이라는 것이 있는데...",
  				"운명이라는 것은 세계를 순환하기에 완전한 이별이란 존재하지 않습니다.", --3
  				"인연은 언제까지나 이어지는 것이니까요.",
  				"이 세상에는 선생님의 흔적으로 가득합니다.",
  				"연약한 피부를 가진 인간의 발자취, 당신을 제작한 수많은 이들의 노고, 선생님의 다정을 닮은 따스한 노을.", --6
  				"인연이란 누군가와의 연결이 끊기기 전까지 이어지는 것.",
  				"대지를 밟고 설원을 걷고, 초원을 뛰어가다보면 선생님이 살아온 이 세상을 더 잘 알 수 있게 되지 않을까요?",
  				"그러니까, 다시 모험을 시작하는 거예요.", --9 이비등장
  				"선생님의 곁을 떠납시다.", --10 배경전환
  				"선생님이 마주하고 살아온 세계를 돌아보는 거예요.",
  				"이젠 누군가를 찾을 필요는 없습니다. 이미 당신이 찾던 이를 마주했고, 그 결말까지 확인했으니까요.",
  				"짐작하고 있겠지요, 당신이 안드로이드라는 사실을.", --13
  				"무른 몸을 가진 인간, 선생님보다는 오래 가동하며 살아가지 않을까요.",
  				"수많은 봄과 겨울을 지나치며 걸어갑시다.",
  				"마지막 인류의 흔적을 뒤쫓으며 폐허를 되새겨봅시다.", --16
  				"이것은 이비의 모험이니까요.", --17
  			}

  	local ending = {"Ending 2: 이비의 모험"}

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
		if(i == 9) then
			transition.fadeIn(player, { time = playerTime })
		elseif(i == 10) then
			transition.dissolve(background1, background2, dialogueFadeInTime) --배경전환
		end
	end
	
	-- 저장 load시 캐릭터와 배경 상태 setting
	function setCharAndBack()
		changeCharAndBack()
		if i > 9 then	-- i > 5이면 배경이 background2, 이비 alpha=1
			player.alpha = 1
		end
		if i > 10 then
			transition.dissolve(background1, background2, dialogueFadeInTime) --배경전환
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
		if(i < 10) then
			transition.dissolve( background1, background2, dialogueFadeInTime)
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
		composer.removeScene("story_ending2")
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
-----------------------------------------------------------------------------------------
--
-- 숲2 파트 중.lua
--
-----------------------------------------------------------------------------------------

local composer = require("composer")
local scene = composer.newScene()

function scene:create(event)
	local sceneGroup = self.view

-------------------변수-------------------------------------------------------------------------------
	
	--배경 그림--
	local background1 = display.newImage("image/background/inside_cabin_임시.jpg", display.contentWidth, display.contentHeight)
	background1.x, background1.y = display.contentCenterX, display.contentCenterY
	background1.alpha = 0
	local background2 = display.newImage("image/background/outside_cabin_임시.jpg", display.contentWidth, display.contentHeight)
	background2.x, background2.y = display.contentCenterX, display.contentCenterY
	sceneGroup:insert(background1)
	sceneGroup:insert(background2)

	--플레이어 그림--
	local player = display.newImage("image/component/evy.png")
	player.x, player.y = display.contentCenterX, display.contentCenterY*1.5
	player:scale(1.2, 1.2)
	player.alpha = 0
	sceneGroup:insert(player)

	--선생님 그림--
	local teacher = display.newImage("image/component/스탠딩_선생님.png")
	teacher.x, teacher.y = display.contentCenterX, display.contentCenterY*1.6
	teacher:scale(1.6, 1.6)
	teacher.alpha = 0
	sceneGroup:insert(teacher)

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
  	local dialogue = {" ", "아, 오두막이 보여.", -- 이비대사 (2)
  					"다시 안락한 오두막 근처로 발을 들이면, 그 주위는 잔잔하기 그지 없습니다.",
  					"인기척조차 느껴지지 않는 이곳. 선생님은 아무래도 안 계시는 것 같아요.",
  					"또 허탕인가 싶지만, 이렇게까지 찾아다녔는데도 못 찾는 걸 보면 정말 무슨 일이라도 생기신 것 같아요.",
  					"일단 오두막으로 들어가서 잠시 휴식을 취하고자 더 가까이 접근하면......",
  					"따끈한 오두막 내부가 당신을 반겨줍니다.", --배경 전환 (7)
  					"......",
  					"잠시 숨을 돌리면, 선생님의 방을 떠올리게 됩니다.",
  					"선생님의 방만큼은 들어오지 말라고 하셨지만, 혹시 그곳에서 머무르고 계신 걸지도 모르겠네요.",
  					"선생님께서 연구할 적이면, 방문은 굳게 닫혀 도무지 열릴 기색을 보이지 않았었죠.",
  					"혹시 연구라도 하고 계신 걸까요?",
  					"곧장 선생님의 방이 있을 2층으로 올라가 방문을 노크해봅니다.",
  					"노크에 대한 대답은 없지만... 열어볼 수는 있을 것 같습니다.",
  					"노크에 대한 대답은 없지만... 열어볼 수는 있을 것 같습니다.", -- 문장 중복 선택지1 (15)
  					"어두운 방, 램프 버튼을 눌러 불을 켜면 시야가 환해집니다.", --선택지1 진행 (16)
  					"방은 방의 주인을 닮는다더니, 늘 정갈한 선생님의 모습이 그대로 담겨 나온 듯한 공간입니다.",
  					"깨끗하고, 가지런하고, 단정합니다.",
  					"깨끗하고, 가지런하고, 단정합니다.", -- 문장 중복 선택지2 (19)
  					"수많은 책들이 책장에 가지런히 꽂혀있습니다.", --선택지2 진행 (20)
  					"설설 책을 하나씩 꺼내 펼쳐보면, 안드로이드에 관한 내용으로 가득합니다.",
  					"그러다가 펼친 어느 책에서 묘한 이야기를 발견할 수 있었습니다.",
  					--책 내용 삽입
  					"스페스라면, 선생님의 성함이고. 이비는 당신의 이름일 텐데...... 이게 무슨 일인 걸까요?", --책 내용 이후 (46)23
  					"안드로이드라니? 이비가요?",
  					" ", --선택지3 (48)25
  					"아니나 다를까, 선생님의 책상에 눈길을 주면 많은 사람들 틈에 둘러싸여 웃고 있는 선생님 사진과 종이 한 장이 있습니다.", --선택지3 진행 (49)27
  					"종이 한 장을 펼쳐보면, 그곳에는 약도가 그려져 있네요.",
  					"숲의 약도입니다.",
  					"오두막에서 동쪽으로 열 발자국, 남쪽으로 마흔아홉 걸음, 서쪽으로 여든세 걸음.",
  					"그곳에 무덤가가 있다는 내용입니다.",
  					"...무덤가에 가신 걸까? 역시 그런 걸지도......", -- 이비대사 (54)31
  					"약도를 훑어보니, 무덤가는 숲 내에 꽁꽁 숨겨진 위치에 있습니다.",
  					"역시 걱정입니다. 선생님, 스페스께서는 늘 몸이 좋지 않으셨으니까요.",
  					"안드로이드가 자신이든, 아니든... 혼란스럽기 짝이 없는 얘기일 뿐이니 원래 목적을 다시 상기해보는 겁니다.",
  					"겨울이 왔어. 이 차가운 바람을 계속 맞고 계시다가는 감기에 걸리실지도 몰라.", -- 이비대사 (58)35
  					"...막연한 생각이 들어. 선생님도 선생님의 동료들처럼 훌쩍 떠나려는 건 아니시겠지?", -- 이비대사 (59)36
  					"늘 선생님께서는 말씀하셨습니다.",
  					"이비, 잘 들어보렴. 세상에는 이별이라는 것이 있는데......", --스페스대사 (61)38
  					"운명이란 건 세계를 순환하는 것인지라, 완전한 이별은 존재하지 않는다고 봐도 돼.", --스페스대사 (62)39
  					"시간이 얼마나 오래 지나든... 다시 볼 수 없는 곳으로 떠나지만 않는다면 이 짧은 생에서 만남을 우연으로라도 가질 가능성이 높단 뜻이지.", --스페스대사 (63)40
  					"...아, 약을 먹을 시간이네. 오늘은 혼자 놀아보도록 할래, 이비?", --스페스대사 (64)41
  					"인연이란 사람의 생이 마무리되기 전까지 이어지는 것.",
  					"분명 선생님과의 인연의 끈은 튼튼할 테니까, 계속 뵐 수 있을 거라 생각합시다." --(66)43
  				}

  	local bookStory = {" ", "『세상의 멸망이 다가오고 있다. 사람들은 죽어나가고, 기껏 만들어둔 가정용 안드로이드는 폐기되는 세계.", -- 책 내용 삽입 (23)
  					"수차례 기후이변이 발생하더니 이젠 모든 식물이 말라 죽어가고 있다.",
  					"안드로이드 연구소의 일원들도 흩어지기 시작했는데, 소수의 인원만이 남아서 마지막 연구를 진행하고 있다.",
  					"죽기 전에 걸작이라도 만들어보고자 하는 심산이었다.",
  					"모델명 '이비', 가정용 안드로이드로 순한 인상의 어린아이 외형을 지니고 있다.",
  					"가사일보단 대화 상대에 적절한 안드로이드이다.",
  					".\n.", --(29)
  					"연구원들과 약속을 했다.",
  					"계속해서 죽어나가더라도 이비를 수리하고, 제작하는 과정은 이어나가기로.",
  					"유작을 만들자.",
  					"모두가 그렇게 합심하여 만들고자 노력한 결과가 이비였으니까, 우리는 이비에게 몰두했다.",
  					"그리고 마침내, 이비를 작동할 수 있게 되었다.",
  					"세상의 2/3이 이미 파괴된 때였다.",
  					".\n.", --(36)
  					"우리들 중에선 스페스가 마지막으로 살아남을 듯하다.",
  					"식량은 부족하고, 인간이 살아남기엔 부적합한 환경에다가 스페스를 제외한 연구원들은 이미 노쇠한 지 오래였다.",
  					"가장 어린 스페스가 이비 제작의 마지막 길을 걷게 되었고, 스페스는 그날부터 동료들의 무덤가 주변에 있는 버려진 오두막에서 머물기 시작했다.",
  					"그렇게 하나둘 목숨을 거뒀다.』", --(40)
  					"『나는 스페스. 모든 연구원들이 죽었고, 동료들과 함께했을 적의 이비 메모리는 삭제해버렸다.", --20
  					"그 이유는 이비에게 죽음이라는 것을 학습시키기 싫었던 탓에 가까웠다.",
  					"물 정수 기능이나 공기 청정 기능을 마법이라 속이기로 했고, 마법사라 자칭하며 동화적인 환경이나 만들어보기도 했는데 이게 과연 잘한 일인 걸까.",
  					"동료들과의 추억을 지우면서까지 이비에게 거짓을 말하는 게 괜찮은 행동인 건지 종종 막연한 기분이 든다.",
  					"그래도 세상에 홀로 남겨졌으니 이런 식으로라도 살아봐야지. 이비는 모두의 유산이니까 내가 죽기 전까지는 한껏 아껴줘야지, 싶어서......』" --(46)24
  				}

  	--대사 구성--
	local showDialogue = {}
	local showDialogueGroup = display.newGroup()
	local dialogueNum = 1
	for i = 1, #dialogue do
		showDialogue[i] = display.newText(showDialogueGroup, dialogue[i], dialogueBox.x, dialogueBox.y, 1000, 0, "fonts/GowunBatang-Bold.ttf", 27)
		showDialogue[i]:setFillColor(1)
		showDialogue[i].alpha = 0
	end
	sceneGroup:insert(showDialogueGroup)

	--책 내용 구성--
	local showBookStory = {}
	local showBookStoryGroup = display.newGroup()
	local bookStoryNum = 1
	for j = 1, #bookStory do
		showBookStory[j] = display.newText(showBookStoryGroup, bookStory[j], dialogueBox.x, dialogueBox.y, 1000, 0, "fonts/Typo_PapyrusEB.ttf", 35)
		showBookStory[j]:setFillColor(1)
		showBookStory[j].alpha = 0
	end
	sceneGroup:insert(showBookStoryGroup)

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
 		"『선생님의 방』, 문을 열어본다.", 
 	}

 	local options2 = {
 		"『책장』으로 다가가본다."
 	}

 	local options3 = {
 		"『책상』으로 다가가본다."
 	}

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

	--캐릭터과 이름창 등장 + 배경 전환
	function playerAppear()
		if(dialogueNum == 2 or dialogueNum == 35) then
			transition.fadeIn(nameGroup, { time = playerTime })
			transition.fadeIn(player, { time = playerTime })
		elseif(dialogueNum == 7) then
			transition.dissolve(background2, background1, dialogueFadeInTime) --배경전환
		elseif(dialogueNum == 3 or dialogueNum == 37) then
			transition.fadeOut(nameGroup, { time = dialogueFadeOutTime })
			transition.fadeOut(player, { time = dialogueFadeOutTime })
		elseif(bookStoryNum == 20) then
			transition.fadeIn(teacher, { time = playerTime })
		elseif(dialogueNum == 23) then
			transition.fadeOut(teacher, { time = dialogueFadeOutTime })
		elseif(dialogueNum == 38) then
			transition.fadeIn(teacher, { time = playerTime })
		elseif(dialogueNum == 42) then
			transition.fadeOut(teacher, { time = dialogueFadeOutTime })
		end
	end

	--캐릭터와 이름창 사라짐 + 배경 전환
	function playerDisappear()
		if(player.isVisible == true and nameGroup.isVisible == true) then
			nameGroup.isVisible = false
			player.isVisible = false
		end
	end

	--클릭으로 대사 전환+선택지 전개--
	i = 1
	function nextScript(event)
		print("i: ", i)
		if(fastforward_state == 0) then
			--스토리 전환
			if(i < #dialogue + #bookStory - 1) then
				if(i <= 22 or i >= 47) then --대사 전환
					if(i == 47) then
						showBookStory[#bookStory].alpha = 0
					end
					showDialogue[dialogueNum].alpha = 0
					dialogueNum = dialogueNum + 1
					if(i < #dialogue + #bookStory - 1) then
						i = i + 1
						showDialogue[dialogueNum].alpha = 1
					end
				else --책내용 전환
					if(i == 23) then
						showDialogue[22].alpha = 0
					end
					showBookStory[bookStoryNum].alpha = 0
					bookStoryNum = bookStoryNum + 1
					i = i + 1
					showBookStory[bookStoryNum].alpha = 1
				end
				if(i == 22 or i == 45) then
					i = i + 1
				end
			end

			playerTime = 200
		else
			--스토리 전환
			if(i < #dialogue + #bookStory - 1) then
				if(i <= 22 or i >= 47) then --대사 전환
					if(i == 47) then
						transition.fadeOut(showBookStory[#bookStory], { time = dialogueFadeOutTime })
					end
					transition.fadeOut(showDialogue[dialogueNum], { time = dialogueFadeOutTime })
					dialogueNum = dialogueNum + 1
					if(i < #dialogue + #bookStory - 1) then
						i = i + 1
						transition.fadeIn(showDialogue[dialogueNum], { time = dialogueFadeInTime })
					end
				else --책내용 전환
					if(i == 23) then
						transition.fadeOut(showDialogue[22], { time = dialogueFadeOutTime })
					end
					transition.fadeOut(showBookStory[bookStoryNum], { time = dialogueFadeOutTime })
					bookStoryNum = bookStoryNum + 1
					i = i + 1
					transition.fadeIn(showBookStory[bookStoryNum], { time = dialogueFadeInTime })
				end
				if(i == 22 or i == 45) then
					i = i + 1
				end
			end
		end

		playerAppear()

		--선택지 제시
		if(dialogueNum == 15) then
			if fastforward_state == 1 then --선택지에서 빨리감기종료 추가
				stopFastForward()
			end
			showOptions(options1)
		elseif(dialogueNum == 19) then
			if fastforward_state == 1 then --선택지에서 빨리감기종료 추가
				stopFastForward()
			end
			showOptions(options2)
		elseif(dialogueNum == 25) then
			if fastforward_state == 1 then --선택지에서 빨리감기종료 추가
				stopFastForward()
			end
			showOptions(options3)
		end
	end
	dialogueBox:addEventListener("tap", nextScript)

	--선택지 선택 후 스토리 진행--
	function scene:resumeGame()
		showDialogue[dialogueNum].alpha = 0
		if(dialogueNum == 15) then
			dialogueNum = 16
			i = 16
		elseif(dialogueNum == 19) then
			dialogueNum = 20
			i = 20
		elseif(dialogueNum == 25) then
			dialogueNum = 26
			i = 49
		end
		showDialogue[dialogueNum].alpha = 1
	end

	--빨리감기기능--
	local function scriptFastForward()
		-- print("i: ", i)
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
		--이전 글 안 보이게
		if(i < 24 or i > 47) then --대사 
			showDialogue[dialogueNum].alpha = 0
		else --책 내용
			showBookStory[bookStoryNum].alpha = 0
		end

		playerAppear()
		playerDisappear()

		if(i <= 14) then --대사
			i = 14
			dialogueNum = 14
		elseif(i >= 15 and i <= 18) then
			i = 18
			dialogueNum = 18
		elseif(i >= 19 and i <= 47) then
			i = 47
			dialogueNum = 24
			-- bookStoryNum = #bookStory - 1
		elseif(i >= 48 and i < #dialogue + #bookStory - 1) then
			i = #dialogue + #bookStory - 2
			dialogueNum = #dialogue - 1
		end
		showDialogue[dialogueNum].alpha = 1
	end
	skipButton:addEventListener("tap", skip)

  	--메뉴열기--
  	local function menuOpen(event)
  		if(event.phase == "began") then
  			if fastforward_state == 1 then --메뉴오픈시 빨리감기종료 추가
				stopFastForward()
			end
  			-- dialogueBox:removeEventListener("tap", nextScript)
  			-- 현재 대사 위치 파라미터로 저장
			composer.setVariable("scriptNum", i)
  			composer.showOverlay("menuScene", overlayOption)
  		end
  	end
  	menuButton:addEventListener("touch", menuOpen)

  	--메뉴 시작화면으로 버튼 클릭시 장면 닫고 타이틀화면으로 이동--
	function scene:closeScene()
		composer.removeScene("story_forest2_2") --현재 장면 이름 넣기 ex)storyScene
		composer.gotoScene("scene1")
	end

	-- scriptNum를 params으로 받은 경우: 저장을 load한 경우이므로 특정 대사로 이동
    if event.params then
       	if event.params.scriptNum then
			print("params.scriptNum: ", event.params.scriptNum)
			i = event.params.scriptNum
			showDialogue[1].alpha = 0
			showDialogue[i].alpha = 1
			playerAppear()
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
		composer.removeScene("story_forest2_2")
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
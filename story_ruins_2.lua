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
	local background = display.newImageRect("image/background/ruins_nature.jpg", display.contentWidth, display.contentHeight)
	background.x, background.y = display.contentWidth*0.5, display.contentHeight*0.5
	sceneGroup:insert(background)

	--플레이어 그림--
	local player = display.newImage("image/component/evy.png")
	player.x, player.y = display.contentCenterX, display.contentCenterY*1.5
	player:scale(1.2, 1.2)
	player.isVisible = false
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
	nameGroup.isVisible = false
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

  	--메뉴열기--
  	local function menuOpen(event)
  		if(event.phase == "began") then
			-- dialogueBox:removeEventListener("tap", nextScript) --메뉴오픈시 탭 이벤트 제거 추가
  			composer.showOverlay("menuScene", overlayOption)
  		end
  	end
  	menuButton:addEventListener("touch", menuOpen)

  	local scripts = {
  		"계속해서 걸어다닌 지 몇 시간. 슬슬 무릎이 삐걱거리기 시작해 가방에서 기름 연고를 꺼내 바르다보면, ", 
  		"잔해 가득한 건물 사이에서 쉴만한 공간이 보입니다. 표지판에 [숲 서점]이라 적혀있는 걸 보니, 책을 팔던 곳이었던 것 같아요.", 	-- 2 (options1)
 		"서점에 들어서면, 퀘퀘한 종이 내음과 다 무너진 책장 사이로 잔뜩 낡은 헝겊 소파가 보입니다.", -- 3: 서점 시작
 		"이용하지 않은 지 오래된 걸까요. 손으로 그 위를 쓸어보면 먼지와 흙이 나풀댑니다. 소파 위에는 잡지 하나가 놓여있습니다.",  -- 4 (options2)
 		"잡지의 낱장을 펄럭여보면, 제일 첫장에 [신-안드로이드 개발 성공, 가정용 안드로이드 보급의 성공.]이라는 제목이 눈에 띕니다.", 
 		"더 살펴보면... 우스갯소리로 멸망론에 관해 적어둔 게 보입니다.", -- 6: 서점 끝 (to 32)
 		"콘크리트에 주의하세요. 잘못 헛디뎌 넘어지면 큰일이니까요.", -- 7: 아파트 잔해 시작
 		"그래도 아파트 잔해 사이에 햇빛을 막아주고, 바람을 막아줄 법한 공간이 보입니다.", 
 		"다 무너진 침대인 것 같지만 이게 어디인가요. 폐허 속에서 잠시나마 쉴 곳을 발견했다는 게 다행이잖아요.", -- 9 (options3)
 		"푹. 다 망가진 스프링이 당신을 반깁니다. 잘못 자면 허리가 아프겠어요.", -- 10
 		"아니지, 관절이라고 하는 게 좋을까요? 선생님께서 주셨던 기름 연고가 떨어지는 소리가 들리네요.", 
 		"삐걱삐걱. 쇳소리가 몸의 관절에서 새어나오는 기분이 듭니다.",
 		"숨어있던 바퀴벌레가 툭 튀어나오더니 후다닥 도망갑니다.", -- 13
 		"사람은 없어도 바퀴벌레는 살아있네요. 바퀴벌레가 머물던 곳에는 신문지가 있습니다.", 
  		"[세계 멸망의 길. 노스트라다무스의 예언]이라는 헤드라인이에요.", 
 		"과거의 사람들은 멸망론을 신봉했던 걸까요.", -- 16: 아파트 잔해 끝 (to 32)
 		"옛날에는 사람들이 많이 모이던 장소였나봐요. 이제는 흔적도 없이 무너졌지만 곳곳에 화려하고도 더러운 간판이 떨어져 있습니다.", -- 17: 번화가 시작
		"화장품 가게부터 시작해서 음식점까지. 이곳은 과거에 도시였나봐요.", 
		"길거리에 다 바스라진 종이들과 깨진 유리가 가득합니다.", 
		"신발에 유리가 박힐까 걱정하여 발을 들어보면, 밑창에 유리가 잔뜩 박혀있습니다.", 
		"선생님께서 직접 만들어주셨던 건데, 아쉽게 되었어요.", 
		"그래도 당신의 피부는 단단한 편이니 유리가 박힐 일은 없겠죠. 안심하고 걸어다녀도 될 듯합니다.", -- 22(options4)
		"유리 잔해를 발로 치우며 어기적 들어가보면, 햇살이 옅게 들어오는 작은 구멍가게 내부인 것을 알아차릴 수 있습니다.", -- 23
		"진열장에는 진통제와 파상풍약이 가득합니다.", 
		"... 아, 약이라도 파는 곳이었을까요? 파상풍약 밑에 고객들을 위한 문구가 있습니다.", 
		"[여린 우리 아이 발에 난 상처! 파상풍, 빠르게 치료하셔야 합니다.]", 
		"과거의 사람들은 피부가 선생님처럼 무르기라도 했던 걸까요. 선생님의 살갗은 쿡 누르면 물렁하게 들어갔던 기억이 납니다..", 
		"바닥에 잔뜩 전단지들이 누워있습니다.", -- 28
		"오래 시간이 지나 그 글자와 형체를 알아보기는 어렵지만 자세히 살펴보면 대충 해석할 수 있을 듯합니다.", 
		"[... 어디로... 대피... 인류...], [하느님이... 버린...], [안드로이드... 연구소... 폐쇄...]", 
		"... 뭘까요? 뭔진 몰라도 무슨 일이 있었던 것 같습니다.", -- 31: 아파트 잔해 끝 (to 32)
		"잠시 쉬었다가 다시 고개를 들어보면, 어째 선생님보다는 필요가 없는 정보만 머리에 담고 온 듯한 기분입니다.", -- 32: 공통
		"선생님은 숲 밖의 이런 상황들을 다 알고 계셨던 걸까요?", 
		"역시 잘 모르겠네...... 왜 이런 얘기를 선생님은 내게 안 알려주셨던 걸까?", -- 34: evy
		"선생님의 의도를 잘 모르겠어.", 
		"많은 건물 잔해를 지나쳐 도착한 곳에는 표지판이 하나 있습니다.", -- 36: 나레이션
		"[정부 공인 대-안드로이드 연구소]", 
		"저런 곳에 선생님이 계시긴 할까요? 물론 선생님께선 혼자 계실 적에 기름 냄새와 연장을 들고 돌아오셨긴 했지요.", 
		"어쩌면 선생님이 저 무너진 연구소에서 물품을 갖고 오시는 걸지도 모르겠어요.", 
		"아무래도 행선지는 정해진 듯합니다.", 
		"다시 길을 떠나보도록 해요.", 
		"과연 성과가 있을지는 모르겠지만요."
		-- "[정보 공인 대-안드로이드 연구소]가 있던 자리로 겨우겨우 발걸음을 하면, 그 위치엔 거대한 잔해가 가득합니다.", -- 43: 연구소 파트 시작
		-- "규모가 큰 시설이었으나 대부분 무너진 듯해요. 그래도 아주 작은 건물 하나는 남아있는 듯합니다.", -- 44 (options5)
		-- "잔해를 피해 조심조심 작은 건물로 다가가보면, 너덜너덜한 문짝이 겨우 붙어있다는 것을 알아차릴 수 있습니다.", --45
		-- "문을 기울여 열어젖히니... 아, 긴 복도 끝에 탕비실이라 적힌 푯말이 보입니다. 누가 봐도 좁아터진 방이에요.", --46
		-- "연구소로 들어가지 않고, 그 주위를 배회하기로 마음을 먹습니다.", -- 47
		-- "비좁습니다. 먼지 가득한 탕비실이에요. 나무 탁자는 다리 넷이 모두 부러졌고, 커피와 차를 보관하고 있던 곳에선 옅은 악취가 풍겨옵니다.", -- 48: 탕비실 시작(options6)
		-- "흙먼지가 나풀댑니다. 시멘트 조각과 케케묵은 냄새가 가득합니다. 그 위를 벌레가 슬슬 지나갑니다.", -- 49
		-- "벌레가 지나간 곳 아래에는 종이 하나가 놓여있습니다.", 
		-- "종이는 낡았지만, 모두 오래되어 상한 장소에서 서류만큼은 최근의 것이라 생각하기 족할 정도로 멀쩡합니다.", 
		-- "최근에 누군가가 이곳에 와서 두고 간 것일지도 모르겠어요.", 
		-- "종이를 흘겨보니 그 위엔 안드로이드에 관한 내용으로 가득하다는 사실을 알 수 있습니다. 출력물인 듯해요.", -- 53 (options7)
		-- "안드로이드 신체 구조에 관한 내용이 적혀있다. 가정용 모델을 주로 적은 듯한데, 체내에 정수 기능과 공기 청정 기능이 있다는 내용인 듯하다.", -- 54
		-- "그 아래에는 연구소의 과거에 대한 이야기가 있는데, 적자가 나서 망했다는 문장만 가득하다.", -- 55 (options8)
 	-- 	"이 거대한 잔해들 사이에서 터벅터벅 발소리를 내며 걸어보니, 많은 종이들이 찢겨 나풀댄다는 사실을 마주할 수 있었습니다.", -- 56
 	-- 	"무너진 콘트리트 위에는 연구, 안드로이드, 개발, 멸망의 전조... 어딘가 석연찮은 단어가 가득한 자료만이 가득합니다.", 
 	-- 	"걷고, 또 걷습니다.", 
 	-- 	"선생님의 흔적을 찾고자 연구소에 오게 된 건데, 어째 이런 세상이 다가온 이유만을 알아버린 듯합니다.", 
 	-- 	"미약한 허탈함을 품고 계속해서 걸어갑니다.", 
 	-- 	"...... 오두막으로 다시 돌아가는 게 좋겠죠. 더 나아가다가는 돌아갈 길을 잃어버릴지도 모르겠어요."
 	}

 	local options1 = {
 		"[형체를 알아보기 어려운 '숲 서점']으로 들어간다.", 
 		"[다 무너진 아파트 잔해]로 걸어간다.", 
		"[돌무덤 가득한 옛 번화가]로 다가간다."
 	}

 	local options2 = {
 		"[잡지]를 펼쳐본다."
 	}

	local options3 = {
 		"[침대] 위에 누워본다.", 
 		"[침대]를 뒤적여본다."
 	}

 	local options4 = {
 		"[그나마 온전한 이름 모를 가게]로 들어가본다.", 
 		"[번화가]의 중심으로 나아간다."
 	}

    local curScript = {}
    local curScriptGroup = display.newGroup() --대사배열그룹 작성 추가
    local curScriptNum = 0
 	for i = 1, #scripts, 1 do
 		curScript[i] = display.newText(curScriptGroup, scripts[i], display.contentCenterX, display.contentCenterY*1.6, 1000, 0, "fonts/GowunBatang-Bold.ttf", 27)
		curScript[i].alpha = 0
	end
	sceneGroup:insert(curScriptGroup)

	function nextScript(event) --local 빼기 수정
		print(#scripts)
		print("curScriptNum: ", curScriptNum)
		-- 선택지로 이동
		if curScriptNum == 2 then
			composer.setVariable("options", options1)
			composer.showOverlay("choiceScene", overlayOption)
		elseif curScriptNum == 4 then
			composer.setVariable("options", options2)
			composer.showOverlay("choiceScene", overlayOption)
		elseif curScriptNum == 9 then
			composer.setVariable("options", options3)
			composer.showOverlay("choiceScene", overlayOption)
		elseif curScriptNum == 22 then
			composer.setVariable("options", options4)
			composer.showOverlay("choiceScene", overlayOption)
		elseif curScriptNum < #scripts then
			if curScriptNum ~= 0 then
				curScript[curScriptNum].alpha = 0
			end

			-- 선택지 끝나서 공통으로 모임
			if curScriptNum == 6 or curScriptNum == 16 or curScriptNum == 31 then
				curScriptNum = 32
			-- 디폴트
			else
				curScriptNum = curScriptNum + 1
			end

			curScript[curScriptNum].alpha = 1

			-- 캐릭터 변화
			if curScriptNum == 34 then
				nameGroup.isVisible = true
				player.isVisible = true
			end
			if curScriptNum == 36 then
				nameGroup.isVisible = false
				player.isVisible = false
			end
		end
	end

	dialogueBox:addEventListener("tap", nextScript) --dialogueBoxGroup -> dialogueBox 수정

	function scene:resumeGame()
		if curScriptNum == 2 then
			local selectedOption = composer.getVariable("selectedOption")
			print(selectedOption)
			curScript[curScriptNum].alpha = 0
			if selectedOption == 1 then
				curScriptNum = 3
				-- 서점으로 배경 변화?
			elseif selectedOption == 2 then
				curScriptNum = 7
				-- 아파트 잔해로 배경 변화?
			elseif selectedOption == 3 then
				curScriptNum = 17
				-- 번화가로 배경 변화?
			end
			-- player.isVisible = true
		elseif curScriptNum == 9 then
			local selectedOption = composer.getVariable("selectedOption")
			print(selectedOption)
			curScript[curScriptNum].alpha = 0
			if selectedOption == 1 then
				curScriptNum = 10
			elseif selectedOption == 2 then
				curScriptNum = 13
			end
		elseif curScriptNum == 22 then
			local selectedOption = composer.getVariable("selectedOption")
			print(selectedOption)
			curScript[curScriptNum].alpha = 0
			if selectedOption == 1 then
				curScriptNum = 23
			elseif selectedOption == 2 then
				curScriptNum = 28
			end
		elseif curScriptNum == 4 then
			curScript[curScriptNum].alpha = 0
			curScriptNum = curScriptNum + 1
		end

		print("curScriptNum: ", curScriptNum)
		curScript[curScriptNum].alpha = 1
	end

	--메뉴의 시작화면으로 버튼 클릭시 현재 장면 닫고 타이틀화면으로 이동 (추가)--
	function scene:closeScene()
		sceneGroup:insert(background)
		sceneGroup:insert(player)
		sceneGroup:insert(dialogueBoxGroup)
		sceneGroup:insert(menuButton)
		sceneGroup:insert(curScriptGroup)
		sceneGroup:insert(nameGroup)
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
		print("ruins_2 show")
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
		composer.removeScene("story_ruins_2")
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
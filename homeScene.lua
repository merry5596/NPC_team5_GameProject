-----------------------------------------------------------------------------------------
--
-- homeScene.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
  
-------------------유저 정보 로드 및 저장---------------------------------------------------------------------------------
	local loadsave = require( "loadsave" )
	local userSettings = loadsave.loadTable("userSettings.json")

	local presentLevel = userSettings.presentLevel
	local presentEXP = userSettings.presentEXP
	local itemList = userSettings.itemList

	userSettings.presentScene = "homeScene"
-------------------퀘스트 정보 로드---------------------------------------------------------------------------------

	local questNum = userSettings.questInfo.questNum
	local questName = userSettings.questInfo.questName 
	local maxJewerlyNum = userSettings.questInfo.maxJewerlyNum
	local targetLevel = userSettings.questInfo.targetLevel
	local areaName = userSettings.questInfo.areaName
	local backgroundImage = userSettings.questInfo.backgroundImage

------------------------------------------------------------------------------------------------------------------
	
	-- 임시 배경 --
	local background = display.newImageRect(backgroundImage, display.contentWidth, display.contentHeight)
	background.x, background.y = display.contentWidth*0.5, display.contentHeight*0.5
	sceneGroup:insert(background)

	--임시 배경2--
	-- local background1 = display.newImage("image/background/outside_cabin.png", display.contentWidth, display.contentHeight)
	-- background1.x, background1.y = display.contentCenterX, display.contentCenterY
	-- background1:toBack()

	--플레이어 그림--
	local evy = display.newImage("image/component/evy.png")
	evy.x, evy.y = display.contentWidth*0.5, display.contentHeight*0.6
	sceneGroup:insert(evy)

	--메뉴 버튼 그림--
	local menuButton = display.newImage("image/component/menu_button.png")
   	menuButton.x, menuButton.y = display.contentWidth*0.92, display.contentHeight*0.1
	sceneGroup:insert(menuButton)

	--레벨 박스 그림--
	local level = display.newImage("image/component/level.png")
   	level.x, level.y = display.contentWidth*0.095, display.contentHeight*0.115
	sceneGroup:insert(level)

	local showLevel = display.newText(presentLevel, display.contentWidth*0.116, display.contentHeight*0.115, "fonts/BlackHanSans-Regular.ttf", 33)
	showLevel:setFillColor(1)
	sceneGroup:insert(showLevel)

	--지역이름 박스 그림--
	local area = display.newImage("image/component/area.png")
	area.x, area.y = display.contentWidth*0.31, display.contentHeight*0.115
	-- sceneGroup:insert(area)

	local showArea = display.newText(areaName, display.contentWidth*0.31, display.contentHeight*0.1, "fonts/BlackHanSans-Regular.ttf", 33)
	showArea:setFillColor(1)
	-- sceneGroup:insert(showArea)

	local showQuest = display.newText(questName, display.contentWidth*0.31, display.contentHeight*0.15, "fonts/GowunBatang-Bold.ttf", 20)
	showQuest:setFillColor(1)
	-- sceneGroup:insert(showQuest)

	local areaQuestGroup = display.newGroup()
	areaQuestGroup:insert(area)
	areaQuestGroup:insert(showArea)
	areaQuestGroup:insert(showQuest)
	sceneGroup:insert(areaQuestGroup)

	--경험치바 그림--
	local EXPBar = {"", "", "", "", "", ""}
	local EXPBarGroup = display.newGroup()

	EXPBar[1] = display.newImage(EXPBarGroup, "image/component/경험치바_0.png") --0%
	EXPBar[2] = display.newImage(EXPBarGroup, "image/component/경험치바_20.png") --20%
	EXPBar[3] = display.newImage(EXPBarGroup, "image/component/경험치바_40.png") --40%
	EXPBar[4] = display.newImage(EXPBarGroup, "image/component/경험치바_60.png") --60%
	EXPBar[5] = display.newImage(EXPBarGroup, "image/component/경험치바_80.png") --80%
	EXPBar[6] = display.newImage(EXPBarGroup, "image/component/경험치바_100.png") --100%

	for i = 1, #EXPBar do
		EXPBar[i].x, EXPBar[i].y = level.x, level.y + 30
		EXPBar[i]:scale(0.23, 0.25)
		EXPBar[i].alpha = 0
	end
	EXPBar[1].alpha = 1
	sceneGroup:insert(EXPBarGroup)
  
	--가방 그림--
	local bag = display.newImage("image/component/bag.png")
	bag.x, bag.y = display.contentWidth*0.07, display.contentHeight*0.275
	sceneGroup:insert(bag)

	--상자 클릭시 열리는 인벤토리 박스 그림--
	local inventoryBox = display.newImage("image/component/inventory_box.png")
	inventoryBox.x, inventoryBox.y = display.contentWidth*0.365, display.contentHeight*0.58
	inventoryBox.isVisible = false
	-- sceneGroup:insert(inventoryBox)

	--인벤토리 박스 속 스크롤바 그림--
	local scrollbar = display.newImage("image/component/inventory_scroll.png")
	scrollbar.x, scrollbar.y = display.contentWidth*0.6736, display.contentHeight*0.35
	scrollbar.isVisible = false
	-- sceneGroup:insert(scrollbar)

	--???--
	local function fitImage( displayObject, fitWidth, fitHeight, enlarge )
		--
		-- first determine which edge is out of bounds
		--
		local scaleFactor = fitHeight / displayObject.height 
		local newWidth = displayObject.width * scaleFactor
		if newWidth > fitWidth then
			scaleFactor = fitWidth / displayObject.width 
		end
		if not enlarge and scaleFactor > 1 then
			return
		end
		displayObject:scale( scaleFactor, scaleFactor )
	end

	--인벤토리 박스 닫기버튼 그림--
	local closeButton = display.newImage("image/component/menu_close.png")
	fitImage( closeButton, 50, 50, true )
	closeButton.x, closeButton.y = display.contentWidth*0.6736, display.contentHeight*0.24
	closeButton.isVisible = false
	-- sceneGroup:insert(closeButton)

	--아이템 보석 그림--
	local jewerly = {"", "", "", "", ""}
	local jewerlyGroup = display.newGroup()
	local jewerlyEXP = {10, 20, 40, 80, 160} --보석별 주는 경험치 배열

	jewerly[1] = display.newImage(jewerlyGroup, "image/component/보석_빨.png") --루비
	jewerly[2] = display.newImage(jewerlyGroup, "image/component/보석_노.png") --호박
	jewerly[3] = display.newImage(jewerlyGroup, "image/component/보석_초.png") --에메랄드
	jewerly[4] = display.newImage(jewerlyGroup, "image/component/보석_파.png") --사파이어
	jewerly[5] = display.newImage(jewerlyGroup, "image/component/보석_흰.png") --다이아몬드
	for i = 1, #jewerly do
		jewerly[i]:scale(0.5, 0.5)
		jewerly[i].alpha = 0
	end
	sceneGroup:insert(jewerlyGroup)

	--인벤토리 박스 그룹 (보석이 인벤토리상자 뒤로 위치됨)--
	local inventoryGroup = display.newGroup()
	inventoryGroup:insert(inventoryBox)
	inventoryGroup:insert(scrollbar)
	inventoryGroup:insert(closeButton)
	sceneGroup:insert(inventoryGroup)

	--아이템 보석 개수 변수--
	jewerly1Num = 0
	jewerly2Num = 0
	jewerly3Num = 0
	jewerly4Num = 0
	jewerly5Num = 0

	-- 소지품 열기
	local bounds_bag = bag.contentBounds
	local isOut_bag
  	local function openBag(event)
  		if event.phase == "began" then
  			isOut_bag = 0 	-- 이벤트 시작 시에는 이벤트가 버튼 안에 있음 (초기값)

  			display.getCurrentStage():setFocus( event.target )
    	    self.isFocus = true
    	    
    	    bag:scale(0.9, 0.9) 	-- 버튼 작아짐
    	elseif self.isFocus then
    		if event.phase == "moved" then
    			-- 1. 이벤트가 버튼 밖에 있지만 isOut_bag == 0인 경우(방금까지 안에 있었을 경우)에만 수행 (처음 밖으로 나갈 때 한 번 수행)
    			if (event.x < bounds_bag.xMin or event.x > bounds_bag.xMax or event.y < bounds_bag.yMin or event.y > bounds_bag.yMax) and isOut_bag == 0 then
    				bag:scale(1.1, 1.1)	-- 버튼 커짐
    				isOut_bag = 1 	-- 이벤트가 버튼 밖에 있음을 상태로 저장

    			-- 2. 이벤트가 버튼 안에 있지만 isOut_bag == 1인 경우(방금까지 밖에 있었을 경우)에만 수행 (처음 안으로 들어올 때 한 번 수행)
    			elseif (event.x >= bounds_bag.xMin and event.x <= bounds_bag.xMax and event.y >= bounds_bag.yMin and event.y <= bounds_bag.yMax) and isOut_bag == 1 then
    				bag:scale(0.9, 0.9) 	-- 버튼 작아짐
    				isOut_bag = 0 	-- 이벤트가 버튼 안에 있음을 상태로 저장
    			end
	        elseif event.phase == "ended" or event.phase == "cancelled" then
	            display.getCurrentStage():setFocus( nil )
	            self.isFocus = false

	        	-- 버튼 안에서 손을 뗐을 시에만 메뉴 실행
  				if event.x >= bounds_bag.xMin and event.x <= bounds_bag.xMax and event.y >= bounds_bag.yMin and event.y <= bounds_bag.yMax then
		        	bag:scale(1.1, 1.1)
		        	-- 여기부터가 실질적인 action에 해당
		        	inventoryBox.isVisible = true
					scrollbar.isVisible = true
					closeButton.isVisible = true
				end

				--인벤토리 내 아이템 보석 그림--
				--루비--
				jewerly1 = display.newImageRect("image/component/보석_빨.png", 80, 80)
				jewerly1.x, jewerly1.y = inventoryBox.x - 340, inventoryBox.y - 160
				-- sceneGroup:insert(jewerly1)
				--호박--
				jewerly2 = display.newImageRect("image/component/보석_노.png", 80, 80)
				jewerly2.x, jewerly2.y = inventoryBox.x - 340, inventoryBox.y - 70
				-- sceneGroup:insert(jewerly2)
				--에메랄드--
				jewerly3 = display.newImageRect("image/component/보석_초.png", 80, 80)
				jewerly3.x, jewerly3.y = inventoryBox.x - 340, inventoryBox.y + 20
				-- sceneGroup:insert(jewerly3)
				--사파이어--
				jewerly4 = display.newImageRect("image/component/보석_파.png", 80, 80)
				jewerly4.x, jewerly4.y = inventoryBox.x - 340, inventoryBox.y + 110
				-- sceneGroup:insert(jewerly4)
				--다이아몬드--
				jewerly5 = display.newImageRect("image/component/보석_흰.png", 80, 80)
				jewerly5.x, jewerly5.y = inventoryBox.x - 340, inventoryBox.y + 200
				-- sceneGroup:insert(jewerly5)

				--인벤토리 내 아이템 보석 설명--
				jewerly1Explain = display.newText("곱게 붉은 작은 루비. 손톱보다 작아서 그런 건지, 들고 다니기\n아주 간편합니다.", 
					inventoryBox.x + 90, inventoryBox.y - 160, "fonts/GowunBatang-Bold.ttf", 20)
				jewerly2Explain = display.newText("은은한 색채를 내뿜는 호박. 알찬 아름다움이 녹아들어 있습\n니다. 손톱보다는 조금 큼지막해요.", 
					inventoryBox.x + 85, inventoryBox.y - 70, "fonts/GowunBatang-Bold.ttf", 20)
				jewerly3Explain = display.newText("맑은 녹빛이 화려게 빛납니다. 꽤 묵직한 걸로 보아, 손가락 하\n나 정도의 크기인 듯합니다.", 
					inventoryBox.x + 91, inventoryBox.y + 17, "fonts/GowunBatang-Bold.ttf", 20)
				jewerly4Explain = display.newText("청명한 여름 하늘을 모아 담은 듯한 보석. 손바닥과 얼추 비\n슷한 면적입니다.", 
					inventoryBox.x + 85, inventoryBox.y + 106, "fonts/GowunBatang-Bold.ttf", 20)
				jewerly5Explain = display.newText("투명하게 반짝이는 다이아몬드. 크기도 큼직해서 그런 걸까요,\n탐스럽기 그지 없습니다.", 
					inventoryBox.x + 93, inventoryBox.y + 196, "fonts/GowunBatang-Bold.ttf", 20)
				-- sceneGroup:insert(jewerly1Explain)
				-- sceneGroup:insert(jewerly2Explain)
				-- sceneGroup:insert(jewerly3Explain)
				-- sceneGroup:insert(jewerly4Explain)
				-- sceneGroup:insert(jewerly5Explain)

				--인벤토리 내 아이템 개수--
				jewerly1ShowNum = display.newText("X " .. jewerly1Num, inventoryBox.x - 245, inventoryBox.y - 163, "fonts/GowunBatang-Bold.ttf", 40)
				jewerly2ShowNum = display.newText("X " .. jewerly2Num, inventoryBox.x - 245, inventoryBox.y - 73, "fonts/GowunBatang-Bold.ttf", 40)
				jewerly3ShowNum = display.newText("X " .. jewerly3Num, inventoryBox.x - 245, inventoryBox.y + 17, "fonts/GowunBatang-Bold.ttf", 40)
				jewerly4ShowNum = display.newText("X " .. jewerly4Num, inventoryBox.x - 245, inventoryBox.y + 108, "fonts/GowunBatang-Bold.ttf", 40)
				jewerly5ShowNum = display.newText("X " .. jewerly5Num, inventoryBox.x - 245, inventoryBox.y + 199, "fonts/GowunBatang-Bold.ttf", 40)
				-- sceneGroup:insert(jewerly1ShowNum)
				-- sceneGroup:insert(jewerly2ShowNum)
				-- sceneGroup:insert(jewerly3ShowNum)
				-- sceneGroup:insert(jewerly4ShowNum)
				-- sceneGroup:insert(jewerly5ShowNum)
			end
	    end
  	end
	bag:addEventListener("touch", openBag)

	--인벤토리상자 클릭시 아래 보석 클릭 금지 함수--
	local function inBag(event)
		return true
	end
	inventoryGroup:addEventListener("tap", inBag)

	-- 소지품 닫기
	local bounds_close = closeButton.contentBounds
	local isOut_close
  	local function closeBag(event)
  		if event.phase == "began" then
  			isOut_close = 0 	-- 이벤트 시작 시에는 이벤트가 버튼 안에 있음 (초기값)

  			display.getCurrentStage():setFocus( event.target )
    	    self.isFocus = true
    	    
    	    closeButton:scale(0.9, 0.9) 	-- 버튼 작아짐

    	    jewerly1.isVisible = false --인벤토리 내 아이템 보석 사라짐
    	    jewerly2.isVisible = false
    	    jewerly3.isVisible = false
    	    jewerly4.isVisible = false
    	    jewerly5.isVisible = false

    	    jewerly1Explain.isVisible = false --인벤토리 내 아이템 보석 설명 사라짐
    	    jewerly2Explain.isVisible = false
    	    jewerly3Explain.isVisible = false
    	    jewerly4Explain.isVisible = false
    	    jewerly5Explain.isVisible = false

    	    jewerly1ShowNum.isVisible = false --인벤토리 내 아이템 보석 개수 사라짐
    	    jewerly2ShowNum.isVisible = false
    	    jewerly3ShowNum.isVisible = false
    	    jewerly4ShowNum.isVisible = false
    	    jewerly5ShowNum.isVisible = false
    	elseif self.isFocus then
    		if event.phase == "moved" then
    			-- 1. 이벤트가 버튼 밖에 있지만 isOut_close == 0인 경우(방금까지 안에 있었을 경우)에만 수행 (처음 밖으로 나갈 때 한 번 수행)
    			if (event.x < bounds_close.xMin or event.x > bounds_close.xMax or event.y < bounds_close.yMin or event.y > bounds_close.yMax) and isOut_close == 0 then
    				closeButton:scale(1.1, 1.1)	-- 버튼 커짐
    				isOut_close = 1 	-- 이벤트가 버튼 밖에 있음을 상태로 저장

    			-- 2. 이벤트가 버튼 안에 있지만 isOut_close == 1인 경우(방금까지 밖에 있었을 경우)에만 수행 (처음 안으로 들어올 때 한 번 수행)
    			elseif (event.x >= bounds_close.xMin and event.x <= bounds_close.xMax and event.y >= bounds_close.yMin and event.y <= bounds_close.yMax) and isOut_close == 1 then
    				closeButton:scale(0.9, 0.9) 	-- 버튼 작아짐
    				isOut_close = 0 	-- 이벤트가 버튼 안에 있음을 상태로 저장
    			end
	        elseif event.phase == "ended" or event.phase == "cancelled" then
	            display.getCurrentStage():setFocus( nil )
	            self.isFocus = false

	        	-- 버튼 안에서 손을 뗐을 시에만 메뉴 실행
  				if event.x >= bounds_close.xMin and event.x <= bounds_close.xMax and event.y >= bounds_close.yMin and event.y <= bounds_close.yMax then
		        	closeButton:scale(1.1, 1.1)
		        	-- 여기부터가 실질적인 action에 해당
		        	inventoryBox.isVisible = false
					scrollbar.isVisible = false
					closeButton.isVisible = falses
				end
			end
	    end	
  	end
	closeButton:addEventListener("touch", closeBag)

	local overlayOption =
	{
	    isModal = true
	}
----------------------------------------------------------------------------------


	local function levelUp(event) --임시 레벨업 함수
	   	presentLevel = presentLevel + 1
    	print("levelup: ", presentLevel)
    	showLevel.text = presentLevel
	end

	local loadOption =
	{
	    effect = "fade",
	    time = 400,
	}

	if presentLevel < targetLevel then
		--보석 종류 구분 함수--
		local function findJewerlyNum(timerParams)
			local num
			if timerParams == "j1" then
				num = 1
			elseif timerParams == "j2" then
				num = 2
			elseif timerParams == "j3" then
				num = 3
			elseif timerParams == "j4" then
				num = 4
			elseif timerParams == "j5" then
				num = 5
			end

			return num
		end

		--보석 등장 타이머 종료 함수 (추가)--
		function jewerlyAppearStop()
			if maxJewerlyNum >= 1 then
				timer.cancel(timer1)
				if maxJewerlyNum >= 2 then
					timer.cancel(timer2)
					if maxJewerlyNum >= 3 then
						timer.cancel(timer3)
						if maxJewerlyNum >= 4 then
							timer.cancel(timer4)
							if maxJewerlyNum == 5 then
								timer.cancel(timer5)
							end
						end
					end
				end
			end
		end

			
		--보석 등장 함수--
		local function jewerlyfadeInOut(event)
			local timerParams = event.source.params.params
			local i = findJewerlyNum(timerParams)
			-- print("i", i)

			if jewerly[i].alpha == 0 then
				jewerly[i].x, jewerly[i].y = display.contentCenterX + math.random(-450, 550),  
					display.contentCenterY + math.random(-200, 300)
				if jewerly[i].x > evy.x - 130 and jewerly[i].x < evy.x + 130 then
					jewerly[i].x = jewerly[i].x + 200
				end
				transition.fadeIn(jewerly[i], { time = 1000 })
			end

			print("타겟레벨", targetLevel)
			if presentLevel >= targetLevel then --타겟레벨 넘으면 보석 등장 종료
				jewerlyAppearStop() --타켓레벨 달성시 보석 등장 멈춤
			end
		end

		-- local presentEXP = 0 --현재 경험치 양
		local increaseEXP = jewerly1Num * 10 + jewerly2Num * 20 + jewerly3Num * 40
		 + jewerly4Num * 80 + jewerly5Num * 160 --초당 증가하는 경험치 양

		--보석 클릭해서 획득--
		local function jewerlyClick_1(event)
			transition.fadeOut(jewerly[1], { time = 100 })
			jewerly1Num = jewerly1Num + 1
			presentEXP = presentEXP + jewerlyEXP[1]
			increaseEXP = increaseEXP + jewerlyEXP[1]
			-- 저장
		    userSettings.itemList[1] = jewerly1Num
		end
		jewerly[1]:addEventListener("tap", jewerlyClick_1)
		local function jewerlyClick_2(event)
			transition.fadeOut(jewerly[2], { time = 100 })
			jewerly2Num = jewerly2Num + 1
			presentEXP = presentEXP + jewerlyEXP[2]
			increaseEXP = increaseEXP + jewerlyEXP[2]
			-- 저장
		    userSettings.itemList[2] = jewerly2Num
		end
		jewerly[2]:addEventListener("tap", jewerlyClick_2)
		local function jewerlyClick_3(event)
			transition.fadeOut(jewerly[3], { time = 100 })
			jewerly3Num = jewerly3Num + 1
			presentEXP = presentEXP + jewerlyEXP[3]
			increaseEXP = increaseEXP + jewerlyEXP[3]
			-- 저장
		    userSettings.itemList[3] = jewerly3Num
		end
		jewerly[3]:addEventListener("tap", jewerlyClick_3)
		local function jewerlyClick_4(event)
			transition.fadeOut(jewerly[4], { time = 100 })
			jewerly4Num = jewerly4Num + 1
			presentEXP = presentEXP + jewerlyEXP[4]
			increaseEXP = increaseEXP + jewerlyEXP[4]
			-- 저장
		    userSettings.itemList[4] = jewerly4Num
		end
		jewerly[4]:addEventListener("tap", jewerlyClick_4)
		local function jewerlyClick_5(event)
			transition.fadeOut(jewerly[5], { time = 100 })
			jewerly5Num = jewerly5Num + 1
			presentEXP = presentEXP + jewerlyEXP[5]
			increaseEXP = increaseEXP + jewerlyEXP[5]
			-- 저장
		    userSettings.itemList[5] = jewerly5Num
		end
		jewerly[5]:addEventListener("tap", jewerlyClick_5)

		--현재레벨에 따른 타켓경험치 제시 함수--
		local targetEXP
	 	-- 2~7레벨은 700으로,
		-- 8~30레벨은 1,200으로,
		-- 31~68레벨은 3,600으로,
		-- 69~118레벨은 12,180으로,
		-- 119~168레벨은 36,084으로,
		-- 169~252레벨은 59,300으로
		local function setTargetEXP()
		    if presentLevel < 7 then
		    	targetEXP = 700
		    elseif presentLevel < 30 then
		    	targetEXP = 1200
		    elseif presentLevel < 68 then
		    	targetEXP = 3600
		    elseif presentLevel < 118 then
		    	targetEXP = 12180
		    elseif presentLevel < 168 then
		    	targetEXP = 36084
		    elseif presentLevel < 252 then
		    	targetEXP = 59300
		    end
		end

		--경험치 자동증가 함수--
		local function autoEXPUp(event)

			print("현재레벨, 타켓경험치", presentLevel, targetEXP)

			if targetEXP == nil then
				setTargetEXP()
			end
			presentEXP = presentEXP + increaseEXP
			print("autoPresentEXP", presentEXP)
			print("autoIncreaseEXP", increaseEXP)

			--경험치바 변화--
			if presentEXP < targetEXP * 0.2 then
				EXPBar[6].alpha = 0
				EXPBar[1].alpha = 1
			elseif presentEXP < targetEXP * 0.4 then
				EXPBar[1].alpha = 0
				EXPBar[2].alpha = 1
			elseif presentEXP < targetEXP * 0.6 then
				EXPBar[2].alpha = 0
				EXPBar[3].alpha = 1
			elseif presentEXP < targetEXP * 0.8 then
				EXPBar[3].alpha = 0
				EXPBar[4].alpha = 1
			elseif presentEXP < targetEXP then
				EXPBar[4].alpha = 0
				EXPBar[5].alpha = 1
			elseif presentEXP >= targetEXP then
				EXPBar[5].alpha = 0
				EXPBar[6].alpha = 1
			end

		    if presentEXP >= targetEXP then
		    	levelUp()
		    	presentEXP = presentEXP - targetEXP
		    end

		    -- 저장
		    userSettings.presentLevel = presentLevel
			userSettings.presentEXP = presentEXP

			loadsave.saveTable(userSettings, "userSettings.json")

			if presentLevel >= targetLevel then
				EXPBar[6].alpha = 0
				EXPBar[1].alpha = 1
				timer.cancel(timerEXP)
				jewerlyAppearStop() --이동시 보석 등장 중지
				composer.setVariable("questNum", questNum)
				-- composer.removeScene("homeScene", true)
      	 		composer.gotoScene("quest_clear", loadOption)
			end
		end
		timerEXP = timer.performWithDelay(1000, autoEXPUp, 0)

		--보석 등장 메인 부분--
		timer1 = timer.performWithDelay(5000, jewerlyfadeInOut, 0)
		timer1.params = { params = "j1" }
		if maxJewerlyNum >= 2 then
			timer2 = timer.performWithDelay(10000, jewerlyfadeInOut, 0)
			timer2.params = { params = "j2" }
			if maxJewerlyNum >= 3 then
				timer3 = timer.performWithDelay(16000, jewerlyfadeInOut, 0)
				timer3.params = { params = "j3" }
				if maxJewerlyNum >= 4 then
					timer4 = timer.performWithDelay(25000, jewerlyfadeInOut, 0)
					timer4.params = { params = "j4" }
					if maxJewerlyNum == 5 then
						timer5 = timer.performWithDelay(47000, jewerlyfadeInOut, 0)
						timer5.params = { params = "j5" }
					end
				end
			end
		end
	end

-----------------------------------------------------------------------------------------

	--메뉴열기--	
	local bounds = menuButton.contentBounds
	local isOut
  	local function openMenu(event)
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
		  			composer.setVariable("scriptNum", 0)
		  			-- 변수로 수정...!
		  			composer.setVariable("userSettings", userSettings)
  					composer.showOverlay("menuScene", overlayOption)
				end	
			end
	    end	
  	end
  	menuButton:addEventListener("touch", openMenu)

  	--메뉴 시작화면으로 버튼 클릭시 장면 닫고 타이틀화면으로 이동--
	function scene:closeScene()
		timer.cancel(timerEXP) --이동시 경험치 자동증가 중지
		jewerlyAppearStop() --이동시 보석 등장 중지
		composer.removeScene("homeScene") --현재 장면 이름 넣기 ex)storyScene
		-- composer.gotoScene("scene1")
	end


	--composer.gotoScene("view2")
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
		-- timer.pause(timerEXP)
	elseif phase == "did" then
		-- Called when the scene is now off screen
		composer.removeScene("home")

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
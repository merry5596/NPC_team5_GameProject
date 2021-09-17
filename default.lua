local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
local sceneGroup = self.view

--배경--
local background = display.newImageRect("image/background/forest(봄).png", display.contentWidth, display.contentHeight)
background.x, background.y = display.contentWidth*0.5, display.contentHeight*0.5

--메뉴버튼--
local menuButton = display.newImage("image/component/menu_button.png")
menuButton.x, menuButton.y = display.contentWidth*0.92, display.contentHeight*0.1
sceneGroup:insert(menuButton)

--레벨--
local level = display.newImage("image/component/level.png")
level.x, level.y = display.contentWidth*0.095, display.contentHeight*0.115
sceneGroup:insert(level)

--레벨에 스코어 표시--
local score = 0 
local showScore = display.newText(score, display.contentWidth*0.12, display.contentWidth*0.065, "fonts/GowunBatang-Bold.ttf") 
showScore:setFillColor(1) 
showScore.size = 50

--호박 보석--
local yellowg = display.newImage("image/component/보석_노.png")
yellowg.x = display.contentCenterX-500
yellowg.y = display.contentCenterY+100

--루비 보석--
local redg = display.newImage("image/component/보석_빨.png")
redg.x = display.contentCenterX-250
redg.y = display.contentCenterY

--에메랄드 보석--
local greeng = display.newImage("image/component/보석_초.png")
greeng.x = display.contentCenterX
greeng.y = display.contentCenterY+100

--사파이어 보석--
local blueg = display.newImage("image/component/보석_파.png")
blueg.x = display.contentCenterX+250
blueg.y = display.contentCenterY

--다이아몬드 보석--
local whiteg = display.newImage("image/component/보석_흰.png")
whiteg.x = display.contentCenterX+500
whiteg.y = display.contentCenterY+100

--보석 설명 박스--
local box = display.newImageRect("image/component/area.png", 850, 150)
box.x, box.y = display.contentCenterX, display.contentCenterY
box.isVisible = false

--호박 보석 설명--
local yellow = display.newText("은은한 색채를 내뿜는 호박. 아름다움이 녹아들어 있습니다. 손톱 보다는 조금 큼지막해요.", display.contentCenterX, display.contentCenterY, "fonts/GowunBatang-Bold.ttf", 20)
yellow : setFillColor(1)
yellow.isVisible = false

--루비 보석 설명--
local red = display.newText("곱게 붉은 작은 루비. 손톱보다 작아서 그런 건지, 들고 다니기 아주 간편합니다.", display.contentCenterX, display.contentCenterY,"fonts/GowunBatang-Bold.ttf", 20)
red : setFillColor(1)
red.isVisible = false

--에메랄드 보석 설명--
local green = display.newText("맑은 녹빛이 화려게 빛납니다. 꽤 묵직한 걸로 보아, 손가락 하나 정도의 크기인 듯합니다.", display.contentCenterX, display.contentCenterY,"fonts/GowunBatang-Bold.ttf", 20)
green : setFillColor(1)
green.isVisible = false

--사파이어 보석 설명--
local blue = display.newText("청명한 여름 하늘을 모아 담은 듯한 보석. 손바닥과 얼추 비슷한 면적입니다.", display.contentCenterX, display.contentCenterY,"fonts/GowunBatang-Bold.ttf", 20)
blue : setFillColor(1)
blue.isVisible = false

--다이아몬드 보석 설명--
local white = display.newText("투명하게 반짝이는 다이아몬드. 크기도 큼직해서 그런 걸까요, 탐스럽기 그지 없습니다.", display.contentCenterX, display.contentCenterY,"fonts/GowunBatang-Bold.ttf", 20)
white : setFillColor(1)
white.isVisible = false

--설명창 닫는 방법 하단 문구--
local warning = display.newText("설명창 닫으려면 설명창을 클릭하세요.", display.contentCenterX, display.contentCenterY+250, "fonts/GowunBatang-Bold.ttf", 20)
warning:setFillColor(1)

--보석 선택 방법 하단 문구--
local warning_2 = display.newText("보석을 선택하려면 더블 클릭하세요.", display.contentCenterX, display.contentCenterY+300, "fonts/GowunBatang-Bold.ttf", 20)
warning_2:setFillColor(1)

--설명창 오픈--
local function boxOpen(event)
	box.isVisible = true
end

yellowg:addEventListener("mouse", boxOpen)
redg:addEventListener("mouse", boxOpen)
greeng:addEventListener("mouse", boxOpen)
blueg:addEventListener("mouse", boxOpen)
whiteg:addEventListener("mouse", boxOpen)

--호박 보석 설명창 열기--
local function openyellow(event)
	yellow.isVisible = true
	red.isVisible = false
	green.isVisible = false
	blue.isVisible = false
	white.isVisible = false
end

yellowg:addEventListener("mouse", openyellow)

--루비 보석 설명창 열기--
local function openred(event)
	red.isVisible = true
	yellow.isVisible = false
	green.isVisible = false
	blue.isVisible = false
	white.isVisible = false
end

redg:addEventListener("mouse", openred)

--에메랄드 보석 설명창 열기--
local function opengreen(event)
	green.isVisible = true
	red.isVisible = false
	yellow.isVisible = false
	blue.isVisible = false
	white.isVisible = false
end

greeng:addEventListener("mouse", opengreen)

--사파이어 보석 설명창 열기--
local function openblue(event)
	blue.isVisible = true
	yellow.isVisible = false
	red.isVisible = false
	green.isVisible = false
	white.isVisible = false
end

blueg:addEventListener("mouse", openblue)

--다이아몬드 보석 설명창 열기--
local function openwhite(event)
	white.isVisible = true
	yellow.isVisible = false
	red.isVisible = false
	green.isVisible = false
	blue.isVisible = false
end

whiteg:addEventListener("mouse", openwhite)

--설명창 닫기--
local function boxClose(event)
	box.isVisible = false 
	yellow.isVisible = false
	red.isVisible = false
	green.isVisible = false
	blue.isVisible = false
	white.isVisible = false
end

box:addEventListener("tap", boxClose)
yellow:addEventListener("tap", boxClose)
red:addEventListener("tap", boxClose)
green:addEventListener("tap", boxClose)
blue:addEventListener("tap", boxClose)
white:addEventListener("tap", boxClose)

--호박 보석 더블클릭시 레벨 2점 추가--
local function yellowtap(event)
	if ( event.numTaps == 2 ) then
		score = score + 2
		showScore.text = score
	end
end

yellowg:addEventListener("tap", yellowtap)

--루비 보석 더블클릭시 레벨 1점 추가--
local function redtap(event)
	if ( event.numTaps == 2) then
		score = score + 1
		showScore.text = score
	 end
end

redg:addEventListener("tap", redtap)

--에메랄드 보석 더블클릭시 레벨 3점 추가--
local function greentap(event)
	if ( event.numTaps == 2) then
		score = score + 3
		showScore.text = score
	 end
end

greeng:addEventListener("tap", greentap)

--사파이어 보석 더블클릭시 레벨 4점 추가--
local function bluetap(event)
	if ( event.numTaps == 2) then
		score = score + 4
		showScore.text = score
	 end
end

blueg:addEventListener("tap", bluetap)

--다이아몬드 보석 더블클릭시 레벨 5점 추가--
local function whitetap(event)
	if ( event.numTaps == 2) then
		score = score + 5
		showScore.text = score
	 end
end

whiteg:addEventListener("tap", whitetap)

local inventoryBox = display.newImage("image/component/inventory_box.png")
inventoryBox.x, inventoryBox.y = display.contentWidth*0.365, display.contentHeight*0.58
inventoryBox.isVisible = false
sceneGroup:insert(inventoryBox)

local scrollbar = display.newImage("image/component/inventory_scroll.png")
scrollbar.x, scrollbar.y = display.contentWidth*0.6736, display.contentHeight*0.35
scrollbar.isVisible = false
sceneGroup:insert(scrollbar)

local function fitImage( displayObject, fitWidth, fitHeight, enlarge )

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

local closeButton = display.newImage("image/component/menu_close.png")
fitImage( closeButton, 50, 50, true )
closeButton.x, closeButton.y = display.contentWidth*0.6736, display.contentHeight*0.24
closeButton.isVisible = false
sceneGroup:insert(closeButton)

--메뉴열기--
local function menuOpen(event)
  	if(event.phase == "began") then
  		composer.setVariable("sceneName", home)
  		composer.showOverlay("menuScene")
  	end
end
menuButton:addEventListener("touch", menuOpen)

--메뉴 시작화면으로 버튼 클릭시 장면 닫고 타이틀화면으로 이동--
function scene:closeScene()
	composer.removeScene("homeScene") --현재 장면 이름 넣기 ex)storyScene
	composer.gotoScene("scene1")
end

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
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

--호박--
local yellowg = display.newImageRect("image/component/보석_노.png", 100,100)
yellowg.x = display.contentCenterX-500
yellowg.y = display.contentCenterY

--루비--
local redg = display.newImageRect("image/component/보석_빨.png", 100, 100)
redg.x = display.contentCenterX-250
redg.y = display.contentCenterY-100

--에메랄드--
local greeng = display.newImageRect("image/component/보석_초.png", 100, 100)
greeng.x = display.contentCenterX
greeng.y = display.contentCenterY

--사파이어--
local blueg = display.newImageRect("image/component/보석_파.png", 100, 100)
blueg.x = display.contentCenterX+250
blueg.y = display.contentCenterY-100

--다이아몬드--
local whiteg = display.newImageRect("image/component/보석_흰.png", 100, 100)
whiteg.x = display.contentCenterX+500
whiteg.y = display.contentCenterY

--보석 선택 방법 하단 문구--
local warning_2 = display.newText("보석을 선택하려면 더블 클릭하세요.", display.contentCenterX-450, display.contentCenterY+320, "fonts/GowunBatang-Bold.ttf", 20)
warning_2:setFillColor(1)

--호박 더블클릭시 경험치 2--
local function yellowtap(event)
	if ( event.numTaps == 2 ) then
		display.newText("호박 선택! 경험치 2를 획득하였습니다.", display.contentCenterX, display.contentCenterY+200, "fonts/GowunBatang-Bold.ttf", 30)
	end
end

yellowg:addEventListener("tap", yellowtap)

--루비 더블클릭시 경험치 1--
local function redtap(event)
	if ( event.numTaps == 2) then
		display.newText("루비 선택! 경험치 1을 획득하였습니다.", display.contentCenterX, display.contentCenterY+200, "fonts/GowunBatang-Bold.ttf", 30)
	 end
end

redg:addEventListener("tap", redtap)

--에메랄드 더블클릭시 경험치 3--
local function greentap(event)
	if ( event.numTaps == 2) then
		display.newText("에메랄드 선택! 경험치 3을 획득하였습니다.", display.contentCenterX, display.contentCenterY+200, "fonts/GowunBatang-Bold.ttf", 30)
	 end
end

greeng:addEventListener("tap", greentap)

--사파이어 더블클릭시 경험치 4--
local function bluetap(event)
	if ( event.numTaps == 2) then
		display.newText("사파이어 선택! 경험치 4를 획득하였습니다.", display.contentCenterX, display.contentCenterY+200, "fonts/GowunBatang-Bold.ttf", 30)
	 end
end

blueg:addEventListener("tap", bluetap)

--다이아몬드 더블클릭시 경험치 5--
local function whitetap(event)
	if ( event.numTaps == 2) then
		display.newText("다이아몬드 선택! 경험치 5를 획득하였습니다.", display.contentCenterX, display.contentCenterY+200, "fonts/GowunBatang-Bold.ttf", 30)
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


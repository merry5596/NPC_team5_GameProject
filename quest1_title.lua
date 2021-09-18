local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
local sceneGroup = self.view

--배경--
local background = display.newImageRect("image/background/forest(봄).png", display.contentWidth, display.contentHeight)
background.x, background.y = display.contentWidth*0.5, display.contentHeight*0.5

local menuButton = display.newImage("image/component/menu_button.png")
menuButton.x, menuButton.y = display.contentWidth*0.92, display.contentHeight*0.1

-- 퀘스트 박스--
local quest1 = display.newImageRect("image/component/퀘스트제시.png", 700, 200)
quest1.x, quest1.y = display.contentCenterX, display.contentCenterY

--퀘스트 제목--
local title = display.newText("숲을 돌아다녀 보자", display.contentCenterX+150, display.contentCenterY,"fonts/GowunBatang-Bold.ttf", 30)

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

return scene
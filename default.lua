local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
local sceneGroup = self.view
	
-- 임시 배경 --
local background = display.newImageRect("image/background/forest(봄).png", display.contentWidth, display.contentHeight)
background.x, background.y = display.contentWidth*0.5, display.contentHeight*0.5
sceneGroup:insert(background)

--[[ --플레이어 그림--
local player = display.newImage("image/component/evy.png")
player.x, player.y = display.contentCenterX, display.contentCenterY*1.5
 ]]

--메뉴버튼 그림--
local menuButton = display.newImage("image/component/menu_button.png")
menuButton.x, menuButton.y = display.contentWidth*0.92, display.contentHeight*0.1
sceneGroup:insert(menuButton)

local level = display.newImage("image/component/level.png")
level.x, level.y = display.contentWidth*0.095, display.contentHeight*0.115
sceneGroup:insert(level)

local area = display.newImage("image/component/area.png")
area.x, area.y = display.contentWidth*0.31, display.contentHeight*0.115
sceneGroup:insert(area)

local money = display.newImage("image/component/money.png")
money.x, money.y = display.contentWidth*0.47, display.contentHeight*0.115
sceneGroup:insert(money)

local bag = display.newImage("image/component/bag.png")
bag.x, bag.y = display.contentWidth*0.07, display.contentHeight*0.275
sceneGroup:insert(bag)

local yellowg = display.newImage("image/component/보석_노.png")
yellowg.x = math.random(100,300)
yellowg.y = math.random(300,600)

local redg = display.newImage("image/component/보석_빨.png")
redg.x = math.random(300,500)
redg.y = math.random(300,600)

local greeng = display.newImage("image/component/보석_초.png")
greeng.x = math.random(500,700)
greeng.y = math.random(300,600)

local blueg = display.newImage("image/component/보석_파.png")
blueg.x = math.random(700,900)
blueg.y = math.random(300,600)

local whiteg = display.newImage("image/component/보석_흰.png")
whiteg.x = math.random(900,1100)
whiteg.y = math.random(300,600)





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

local function openBag(event)
	inventoryBox.isVisible = true
	scrollbar.isVisible = true
	closeButton.isVisible = true
end

bag:addEventListener("tap", openBag)

local function closeBag(event)
	inventoryBox.isVisible = false
	scrollbar.isVisible = false
	closeButton.isVisible = false
end

closeButton:addEventListener("tap", closeBag)

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
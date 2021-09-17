local composer = require( "composer" )
local scene = composer.newScene()

-- 배경 이미지 흰 바탕으로 대체
local background = display.newRect(display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight)
background:setFillColor(1)

local menuButton = display.newImage("image/component/menu_button.png")
menuButton.x, menuButton.y = display.contentWidth*0.92, display.contentHeight*0.1

-- 퀘스트 박스 이미지 area.png로 대체
local quest1 = display.newImageRect("image/component/area.png", 700, 200)
quest1.x, quest1.y = display.contentCenterX, display.contentCenterY

local title = display.newText("Quest6 : 무덤가에 피는 꽃", display.contentCenterX, display.contentCenterY,"fonts/GowunBatang-Bold.ttf", 30)




---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene
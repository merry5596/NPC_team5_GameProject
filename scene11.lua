local composer = require( "composer" )
local scene = composer.newScene()

-- 배경 이미지 흰 바탕으로 대체
local background = display.newRect(display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight)
background:setFillColor(1, 0.5) --반투명배경으로 수정

-- 정확히 어떤 장면인지 잘 모르겠어서 임의로 모양만 따라함

local b = display.newImage("image/component/area.png")
b.x, b.y = display.contentWidth/2, display.contentHeight/2-80

local c = display.newImage("image/component/area.png")
c.x, c.y = display.contentWidth/2, display.contentHeight/2+50

local d = display.newImage("image/component/area.png")
d.x, d.y = display.contentWidth/2, display.contentHeight/2+180

-- 메뉴 버튼을 뒤로가기 버튼으로 대체 예정
-- local menuButton = display.newImage("image/component/menu_button.png")
-- menuButton.x, menuButton.y = display.contentWidth*0.92, display.contentHeight*0.1


---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene
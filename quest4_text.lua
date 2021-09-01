local composer = require( "composer" )
local scene = composer.newScene()

-- 배경 이미지 흰 바탕으로 대체
local background = display.newRect(display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight)
background:setFillColor(1)

local menuButton = display.newImage("image/component/menu_button.png")
menuButton.x, menuButton.y = display.contentWidth*0.92, display.contentHeight*0.1

-- 퀘스트 박스 이미지 area.png로 대체
local quest1 = display.newImageRect("image/component/area.png", 850, 300)
quest1.x, quest1.y = display.contentCenterX, display.contentCenterY

local options = 
{
    text = "정말로 저곳에 선생님이 계실까?\n\n역시 잘 모르겠다만, 선생님은 늘 연장을 들고 계셨으니까.\n\n숲에서 나가기는 어려우셨을테니까 저 곳으로 가보자.\n\n늘 숲에서 찾기 어려운 물품을 갖고 계시지 않았나.",
    x = display.contentCenterX,
    y = display.contentCenterY,
    font = "fonts/GowunBatang-Bold.ttf",
    fontSize = 20,
    align = "center"
}

local myText = display.newText( options )
myText:setFillColor( 1 )

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene

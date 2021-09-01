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
    text = "선생님은 어디에 계신 걸까?\n\n맑은 하늘 아래를 쏘다니고, 수풀 속에 얼굴을 들이밀면 선생님을 찾을 수 있을지도 모른다.\n\n아이템을 터치하여 선생님을 찾기 위한 경험치를 획득하자.",
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


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
    text = "푸른 녹음은 어디로 사라진 걸까?\n\n이상하게도, 선생님과 머물던 그 숲만 화려한 색채를 유지하고 있었다.\n\n건물 잔해 가득한 곳에서 선생님의 발자취를 쫓을 수 있는 단서를 찾을 때까지 힘내보도록 하자.",
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

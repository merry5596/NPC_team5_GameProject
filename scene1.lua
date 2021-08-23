local composer = require( "composer" )
local scene = composer.newScene()

--배경 이미지 흰 바탕으로 대체
local background = display.newRect(display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight)
background:setFillColor(1)

--타이틀 이미지 텍스트로 대체
local Title = "이비의 모험 : 선생님을 찾아서"
local showTitle = display.newText(Title, display.contentWidth/2, display.contentHeight/2-50) 
showTitle:setFillColor(0) 
showTitle.size = 80

-- 불러오기 버튼
local load_button = display.newImageRect("image/component/menu_import.png", 350, 85)
load_button.x, load_button.y = display.contentWidth/2, display.contentHeight/2+150

-- 시작하기 버튼 불러오기 버튼으로 대체
local start_button = display.newImageRect("image/component/menu_import.png", 350, 85)
start_button.x, start_button.y = display.contentWidth/2, display.contentHeight/2+260



---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene






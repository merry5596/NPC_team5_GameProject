-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- show default status bar (iOS)
display.setStatusBar( display.DefaultStatusBar )

-- include Corona's "widget" library
local widget = require "widget"
local composer = require "composer"

-- event listeners for tab buttons:
local function onFirstView( event )
	composer.gotoScene( "story_forest2_2" )
end

local function onSecondView( event )
	composer.gotoScene( "story_ruins_3" )
end

onSecondView()	-- invoke first tab button's onPress event manually

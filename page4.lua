local composer = require("composer")
local scene = composer.newScene()

function scene:create(event)
    local sceneGroup = self.view

    local background = display.newRect(sceneGroup, display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight)
    background:setFillColor("#222B3C") 

    local pageText = display.newText(sceneGroup, "4", display.contentCenterX, display.contentCenterY + 420, native.systemFont, 60)
    pageText:setFillColor(1, 1, 1)  

    local nextButton = display.newImageRect(sceneGroup, "assets/botaãoproximo.png", 200, 80)
    nextButton.x = display.contentWidth - 150
    nextButton.y = display.contentHeight - 100
    nextButton:addEventListener("tap", function()
        composer.gotoScene("page5")
    end)

    
    local backButton = display.newImageRect(sceneGroup, "assets/botãoanterio.png", 200, 80)
    backButton.x = 150
    backButton.y = display.contentHeight - 100
    backButton:addEventListener("tap", function()
        composer.gotoScene("page3")
    end)
end

scene:addEventListener("create", scene)

return scene
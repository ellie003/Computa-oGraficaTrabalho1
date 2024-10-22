local composer = require("composer")
local scene = composer.newScene()

function scene:create(event)
    local sceneGroup = self.view

    local background = display.newRect(sceneGroup, display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight)
    background:setFillColor(0.9, 0.9, 0.9) 

    local pageText = display.newText(sceneGroup, "Página 3", display.contentCenterX, display.contentCenterY, native.systemFont, 36)
    pageText:setFillColor(0, 0, 0)  

    local nextButton = display.newText(sceneGroup, "Próxima página", display.contentCenterX, display.contentHeight - 100, native.systemFont, 24)
    nextButton:setFillColor(0.2, 0.6, 1)
    nextButton:addEventListener("tap", function()
        composer.gotoScene("page4")
    end)

    local backButton = display.newText(sceneGroup, "Página anterior", display.contentCenterX, display.contentHeight - 50, native.systemFont, 24)
    backButton:setFillColor(0.2, 0.6, 1) 
    backButton:addEventListener("tap", function()
        composer.gotoScene("page2")
    end)
end

scene:addEventListener("create", scene)

return scene
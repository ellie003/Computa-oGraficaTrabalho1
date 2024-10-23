local composer = require("composer")
local scene = composer.newScene()

function scene:create(event)
    local sceneGroup = self.view

    local background = display.newImageRect(sceneGroup, "assets/capacontracapa.jpeg", display.contentWidth, display.contentHeight)
    background.x = display.contentCenterX
    background.y = display.contentCenterY


    local boldfonte = "Lora-Bold"  

    local title = display.newText({
        parent = sceneGroup,
        text = "Origem da Vida\n(Hipóteses e Teorias)",
        x = display.contentCenterX,
        y = 200,
        font = boldfonte,
        fontSize = 50,
        align = "center"
    })
    title:setFillColor(1, 1, 1)  

   
    local author = display.newText({
        parent = sceneGroup,
        text = "Elen Naiely dos S. Silva",
        x = display.contentCenterX,
        y = display.contentHeight - 300,
        font = boldfonte,
        fontSize = 40,
        align = "center"
    })
    author:setFillColor(1, 1, 1)  

  
    local semester = display.newText({
        parent = sceneGroup,
        text = "2024.2",
        x = display.contentCenterX,
        y = display.contentHeight - 80,
        font = boldfonte,
        fontSize = 40,
        align = "center"
    })
    semester:setFillColor(1, 1, 1)  

    local nextButton = display.newImageRect(sceneGroup, "assets/botaãoproximo.png", 200, 80)
    nextButton.x = display.contentWidth - 150
    nextButton.y = display.contentHeight - 100

    nextButton:addEventListener("tap", function()
        composer.gotoScene("page2")
    end)
end

scene:addEventListener("create", scene)

return scene
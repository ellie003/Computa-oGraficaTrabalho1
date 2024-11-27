local composer = require("composer")
local scene = composer.newScene()

local isMuted = true  
local audioFile = audio.loadSound("assets/capa.mp3")
local audioChannel = nil  

local function toggleSound(event)
    if isMuted then
       
        audioChannel = audio.play(audioFile, { loops = 0, onComplete = function() 
           
            isMuted = true
            muteButton.isVisible = true
            unmuteButton.isVisible = false
        end })  
        isMuted = false
       
        muteButton.isVisible = false
        unmuteButton.isVisible = true
    else
       
        audio.stop(audioChannel)
        isMuted = true
       
        muteButton.isVisible = true
        unmuteButton.isVisible = false

    end
end

function scene:create(event)
    local sceneGroup = self.view

 
    local background = display.newImageRect(sceneGroup, "assets/capacontracapa.jpeg", display.contentWidth, display.contentHeight)
    background.x = display.contentCenterX
    background.y = display.contentCenterY

    
    local boldfontFile = "assets/Lora-Bold.ttf"

    local title = display.newText({
        parent = sceneGroup,
        text = "Origem da Vida\n(Hipóteses e Teorias)",
        x = display.contentCenterX,
        y = 245,
        font = boldfontFile,
        fontSize = 50,
        align = "center"
    })
    title:setFillColor(1, 1, 1)  

   
    local author = display.newText({
        parent = sceneGroup,
        text = "Elen Naiely dos S. Silva",
        x = display.contentCenterX,
        y = display.contentHeight - 300,
        font = boldfontFile,
        fontSize = 40,
        align = "center"
    })
    author:setFillColor(1, 1, 1)  

  
    local semester = display.newText({
        parent = sceneGroup,
        text = "2024.2",
        x = display.contentCenterX,
        y = display.contentHeight - 100,
        font = boldfontFile,
        fontSize = 40,
        align = "center"
    })
    semester:setFillColor(1, 1, 1)  

 
    local nextButton = display.newImageRect(sceneGroup, "assets/botaãoproximo.png", 200, 80)
    nextButton.x = display.contentWidth - 150
    nextButton.y = display.contentHeight - 100
    nextButton:addEventListener("tap", function()
        
        composer.setVariable("isMuted", isMuted)
        composer.gotoScene("page2")
    end)

    
    muteButton = display.newImageRect(sceneGroup, "assets/SomDesligado.png", 230, 100)
    muteButton.x = 130
    muteButton.y = display.contentHeight - 910

    unmuteButton = display.newImageRect(sceneGroup, "assets/SomLigado.png", 200, 80)
    unmuteButton.x = 130
    unmuteButton.y = display.contentHeight - 910
    unmuteButton.isVisible = false  

    muteButton:addEventListener("tap", toggleSound)
    unmuteButton:addEventListener("tap", toggleSound)

    muteButton.isVisible = true
    unmuteButton.isVisible = false
end


function scene:hide(event)
    if event.phase == "will" then
        
        if audioChannel then
            audio.stop(audioChannel)
        end
    end
end


scene:addEventListener("create", scene)
scene:addEventListener("hide", scene)

return scene

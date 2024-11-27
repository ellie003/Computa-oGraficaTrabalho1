composer = require("composer")
local scene = composer.newScene()

function scene:create(event)
    local sceneGroup = self.view

    -- Fundo da tela
    local background = display.newRect(sceneGroup, display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight)
    background:setFillColor(0.133, 0.169, 0.235)

    --------------------- Título e texto ---------------------
    local fontFile = "assets/Lora-Regular.ttf"
    local boldfontFile = "assets/Lora-Bold.ttf"
    local topText = display.newText(sceneGroup, "Teoria da Panspermia", display.contentCenterX + 120, 120, boldfontFile, 35)
    topText:setFillColor(1, 1, 1)

    local intrText = display.newText({
        parent = sceneGroup,
        text = "A Teoria da Panspermia sugere que a vida não se originou na Terra, mas que microrganismos ou compostos orgânicos essenciais foram trazidos ao nosso planeta por meteoros, cometas ou poeira cósmica.",
        x = display.contentCenterX - (display.contentWidth / 600),
        y = topText.y + 150,
        width = display.contentWidth - 50,
        font = fontFile,
        fontSize = 23,
        align = "left"
    })
    intrText:setFillColor(1, 1, 1)

    local intr2Text = display.newText({
        parent = sceneGroup,
        text = "Essa teoria ganhou destaque ao longo do século XX, com a descoberta de que algumas formas de vida microscópica, como esporos bacterianos, podem sobreviver em ambientes extremos, incluindo o vácuo do espaço. De acordo com a Panspermia, essas formas de vida podem ter viajado através do espaço e iniciado o processo de vida na Terra após o impacto de corpos celestes.",
        x = 550,
        y = topText.y + 380,
        width = display.contentWidth / 2+1 ,
        font = fontFile,
        fontSize = 20,
        align = "left"
    })
    intrText:setFillColor(1, 1, 1)

    local instructionText = display.newText({
        parent = sceneGroup,
        text = "Faça o movimento de pinça para aumentar o zoom e explorar a Teoria da Panspermia. Veja detalhes do cometa, compostos orgânicos e formas de vida microscópicas.",
        x = display.contentCenterX,
        y = display.contentCenterY + 310,
        width = display.contentWidth - 200,
        font = fontFile,
        fontSize = 20,
        align = "center"
    })
    instructionText:setFillColor(1, 1, 1)

    local pageText = display.newText(sceneGroup, "4", display.contentCenterX, display.contentCenterY + 410, fontFile, 50)
    pageText:setFillColor(1, 1, 1)

    ---------------------- Botões -------------------------
    local nextButton = display.newImageRect(sceneGroup, "assets/botaãoproximo.png", 200, 80)
    nextButton.x = display.contentWidth - 150
    nextButton.y = display.contentHeight - 100
    nextButton:addEventListener("tap", function()
        composer.gotoScene("page5")
    end)

    local backButton = display.newImageRect(sceneGroup, "assets/botãoanterio.png", 200, 85)
    backButton.x = 150
    backButton.y = display.contentHeight - 100
    backButton:addEventListener("tap", function()
        composer.gotoScene("page3")
    end)

    local muteButton = display.newImageRect(sceneGroup, "assets/SomDesligado.png", 230, 100)
    muteButton.x = 130
    muteButton.y = display.contentHeight - 910

    local unmuteButton = display.newImageRect(sceneGroup, "assets/SomLigado.png", 200, 80)
    unmuteButton.x = 130
    unmuteButton.y = display.contentHeight - 910
    unmuteButton.isVisible = false

    --------------------------- Imagens ---------------------------
    local image1 = display.newImageRect(sceneGroup, "assets/cometa.png", 90, 90)
    image1.x = 150
    image1.y = 400

    local image2 = display.newImageRect(sceneGroup, "assets/terra.png", 90, 90)
    image2.x = 250
    image2.y = 500

    -------------------- Função para alternar o som -------------------------
   -- Botões de som
   muteButton = display.newImageRect(sceneGroup, "assets/SomDesligado.png", 230, 100)
   muteButton.x = 130
   muteButton.y = display.contentHeight - 910

   unmuteButton = display.newImageRect(sceneGroup, "assets/SomLigado.png", 200, 80)
   unmuteButton.x = 130
   unmuteButton.y = display.contentHeight - 910
   unmuteButton.isVisible = false

   local audioFile = audio.loadSound("assets/panspermia.mp3")
   
   -- Função para alternar o som
   local function toggleSound(event)
       if muteButton.isVisible then
           muteButton.isVisible = false
           unmuteButton.isVisible = true

           -- Tocar o som uma vez e configurar o retorno quando o áudio terminar
           audioChannel = audio.play(audioFile, {
               loops = 0,  -- Tocar uma vez
               onComplete = function()
                   -- Quando o áudio terminar, volta para o estado de som desligado
                   muteButton.isVisible = true
                   unmuteButton.isVisible = false
               end
           })
       else
           muteButton.isVisible = true
           unmuteButton.isVisible = false
           if audioChannel then
               audio.stop(audioChannel)  -- Para o som
               audioChannel = nil
           end
       end
   end

   -- Adicionando eventos aos botões de som
   muteButton:addEventListener("tap", toggleSound)
   unmuteButton:addEventListener("tap", toggleSound)

end

function scene:hide(event)
    if event.phase == "will" then
        -- Limpeza de recursos
        if audioChannel then
            audio.stop(audioChannel)  -- Interrompe o áudio quando mudar de página
        end
    end
end

scene:addEventListener("create", scene)
scene:addEventListener("hide", scene)
return scene

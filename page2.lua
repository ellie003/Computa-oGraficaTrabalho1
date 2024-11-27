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
    local topText = display.newText(sceneGroup, "Hipótese da Abiogênese", display.contentCenterX + 120, 120, boldfontFile, 35)
    topText:setFillColor(1, 1, 1)

    local intrText = display.newText({
        parent = sceneGroup,
        text = "Desde o início da humanidade, cientistas e filósofos têm se perguntado: como a vida começou? Diversas teorias foram propostas ao longo dos séculos para explicar a origem da vida na Terra.",
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
        text = "A Hipótese da Abiogênese afirmava que a vida podia surgir espontaneamente de matéria inanimada, como carne podre ou lama, sem a necessidade de um organismo pré-existente. Antigamente, acreditava-se que organismos como vermes e moscas surgiam do nada.",
        x = 210,
        y = topText.y + 450,
        width = display.contentWidth / 2 - 2,
        font = fontFile,
        fontSize = 23,
        align = "left"
    })
    intrText:setFillColor(1, 1, 1)

    local instructionText = display.newText({
        parent = sceneGroup,
        text = "Toque nas moléculas para movê-las e combiná-las, criando um organismo simples.",
        x = display.contentCenterX,
        y = display.contentCenterY + 310,
        width = display.contentWidth - 300,
        font = fontFile,
        fontSize = 20,
        align = "center"
    })
    instructionText:setFillColor(1, 1, 1)

    local pageText = display.newText(sceneGroup, "2", display.contentCenterX, display.contentCenterY + 410, fontFile, 50)
    pageText:setFillColor(1, 1, 1)

    ---------------------- Botões -------------------------
    local nextButton = display.newImageRect(sceneGroup, "assets/botaãoproximo.png", 200, 80)
    nextButton.x = display.contentWidth - 150
    nextButton.y = display.contentHeight - 100
    nextButton:addEventListener("tap", function()
        composer.gotoScene("page3")
    end)

    local backButton = display.newImageRect(sceneGroup, "assets/botãoanterio.png", 200, 85)
    backButton.x = 150
    backButton.y = display.contentHeight - 100
    backButton:addEventListener("tap", function()
        composer.gotoScene("cover")
    end)

    local muteButton = display.newImageRect(sceneGroup, "assets/SomDesligado.png", 230, 100)
    muteButton.x = 130
    muteButton.y = display.contentHeight - 910

    local unmuteButton = display.newImageRect(sceneGroup, "assets/SomLigado.png", 200, 80)
    unmuteButton.x = 130
    unmuteButton.y = display.contentHeight - 910
    unmuteButton.isVisible = false

    --------------------------- Imagens ---------------------------
    local image1 = display.newImageRect(sceneGroup, "assets/pagina1organismos/molecula1.png", 90, 90)
    image1.x = 660
    image1.y = 700

    local image2 = display.newImageRect(sceneGroup, "assets/pagina1organismos/molecula2.png", 90, 90)
    image2.x = display.contentWidth - 100
    image2.y = 340

    local image3 = display.newImageRect(sceneGroup, "assets/pagina1organismos/molecula3.png", 90, 90)
    image3.x = 450
    image3.y = 380

    local image4 = display.newImageRect(sceneGroup, "assets/pagina1organismos/molecula4.png", 90, 90)
    image4.x = display.contentWidth - 200
    image4.y = display.contentHeight - 500

    local image5 = display.newImageRect(sceneGroup, "assets/pagina1organismos/molecula5.png", 90, 90)
    image5.x = display.contentCenterX + 40
    image5.y = display.contentCenterY

    -------------------- Organismo Simples -------------------------
    local organism = display.newImageRect(sceneGroup, "assets/pagina1organismos/organismo_simples.png", 260, 260)
    organism.x = display.contentCenterX + 200
    organism.y = display.contentCenterY - 32
    organism.isVisible = false

    -------------------- Variáveis de controle ---------------------
    local movedCount = 0

    local audioFile = audio.loadSound("assets/texto_pagina2.mp3")

    local function moveToImage4(event)
        local target = event.target
        transition.to(target, {
            x = image4.x,
            y = image4.y,
            time = 500,
            onComplete = function()
                movedCount = movedCount + 1
                if movedCount == 4 then
                    organism.isVisible = true
                end
            end
        })
    end

    image1:addEventListener("tap", moveToImage4)
    image2:addEventListener("tap", moveToImage4)
    image3:addEventListener("tap", moveToImage4)
    image5:addEventListener("tap", moveToImage4)

    -------------------- Função para alternar o som -------------------------
    local function toggleSound(event)
        if muteButton.isVisible then
            muteButton.isVisible = false
            unmuteButton.isVisible = true
            audio.play(audioFile, { loops = 0, onComplete = function() 
                -- Quando o áudio terminar, volta o botão para o estado "desligado"
                muteButton.isVisible = true
                unmuteButton.isVisible = false
                print("Áudio terminado, som desligado.")
            end })
            print("Som ligado!")
        else
            muteButton.isVisible = true
            unmuteButton.isVisible = false
            audio.stop()
            print("Som desligado!")
        end
    end

    muteButton:addEventListener("tap", toggleSound)
    unmuteButton:addEventListener("tap", toggleSound)

    -------------------- Função de reset ao passar de página -------------------------
    scene:addEventListener("hide", function(event)
        -- Resetando animações e elementos
        image1.x = 660
        image1.y = 700
        image2.x = display.contentWidth - 100
        image2.y = 340
        image3.x = 450
        image3.y = 380
        image4.x = display.contentWidth - 200
        image4.y = display.contentHeight - 500
        image5.x = display.contentCenterX + 40
        image5.y = display.contentCenterY
        organism.isVisible = false
        movedCount = 0  -- Resetando contagem de movimentos
        -- Parar o áudio
        audio.stop()
    end)
end

scene:addEventListener("create", scene)
return scene

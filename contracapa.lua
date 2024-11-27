local composer = require("composer")
local scene = composer.newScene()

function scene:create(event)
    local sceneGroup = self.view
    local boldfontFile = "assets/Lora-Bold.ttf"
    -- Imagem de fundo
    local background = display.newImageRect(sceneGroup, "assets/contracapa.jpeg", display.contentWidth, display.contentHeight)
    background.x = display.contentCenterX
    background.y = display.contentCenterY

    

    -- Título
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

    -- Texto da disciplina
    local disciplina = display.newText({
        parent = sceneGroup,
        text = "Disciplina: Computação Gráfica e\nSistemas Multimídia;",
        x = display.contentCenterX,
        y = 400,
        font = boldfontFile,
        fontSize = 35,
        align = "center"
    })
    disciplina:setFillColor(1, 1, 1)

    -- Referência bibliográfica
    local referencia = display.newText({
        parent = sceneGroup,
        text = "LOPES, Sônia; ROSSO, Sérgio. Bio - Volume Único. 1. ed.\nSão Paulo: Saraiva, 2004.",
        x = display.contentCenterX,
        y = 550,
        font = boldfontFile,
        fontSize = 25,
        align = "center"
    })
    referencia:setFillColor(1, 1, 1)

    -- Orientador
    local orientador = display.newText({
        parent = sceneGroup,
        text = "Orientador: Prof. Ewerton Mendonça",
        x = display.contentCenterX,
        y = 650,
        font = boldfontFile,
        fontSize = 35,
        align = "center"
    })
    orientador:setFillColor(1, 1, 1)

    -- Nome do autor
    local eu = display.newText({
        parent = sceneGroup,
        text = "Elen Naiely dos S. Silva",
        x = display.contentCenterX,
        y = 740,
        font = boldfontFile,
        fontSize = 40,
        align = "center"
    })
    eu:setFillColor(1, 1, 1)

    -- Semestre
    local semester = display.newText({
        parent = sceneGroup,
        text = "2024.2",
        x = display.contentCenterX,
        y = display.contentHeight - 200,
        font = boldfontFile,
        fontSize = 40,
        align = "center"
    })
    semester:setFillColor(1, 1, 1)

    -- Botões de navegação
    local homeButton = display.newImageRect(sceneGroup, "assets/botãoinicio.png", 200, 85)
    homeButton.x = display.contentWidth - 150
    homeButton.y = display.contentHeight - 100

    local backButton = display.newImageRect(sceneGroup, "assets/botãoanterio.png", 200, 85)
    backButton.x = 150
    backButton.y = display.contentHeight - 100

    backButton:addEventListener("tap", function()
        composer.gotoScene("page6")
    end)

    homeButton:addEventListener("tap", function()
        composer.gotoScene("cover")
    end)

    -- Botões de controle de som
    local muteButton = display.newImageRect(sceneGroup, "assets/SomDesligado.png", 230, 100)
    muteButton.x = 130
    muteButton.y = display.contentHeight - 910

    local unmuteButton = display.newImageRect(sceneGroup, "assets/SomLigado.png", 200, 80)
    unmuteButton.x = 130
    unmuteButton.y = display.contentHeight - 910
    unmuteButton.isVisible = false

    -------------------- Variáveis de controle de áudio -------------------------
    local audioFile = audio.loadSound("assets/contracapa.mp3")  -- Carregar o áudio

    local function toggleSound(event)
        if muteButton.isVisible then
            muteButton.isVisible = false
            unmuteButton.isVisible = true
            audio.play(audioFile, { loops = 0, onComplete = function() 
                -- Quando o áudio terminar, o botão volta ao estado "desligado"
                muteButton.isVisible = true
                unmuteButton.isVisible = false
                print("Áudio terminado, som desligado.")
            end })
            print("Som ligado!")
        else
            muteButton.isVisible = true
            unmuteButton.isVisible = false
            audio.stop()  -- Para o áudio
            print("Som desligado!")
        end
    end

    muteButton:addEventListener("tap", toggleSound)
    unmuteButton:addEventListener("tap", toggleSound)

    -------------------- Interrupção do áudio ao mudar de página -------------------------
    scene:addEventListener("hide", function(event)
        audio.stop()  -- Interrompe o áudio quando a cena for escondida
    end)
end

scene:addEventListener("create", scene)

return scene

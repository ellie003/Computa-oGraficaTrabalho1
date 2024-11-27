local composer = require("composer")
local scene = composer.newScene()

-- Variável para controlar o estado do som
local isMuted = true  -- Som começa desligado
local audioFile = audio.loadSound("assets/capa.mp3")
local audioChannel = nil  -- Variável para controlar o canal de áudio

-- Função para alternar o estado do som
local function toggleSound(event)
    if isMuted then
        -- Ativa o som
        audioChannel = audio.play(audioFile, { loops = 0, onComplete = function() 
            -- Quando o áudio terminar, retorna ao estado inicial (desligado)
            isMuted = true
            muteButton.isVisible = true
            unmuteButton.isVisible = false
        end })  -- Reproduz o áudio uma vez
        isMuted = false
        -- Troca para o botão de "som ligado"
        muteButton.isVisible = false
        unmuteButton.isVisible = true
    else
        -- Desativa o som
        audio.stop(audioChannel)
        isMuted = true
        -- Troca para o botão de "som desligado"
        muteButton.isVisible = true
        unmuteButton.isVisible = false

    end
end

function scene:create(event)
    local sceneGroup = self.view

    -- Adicionar fundo
    local background = display.newImageRect(sceneGroup, "assets/capacontracapa.jpeg", display.contentWidth, display.contentHeight)
    background.x = display.contentCenterX
    background.y = display.contentCenterY

    -- Fonte
    local boldfontFile = "assets/Lora-Bold.ttf"

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

    -- Autor
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

    -- Semestre
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

    -- Botão de próximo
    local nextButton = display.newImageRect(sceneGroup, "assets/botaãoproximo.png", 200, 80)
    nextButton.x = display.contentWidth - 150
    nextButton.y = display.contentHeight - 100
    nextButton:addEventListener("tap", function()
        -- Passa o estado do som para a próxima página usando o composer
        composer.setVariable("isMuted", isMuted)
        composer.gotoScene("page2")
    end)

    -- Botões de som (mutar/desmutar)
    muteButton = display.newImageRect(sceneGroup, "assets/SomDesligado.png", 230, 100)
    muteButton.x = 130
    muteButton.y = display.contentHeight - 910

    unmuteButton = display.newImageRect(sceneGroup, "assets/SomLigado.png", 200, 80)
    unmuteButton.x = 130
    unmuteButton.y = display.contentHeight - 910
    unmuteButton.isVisible = false  -- Começa invisível

    -- Alterna o som ao clicar
    muteButton:addEventListener("tap", toggleSound)
    unmuteButton:addEventListener("tap", toggleSound)

    -- Inicializa com o som desligado
    muteButton.isVisible = true
    unmuteButton.isVisible = false
end

-- Ao sair da cena, parar o áudio e limpar
function scene:hide(event)
    if event.phase == "will" then
        -- Limpeza de recursos
        if audioChannel then
            audio.stop(audioChannel)
        end
    end
end

-- Adiciona os eventos necessários
scene:addEventListener("create", scene)
scene:addEventListener("hide", scene)

return scene

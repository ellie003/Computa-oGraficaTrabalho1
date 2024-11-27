local composer = require("composer")
local scene = composer.newScene()

-- Variáveis para controle da animação
local bubblesTimer
local organismsTimer
local bubblesGroup
local organismsGroup
local bubblesActive = false

-- Função para criar bolhas animadas
local function createBubbles()
    if bubblesActive and bubblesGroup then
        local imageX, imageY = display.contentCenterX, 600
        local imageWidth, imageHeight = 680, 300
        for i = 1, 10 do
            local bubbleX = imageX + math.random(-imageWidth / 2, imageWidth / 2)
            local bubbleY = imageY + imageHeight / 2
            local bubble = display.newImageRect(bubblesGroup, "assets/bolha.png", math.random(20, 50), math.random(20, 50))
            bubble.x, bubble.y, bubble.alpha = bubbleX, bubbleY, 0.7
            transition.to(bubble, {
                time = math.random(3000, 6000),
                y = imageY - imageHeight / 2,
                alpha = 0,
                onComplete = function() display.remove(bubble) end
            })
        end
    end
end

-- Função para criar micro-organismos dentro da área da imagem
-- Função para criar micro-organismos flutuando no centro da imagem
local function createMicroOrganisms()
    if bubblesActive and organismsGroup and not organismsCreated then
        -- Marcar que os organismos foram criados
        organismsCreated = true
        
        local imageX, imageY = display.contentCenterX, 640
        local imageWidth, imageHeight = 680, 300
        
        -- Coordenadas para a área central da imagem 6 (limitando o movimento)
        local centerX = imageX
        local centerY = imageY
        local moveAreaWidth = imageWidth / 2  -- A largura da área onde os organismos irão flutuar
        local moveAreaHeight = imageHeight / 2  -- A altura da área onde os organismos irão flutuar

        -- Criando 5 micro-organismos no centro
        for i = 1, 5 do
            -- Posições iniciais no centro da área
            local organismX = centerX + math.random(-moveAreaWidth / 2, moveAreaWidth / 2)
            local organismY = centerY + math.random(-moveAreaHeight / 2, moveAreaHeight / 2)
            
            local organism = display.newImageRect(organismsGroup, "assets/pagina1organismos/organismo_simples.png", math.random(30, 70), math.random(30, 70))
            organism.x, organism.y, organism.alpha = organismX, organismY, 1
            
            -- Animação para "flutuar" dentro da área central da imagem
            local function floatOrganism()
                -- Movimento aleatório dentro da área central
                local targetX = centerX + math.random(-moveAreaWidth / 2, moveAreaWidth / 2)
                local targetY = centerY + math.random(-moveAreaHeight / 2, moveAreaHeight / 2)
                
                -- Transição do movimento do organismo
                transition.to(organism, {
                    time = math.random(3000, 6000),
                    x = targetX,
                    y = targetY,
                    onComplete = floatOrganism  -- Recursão para continuar a animação
                })
            end

            -- Inicia a flutuação do organismo
            floatOrganism()
        end
    end
end

-- Função para controlar o acelerômetro
local function onAccelerometer(event)
    local ax, ay, az = event.xInstant, event.yInstant, event.zInstant
    local magnitude = math.sqrt(ax * ax + ay * ay + az * az)
    local threshold = 1.0 -- Limite mínimo de movimento para ativar as bolhas e micro-organismos

    if magnitude > threshold then
        bubblesActive = true
    else
        bubblesActive = false
    end
end

-- Função de configuração da cena
function scene:create(event)
    local sceneGroup = self.view

    -- Fundo da tela
    local background = display.newRect(sceneGroup, display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight)
    background:setFillColor(0.133, 0.169, 0.235)

    -- Grupo para as bolhas
    bubblesGroup = display.newGroup()
    sceneGroup:insert(bubblesGroup)

    -- Grupo para os micro-organismos
    organismsGroup = display.newGroup()
    sceneGroup:insert(organismsGroup)

    -- Título e texto
    local fontFile = "assets/Lora-Regular.ttf"
    local boldfontFile = "assets/Lora-Bold.ttf"

    local topText = display.newText({
        parent = sceneGroup,
        text = "Hipótese das Fontes Hidrotermais",
        x = display.contentCenterX + 120,
        y = 120,
        width = display.contentWidth - 350,
        font = boldfontFile,
        fontSize = 35,
        align = "center"
    })
    topText:setFillColor(1, 1, 1)

    local intr6Text = display.newText({
        parent = sceneGroup,
        text = "As fontes hidrotermais são aberturas no fundo do mar onde a água quente rica em minerais surge devido ao contato com rochas quentes do interior da Terra. Essas fontes criam ecossistemas únicos onde organismos quimiossintéticos sobrevivem sem luz solar, utilizando compostos químicos como sulfetos de hidrogênio para gerar energia. Esse ambiente é fundamental para estudar a origem da vida na Terra e a possibilidade de vida em outros planetas",
        x = display.contentCenterX - (display.contentWidth / 700),
        y = topText.y + 200,
        width = display.contentWidth - 50,
        font = fontFile,
        fontSize = 22,
        align = "left"
    })
    intr6Text:setFillColor(1, 1, 1)

    -- Imagem ilustrativa
    local instrucoesImagem = display.newImageRect(sceneGroup, "assets/6.jpeg", 680, 300)
    instrucoesImagem.x = display.contentCenterX
    instrucoesImagem.y = 600

    -- Instruções
    local instruction6Text = display.newText({
        parent = sceneGroup,
        text = "Balance seu celular para ver as bolhas surgindo da fonte hidrotermal, representando água quente e rica em minerais. Conforme as bolhas se movem, micro-organismos flutuam próximos às fontes, representando formas de vida que sobrevivem sem luz solar",
        x = display.contentCenterX,
        y = display.contentCenterY + 300,
        width = display.contentWidth - 100,
        font = fontFile,
        fontSize = 20,
        align = "center"
    })
    instruction6Text:setFillColor(1, 1, 1)

    -- Página e botões
    local pageText = display.newText(sceneGroup, "6", display.contentCenterX, display.contentCenterY + 410, fontFile, 50)
    pageText:setFillColor(1, 1, 1)

        -- Botões de som
        muteButton = display.newImageRect(sceneGroup, "assets/SomDesligado.png", 230, 100)
        muteButton.x = 130
        muteButton.y = display.contentHeight - 910
    
        unmuteButton = display.newImageRect(sceneGroup, "assets/SomLigado.png", 200, 80)
        unmuteButton.x = 130
        unmuteButton.y = display.contentHeight - 910
        unmuteButton.isVisible = false
    
        -- Carregando o som
        audioFile = audio.loadSound("assets/HT.mp3")
    
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

    local nextButton = display.newImageRect(sceneGroup, "assets/botaãoproximo.png", 200, 80)
    nextButton.x = display.contentWidth - 150
    nextButton.y = display.contentHeight - 100
    nextButton:addEventListener("tap", function()
        composer.gotoScene("contracapa")
    end)

    local backButton = display.newImageRect(sceneGroup, "assets/botãoanterio.png", 200, 85)
    backButton.x = 150
    backButton.y = display.contentHeight - 100
    backButton:addEventListener("tap", function()
        composer.gotoScene("page5")
    end)
end

-- Controle de reinício da animação ao mostrar a cena
function scene:show(event)
    local phase = event.phase

    if phase == "will" then
        -- Remove e recria os grupos de bolhas e micro-organismos
        if bubblesGroup then
            bubblesGroup:removeSelf()
        end
        if organismsGroup then
            organismsGroup:removeSelf()
        end

        bubblesGroup = display.newGroup()
        organismsGroup = display.newGroup()
        self.view:insert(bubblesGroup)
        self.view:insert(organismsGroup)

        -- Reinicia o estado da animação
        bubblesActive = false

        -- Configura o evento do acelerômetro
        Runtime:addEventListener("accelerometer", onAccelerometer)
    elseif phase == "did" then
        -- Inicia a animação de bolhas e micro-organismos
        bubblesTimer = timer.performWithDelay(500, createBubbles, 0)
        organismsTimer = timer.performWithDelay(1000, createMicroOrganisms, 0)
    end
end

-- Controle de limpeza ao sair da cena
function scene:hide(event)
    local phase = event.phase

    if phase == "will" then
        -- Remove o evento do acelerômetro
        Runtime:removeEventListener("accelerometer", onAccelerometer)

        -- Cancela os timers das bolhas e micro-organismos
        if bubblesTimer then
            timer.cancel(bubblesTimer)
            bubblesTimer = nil
        end
        if organismsTimer then
            timer.cancel(organismsTimer)
            organismsTimer = nil
        end

        -- Remove todos os elementos
        if bubblesGroup then
            bubblesGroup:removeSelf()
            bubblesGroup = nil
        end
        if organismsGroup then
            organismsGroup:removeSelf()
            organismsGroup = nil
        end
    end
end


function scene:hide(event)
    if event.phase == "will" then
        -- Limpeza de recursos
        if audioChannel then
            audio.stop(audioChannel)
        end
    end
end

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)

return scene

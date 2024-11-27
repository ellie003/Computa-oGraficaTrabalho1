local composer = require("composer")
local scene = composer.newScene()

function scene:create(event)
    local sceneGroup = self.view

    -- Fundo da tela
    local background = display.newRect(sceneGroup, display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight)
    background:setFillColor(0.133, 0.169, 0.235)

    --------------------- Título e texto ---------------------
    local fontFile = "assets/Lora-Regular.ttf"
    local boldfontFile = "assets/Lora-Bold.ttf"
    local topText = display.newText(sceneGroup, "Hipótese da Biogênese", display.contentCenterX + 120, 120, boldfontFile, 35)
    topText:setFillColor(1, 1, 1)

    local intrText = display.newText({
        parent = sceneGroup,
        text = "A teoria da biogênese afirma que a vida só surge de seres vivos preexistentes, refutando hipótese da Abiogênese. Louis Pasteur comprovou essa teoria no século XIX com seu experimento com frasco de pescoço de cisne, onde ele colocou caldo nutritivo em frascos: no frasco com pescoço intacto, o ar não podia entrar, e não houve crescimento de microrganismos; no frasco com pescoço quebrado, o ar contaminado entrou, e microrganismos cresceram. O experimento provou que microrganismos vêm do ar, não surgem espontaneamente.",
        x = display.contentCenterX - (display.contentWidth / 600),
        y = topText.y + 200,
        width = display.contentWidth - 50,
        font = fontFile,
        fontSize = 20,
        align = "left"
    })
    intrText:setFillColor(1, 1, 1)

    -- Imagem para zoom
    local instrucoesImagem
    local function createImage()
        instrucoesImagem = display.newImageRect(sceneGroup, "assets/copiabiogenese-removebg-preview.png", 300, 250)
        instrucoesImagem.x = display.contentCenterX
        instrucoesImagem.y = 600
    end

    createImage() -- Cria a imagem na primeira vez

    -- Carregar o som de vidro quebrando
    local breakSound = audio.loadSound("assets/Glass_Breaking___Minecraft__-_Sound_Effect_[_YouConvert.net_].mp3")

    -- Função para mudar a imagem e tocar o som
    local function onImageTap()
        -- Tocar o som de vidro quebrando
        audio.play(breakSound)

        -- Remover a imagem atual
        instrucoesImagem:removeSelf()

        -- Adicionar a nova imagem
        instrucoesImagem = display.newImageRect(sceneGroup, "assets/biogenset-removebg-preview.png", 300, 250)
        instrucoesImagem.x = display.contentCenterX
        instrucoesImagem.y = 600

        -- Verificar se a tabela de microorganismos existe
        if microorganisms then
            -- Mover todos os micro-organismos para cima da nova imagem
            for i, microorganism in ipairs(microorganisms) do
                transition.to(microorganism, {
                    time = 1000,
                    x = instrucoesImagem.x, -- X da imagem
                    y = instrucoesImagem.y - 50, -- Y um pouco acima da imagem
                    onComplete = function()
                        -- Aqui você pode adicionar um comportamento extra após a animação, se necessário
                    end
                })
            end
        end
    end

    -- Adiciona o ouvinte de evento para a imagem
    instrucoesImagem:addEventListener("tap", onImageTap)

    local instructionText = display.newText({
        parent = sceneGroup,
        text = "Toque no frasco para quebrar o pescoço de cisne e permitir que o ar contaminado entre no caldo nutritivo, fazendo os microrganismos se multiplicarem no interior do frasco",
        x = display.contentCenterX,
        y = display.contentCenterY + 310,
        width = display.contentWidth - 150,
        font = fontFile,
        fontSize = 20,
        align = "center"
    })
    instructionText:setFillColor(1, 1, 1)

    local pageText = display.newText(sceneGroup, "3", display.contentCenterX, display.contentCenterY + 410, fontFile, 50)
    pageText:setFillColor(1, 1, 1)

    ---------------------- Botões -------------------------
    local nextButton = display.newImageRect(sceneGroup, "assets/botaãoproximo.png", 200, 80)
    nextButton.x = display.contentWidth - 150
    nextButton.y = display.contentHeight - 100
    nextButton:addEventListener("tap", function()
        composer.gotoScene("page4")
    end)

    local backButton = display.newImageRect(sceneGroup, "assets/botãoanterio.png", 200, 85)
    backButton.x = 150
    backButton.y = display.contentHeight - 100
    backButton:addEventListener("tap", function()
        composer.gotoScene("page2")
    end)

    -- Botões de som
    muteButton = display.newImageRect(sceneGroup, "assets/SomDesligado.png", 230, 100)
    muteButton.x = 130
    muteButton.y = display.contentHeight - 910

    unmuteButton = display.newImageRect(sceneGroup, "assets/SomLigado.png", 200, 80)
    unmuteButton.x = 130
    unmuteButton.y = display.contentHeight - 910
    unmuteButton.isVisible = false

    -- Carregando o som
    audioFile = audio.loadSound("assets/biogenese.mp3")

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

    -------------------- Interrupção do áudio quando a cena for escondida -------------------------
    function scene:hide(event)
        if event.phase == "will" then
            -- Limpeza de recursos
            if audioChannel then
                audio.stop(audioChannel)
            end
        end
    end

    ------------------- Quando a cena for mostrada, recriar a imagem e a interação -------------------------
    function scene:show(event)
        local phase = event.phase
        if phase == "did" then
            -- Recriar a imagem e a interação ao voltar para a página
            if not instrucoesImagem then
                createImage()
                instrucoesImagem:addEventListener("tap", onImageTap) -- Recriar a interação
            end
        end
    end

    scene:addEventListener("hide", scene)
    scene:addEventListener("show", scene)

    ------------------ Criar microorganismos flutuantes -------------------
    microorganisms = {}  -- Inicializa a tabela de microorganismos

    local function createMicroorganism()
        -- Criar um microorganismo
        local microorganism = display.newCircle(sceneGroup, math.random(20, display.contentWidth - 20), math.random(20, display.contentHeight - 20), 10)
        microorganism:setFillColor(math.random(), math.random(), math.random()) -- Cor aleatória para os microorganismos

        -- Animar o microorganismo flutuando
        local function floatMicroorganism()
            transition.to(microorganism, {
                time = math.random(5000, 10000),
                x = math.random(20, display.contentWidth - 20),
                y = math.random(20, display.contentHeight - 20),
                onComplete = floatMicroorganism -- Recria a animação para que o microorganismo flutue indefinidamente
            })
        end

        floatMicroorganism()
        table.insert(microorganisms, microorganism) -- Adiciona o microorganismo na tabela
    end

    -- Criar microorganismos
    for i = 1, 10 do
        createMicroorganism()
    end


    



end

scene:addEventListener("create", scene)

return scene

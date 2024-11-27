local composer = require("composer")
local scene = composer.newScene()

-- Variáveis globais da cena
local molecules = {} -- Tabela para armazenar as moléculas criadas
local muteButton
local unmuteButton
local audioFile
local audioChannel
local hidroImage

-- Função de arraste para as moléculas de RNA
local function onTouch(event)
    local molecule = event.target
    local phase = event.phase

    if phase == "began" then
        -- Começo do arraste
        display.currentStage:setFocus(molecule)
        molecule.isFocus = true
        molecule.x0 = event.x - molecule.x
        molecule.y0 = event.y - molecule.y
    elseif molecule.isFocus then
        if phase == "moved" then
            -- Movimento da molécula
            molecule.x = event.x - molecule.x0
            molecule.y = event.y - molecule.y0
        elseif phase == "ended" or phase == "cancelled" then
            -- Final do arraste, verificar se foi no "mar"
            display.currentStage:setFocus(nil)
            molecule.isFocus = false

            -- Verificar se a molécula tocou a imagem da Fonte Hidrotermal
            local hidroBounds = hidroImage.contentBounds
            if molecule.x > hidroBounds.xMin and molecule.x < hidroBounds.xMax and
                molecule.y > hidroBounds.yMin and molecule.y < hidroBounds.yMax then
                -- Se tocou a área da imagem, duplicar a molécula
                local newMolecule = display.newImageRect(scene.view, "assets/RNA.png", 60, 60)
                newMolecule.x = molecule.x + math.random(-50, 50) -- Adicionando variação dentro da área da imagem
                newMolecule.y = molecule.y + math.random(-50, 50)
                newMolecule:addEventListener("touch", onTouch)  -- Permitir arrastar novamente a nova molécula
                table.insert(molecules, newMolecule)
            else
                -- Se não tocou, volta para a posição original
                molecule.x = molecule.x0
                molecule.y = molecule.y0
            end
        end
    end

    return true
end

function scene:create(event)
    local sceneGroup = self.view

    -- Fundo da tela
    local background = display.newRect(sceneGroup, display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight)
    background:setFillColor(0.133, 0.169, 0.235)
    local fontFile = "assets/Lora-Regular.ttf"
    local boldfontFile = "assets/Lora-Bold.ttf"

    -- Configurações do título
    local textOptions = {
        parent = sceneGroup,
        text = "Hipótese do Mundo de RNA",
        x = display.contentCenterX + 120,
        y = 120,
        width = display.contentWidth - 350,
        font = boldfontFile,
        fontSize = 35,
        align = "center"
    }
    local topText = display.newText(textOptions)
    topText:setFillColor(1, 1, 1)

    -- Texto descritivo
    local intr6Text = display.newText({
        parent = sceneGroup,
        text = "A Hipótese do Mundo de RNA propõe que, antes do surgimento das proteínas e do DNA, o RNA teria sido a molécula fundamental para a vida. O RNA, assim como o DNA, é capaz de armazenar informações genéticas, mas, diferentemente do DNA, ele também pode catalisar reações químicas, permitindo sua autorreplicação. Essa hipótese sugere que o RNA teria desempenhado um papel central no surgimento das primeiras formas de vida, sendo a base para o desenvolvimento de sistemas biológicos mais complexos.",
        x = display.contentCenterX - (display.contentWidth / 700),
        y = topText.y + 220,
        width = display.contentWidth - 50,
        font = fontFile,
        fontSize = 22,
        align = "left"
    })
    intr6Text:setFillColor(1, 1, 1)

    -- Imagem da "Fonte Hidrotermal"
    hidroImage = display.newImageRect(sceneGroup, "assets/hidroC.jpeg", 680, 300)
    hidroImage.x = display.contentCenterX
    hidroImage.y = 640

    -- Instrução
    local instruction6Text = display.newText({
        parent = sceneGroup,
        text = "Arraste as fitas de RNA para o mar, onde, ao interagir com as substâncias químicas, elas iniciam sua replicação, como propõe a Hipótese do Mundo de RNA",
        x = display.contentCenterX,
        y = display.contentCenterY + 335,
        width = display.contentWidth - 100,
        font = fontFile,
        fontSize = 20,
        align = "center"
    })
    instruction6Text:setFillColor(1, 1, 1)

    -- Número da página
    local pageText = display.newText(sceneGroup, "5", display.contentCenterX, display.contentCenterY + 410, fontFile, 50)
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
    audioFile = audio.loadSound("assets/rna.mp3")

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

    -- Outros botões
    local nextButton = display.newImageRect(sceneGroup, "assets/botaãoproximo.png", 200, 80)
    nextButton.x = display.contentWidth - 150
    nextButton.y = display.contentHeight - 100
    nextButton:addEventListener("tap", function()
        composer.gotoScene("page6")
    end)

    local backButton = display.newImageRect(sceneGroup, "assets/botãoanterio.png", 200, 85)
    backButton.x = 150
    backButton.y = display.contentHeight - 100
    backButton:addEventListener("tap", function()
        composer.gotoScene("page4")
    end)

    -- Função para criar as moléculas
    self.createMolecule = function(x, y, imagePath)
        local molecula = display.newImageRect(sceneGroup, imagePath, 60, 60)
        molecula.x = x
        molecula.y = y
        molecula:addEventListener("touch", onTouch)  -- Adicionando evento de toque
        table.insert(molecules, molecula)
    end
end

function scene:show(event)
    if event.phase == "did" then
        -- Recriação de estado inicial
        for i = #molecules, 1, -1 do
            display.remove(molecules[i])
            table.remove(molecules, i)
        end

        -- Criação inicial de moléculas dentro do "mar"
        self.createMolecule(700, 750, "assets/pagina1organismos/molecula4.png")  -- Primeira fita dentro do "mar"
        self.createMolecule(400, 750, "assets/pagina1organismos/molecula4.png")  -- Segunda fita dentro do "mar"
        self.createMolecule(650, 700, "assets/pagina1organismos/molecula4.png")  -- Terceira fita dentro do "mar"
        self.createMolecule(100, 680, "assets/pagina1organismos/molecula1.png")  -- Quarta fita dentro do "mar"

        self.createMolecule(700, 450, "assets/RNA.png")
        self.createMolecule(705, 820, "assets/RNA.png")
        self.createMolecule(300, 950, "assets/RNA.png")
        self.createMolecule(60, 820, "assets/RNA.png")
        self.createMolecule(25, 700, "assets/RNA.png")
        self.createMolecule(15, 505, "assets/RNA.png")
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

print("=== MAKAZI START ===")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local Lighting = game:GetService("Lighting")
local VirtualUser = game:GetService("VirtualUser")
local SoundService = game:GetService("SoundService")
local TeleportService = game:GetService("TeleportService")
local InsertService = game:GetService("InsertService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Очистка старого
pcall(function() CoreGui:FindFirstChild("MakaziMod"):Destroy() end)
pcall(function() playerGui:FindFirstChild("MakaziMod"):Destroy() end)

local gui = Instance.new("ScreenGui")
gui.Name = "MakaziMod"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
pcall(function() gui.Parent = CoreGui end)
if not gui.Parent then gui.Parent = playerGui end
print("[MAKAZI] GUI parent:", tostring(gui.Parent))

local COLORS = {
    accent = Color3.fromRGB(235, 40, 55),
    accentDark = Color3.fromRGB(150, 15, 25),
    accentGlow = Color3.fromRGB(255, 80, 100),
    bg = Color3.fromRGB(18, 18, 24),
    bgLight = Color3.fromRGB(28, 28, 36),
    card = Color3.fromRGB(36, 36, 46),
    cardHover = Color3.fromRGB(48, 48, 60),
    text = Color3.fromRGB(240, 240, 245),
    textDim = Color3.fromRGB(150, 150, 165),
}
local FONT = Enum.Font.GothamMedium
local FONT_BOLD = Enum.Font.GothamBold

local function corner(obj, r)
    local c = Instance.new("UICorner")
    c.CornerRadius = typeof(r) == "number" and UDim.new(0, r) or r
    c.Parent = obj
    return c
end
local function stroke(obj, color, thickness, transparency)
    local s = Instance.new("UIStroke")
    s.Color = color
    s.Thickness = thickness or 1.5
    s.Transparency = transparency or 0
    s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    s.Parent = obj
    return s
end
local function gradient(obj, c1, c2, rotation)
    local g = Instance.new("UIGradient")
    g.Color = ColorSequence.new(c1, c2)
    g.Rotation = rotation or 90
    g.Parent = obj
    return g
end

-- ЗВУКИ
local soundEnabled = true
local SOUND_IDS = {
    click = "rbxassetid://6895079853",
    open = "rbxassetid://6895080175",
    close = "rbxassetid://6895080059",
}
local function playSound(id, vol, pitch)
    if not soundEnabled then return end
    local s = Instance.new("Sound")
    s.SoundId = id
    s.Volume = vol or 0.4
    s.PlaybackSpeed = pitch or 1
    s.Parent = SoundService
    s:Play()
    task.delay(3, function() if s then s:Destroy() end end)
end
local function clickSound() playSound(SOUND_IDS.click, 0.35, 1) end
local function toggleOn() playSound(SOUND_IDS.click, 0.4, 1.3) end
local function toggleOff() playSound(SOUND_IDS.click, 0.4, 0.85) end
local function openSound() playSound(SOUND_IDS.open, 0.45, 1) end
local function closeSound() playSound(SOUND_IDS.close, 0.45, 1) end

-- УВЕДОМЛЕНИЯ
local notifHolder = Instance.new("Frame")
notifHolder.Size = UDim2.new(0, 220, 1, -40)
notifHolder.Position = UDim2.new(1, -230, 0, 20)
notifHolder.BackgroundTransparency = 1
notifHolder.ZIndex = 100
notifHolder.Parent = gui

local notifLayout = Instance.new("UIListLayout")
notifLayout.Padding = UDim.new(0, 6)
notifLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
notifLayout.SortOrder = Enum.SortOrder.LayoutOrder
notifLayout.Parent = notifHolder

local function notify(text, ok)
    playSound(SOUND_IDS.click, 0.3, ok and 1.2 or 0.9)
    local card = Instance.new("Frame")
    card.Size = UDim2.new(1, 0, 0, 40)
    card.BackgroundColor3 = COLORS.card
    card.BorderSizePixel = 0
    card.ZIndex = 101
    card.Parent = notifHolder
    corner(card, 8)
    stroke(card, ok and COLORS.accent or Color3.fromRGB(180,180,180), 1.5, 0.3)

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -16, 1, 0)
    lbl.Position = UDim2.new(0, 14, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = COLORS.text
    lbl.TextSize = 11
    lbl.Font = FONT_BOLD
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.TextWrapped = true
    lbl.ZIndex = 102
    lbl.Parent = card

    card.Position = UDim2.new(1, 50, 0, 0)
    TweenService:Create(card, TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
        { Position = UDim2.new(0, 0, 0, 0) }):Play()

    task.delay(2.5, function()
        local t = TweenService:Create(card, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.In),
            { Position = UDim2.new(1, 50, 0, 0), BackgroundTransparency = 1 })
        t:Play()
        t.Completed:Connect(function() card:Destroy() end)
    end)
end

-- КНОПКА-КРУЖОК
local circleHolder = Instance.new("Frame")
circleHolder.Size = UDim2.new(0, 70, 0, 70)
circleHolder.Position = UDim2.new(0, 30, 0, 150)
circleHolder.BackgroundTransparency = 1
circleHolder.ZIndex = 30
circleHolder.Parent = gui

local circle = Instance.new("ImageButton")
circle.Size = UDim2.new(1, 0, 1, 0)
circle.BackgroundColor3 = COLORS.accent
circle.BorderSizePixel = 0
circle.AutoButtonColor = false
circle.Active = true
circle.Image = "rbxthumb://type=Asset&id=82505551582498&w=420&h=420"
circle.ImageColor3 = Color3.fromRGB(255, 255, 255)
circle.ScaleType = Enum.ScaleType.Crop
circle.ZIndex = 2
circle.Parent = circleHolder
corner(circle, UDim.new(1, 0))
stroke(circle, COLORS.accent, 2, 0.2)

-- МЕНЮ
local menu = Instance.new("Frame")
menu.Size = UDim2.new(0, 280, 0, 340)
menu.Position = UDim2.new(0.5, -140, 0.5, -170)
menu.BackgroundColor3 = COLORS.bg
menu.BorderSizePixel = 0
menu.Visible = false
menu.Active = true
menu.ClipsDescendants = true
menu.Parent = gui
corner(menu, 14)
stroke(menu, COLORS.accent, 1.5, 0.4)

local menuDark = Instance.new("Frame")
menuDark.Size = UDim2.new(1, 0, 1, 0)
menuDark.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
menuDark.BackgroundTransparency = 0.6
menuDark.BorderSizePixel = 0
menuDark.ZIndex = 1
menuDark.Parent = menu
corner(menuDark, 14)

local uiScale = Instance.new("UIScale")
uiScale.Scale = 0
uiScale.Parent = menu

local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 44)
header.BackgroundColor3 = COLORS.accent
header.BorderSizePixel = 0
header.ZIndex = 3
header.Parent = menu
corner(header, 14)
gradient(header, COLORS.accent, COLORS.accentDark, 0)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -140, 1, 0)
title.Position = UDim2.new(0, 12, 0, -2)
title.BackgroundTransparency = 1
title.Text = "MAKAZI MOD v8"
title.TextColor3 = Color3.fromRGB(255,255,255)
title.TextSize = 15
title.Font = FONT_BOLD
title.TextXAlignment = Enum.TextXAlignment.Left
title.ZIndex = 4
title.Parent = header

local fpsLbl = Instance.new("TextLabel")
fpsLbl.Size = UDim2.new(0, 100, 1, 0)
fpsLbl.Position = UDim2.new(0, 12, 0, 14)
fpsLbl.BackgroundTransparency = 1
fpsLbl.Text = "ФПС: --"
fpsLbl.TextColor3 = Color3.fromRGB(255, 220, 220)
fpsLbl.TextSize = 9
fpsLbl.Font = FONT
fpsLbl.TextXAlignment = Enum.TextXAlignment.Left
fpsLbl.ZIndex = 4
fpsLbl.Parent = header

task.spawn(function()
    local frames = 0
    local lastUpdate = tick()
    RunService.RenderStepped:Connect(function()
        frames = frames + 1
        if tick() - lastUpdate >= 0.5 then
            fpsLbl.Text = "ФПС: " .. math.floor(frames / (tick() - lastUpdate))
            frames = 0
            lastUpdate = tick()
        end
    end)
end)

local minBtn = Instance.new("TextButton")
minBtn.Size = UDim2.new(0, 28, 0, 28)
minBtn.Position = UDim2.new(1, -66, 0.5, -14)
minBtn.BackgroundColor3 = Color3.fromRGB(255,255,255)
minBtn.BackgroundTransparency = 0.85
minBtn.Text = "—"
minBtn.TextColor3 = Color3.fromRGB(255,255,255)
minBtn.TextSize = 18
minBtn.Font = FONT_BOLD
minBtn.AutoButtonColor = false
minBtn.ZIndex = 4
minBtn.Parent = header
corner(minBtn, UDim.new(1, 0))

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 28, 0, 28)
closeBtn.Position = UDim2.new(1, -34, 0.5, -14)
closeBtn.BackgroundColor3 = Color3.fromRGB(255,255,255)
closeBtn.BackgroundTransparency = 0.85
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(255,255,255)
closeBtn.TextSize = 14
closeBtn.Font = FONT_BOLD
closeBtn.AutoButtonColor = false
closeBtn.ZIndex = 4
closeBtn.Parent = header
corner(closeBtn, UDim.new(1, 0))

-- ТАБЫ
local tabBar = Instance.new("Frame")
tabBar.Size = UDim2.new(1, -16, 0, 30)
tabBar.Position = UDim2.new(0, 8, 0, 50)
tabBar.BackgroundColor3 = COLORS.bgLight
tabBar.BackgroundTransparency = 0.2
tabBar.BorderSizePixel = 0
tabBar.ZIndex = 3
tabBar.Parent = menu
corner(tabBar, 8)

local tabLayout = Instance.new("UIListLayout")
tabLayout.FillDirection = Enum.FillDirection.Horizontal
tabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
tabLayout.VerticalAlignment = Enum.VerticalAlignment.Center
tabLayout.Padding = UDim.new(0, 3)
tabLayout.Parent = tabBar

local pages = {}
local tabButtons = {}

local function selectTab(name)
    for n, c in pairs(pages) do c.Visible = (n == name) end
    for n, b in pairs(tabButtons) do
        TweenService:Create(b, TweenInfo.new(0.2),
            { BackgroundColor3 = (n == name) and COLORS.accent or COLORS.card }):Play()
    end
end

local function makeTab(name, icon)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 46, 0, 24)
    btn.BackgroundColor3 = COLORS.card
    btn.Text = icon
    btn.TextColor3 = COLORS.text
    btn.TextSize = 13
    btn.Font = FONT_BOLD
    btn.AutoButtonColor = false
    btn.ZIndex = 4
    btn.Parent = tabBar
    corner(btn, 6)
    tabButtons[name] = btn

    local page = Instance.new("ScrollingFrame")
    page.Size = UDim2.new(1, -16, 1, -88)
    page.Position = UDim2.new(0, 8, 0, 84)
    page.BackgroundTransparency = 1
    page.BorderSizePixel = 0
    page.ScrollBarThickness = 3
    page.ScrollBarImageColor3 = COLORS.accent
    page.CanvasSize = UDim2.new(0, 0, 0, 0)
    page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    page.ScrollingDirection = Enum.ScrollingDirection.Y
    page.Visible = false
    page.ZIndex = 3
    page.Parent = menu
    page.ClipsDescendants = true

    local lay = Instance.new("UIListLayout")
    lay.Padding = UDim.new(0, 5)
    lay.SortOrder = Enum.SortOrder.LayoutOrder
    lay.Parent = page

    pages[name] = page
    btn.MouseButton1Click:Connect(function() clickSound() selectTab(name) end)
    return page
end

local function sectionLabel(parent, text)
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1, 0, 0, 14)
    l.BackgroundTransparency = 1
    l.Text = "▸ " .. text:upper()
    l.TextColor3 = COLORS.accentGlow
    l.TextSize = 9
    l.Font = FONT_BOLD
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.ZIndex = 4
    l.Parent = parent
    return l
end

local function makeButton(parent, text, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 34)
    btn.BackgroundColor3 = COLORS.card
    btn.BackgroundTransparency = 0.1
    btn.BorderSizePixel = 0
    btn.Text = text
    btn.TextColor3 = COLORS.text
    btn.TextSize = 11
    btn.Font = FONT_BOLD
    btn.AutoButtonColor = false
    btn.ZIndex = 4
    btn.Parent = parent
    corner(btn, 7)
    btn.MouseButton1Click:Connect(function() clickSound() pcall(callback) end)
    return btn
end

local function makeToggle(parent, text, default, callback)
    local state = default or false
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 36)
    btn.BackgroundColor3 = COLORS.card
    btn.BackgroundTransparency = 0.1
    btn.BorderSizePixel = 0
    btn.Text = ""
    btn.AutoButtonColor = false
    btn.ZIndex = 4
    btn.Parent = parent
    corner(btn, 7)

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -80, 1, 0)
    lbl.Position = UDim2.new(0, 10, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = COLORS.text
    lbl.TextSize = 11
    lbl.Font = FONT
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.ZIndex = 5
    lbl.Parent = btn

    local ind = Instance.new("Frame")
    ind.Size = UDim2.new(0, 38, 0, 20)
    ind.Position = UDim2.new(1, -46, 0.5, -10)
    ind.BackgroundColor3 = state and COLORS.accent or Color3.fromRGB(60, 60, 72)
    ind.BorderSizePixel = 0
    ind.ZIndex = 5
    ind.Parent = btn
    corner(ind, UDim.new(1, 0))

    local dot = Instance.new("Frame")
    dot.Size = UDim2.new(0, 14, 0, 14)
    dot.Position = state and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 3, 0.5, -7)
    dot.BackgroundColor3 = Color3.fromRGB(255,255,255)
    dot.BorderSizePixel = 0
    dot.ZIndex = 6
    dot.Parent = ind
    corner(dot, UDim.new(1, 0))

    btn.MouseButton1Click:Connect(function()
        state = not state
        if state then toggleOn() else toggleOff() end
        TweenService:Create(ind, TweenInfo.new(0.2),
            { BackgroundColor3 = state and COLORS.accent or Color3.fromRGB(60,60,72) }):Play()
        TweenService:Create(dot, TweenInfo.new(0.2, Enum.EasingStyle.Quart),
            { Position = state and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 3, 0.5, -7) }):Play()
        pcall(callback, state)
    end)
    return btn
end

local function makeSlider(parent, text, min, max, default, callback)
    local value = default or min
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 52)
    frame.BackgroundColor3 = COLORS.card
    frame.BackgroundTransparency = 0.1
    frame.BorderSizePixel = 0
    frame.ZIndex = 4
    frame.Parent = parent
    corner(frame, 7)

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -70, 0, 16)
    label.Position = UDim2.new(0, 10, 0, 4)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = COLORS.text
    label.TextSize = 11
    label.Font = FONT
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 5
    label.Parent = frame

    local valueLbl = Instance.new("TextLabel")
    valueLbl.Size = UDim2.new(0, 50, 0, 16)
    valueLbl.Position = UDim2.new(1, -60, 0, 4)
    valueLbl.BackgroundTransparency = 1
    valueLbl.Text = tostring(value)
    valueLbl.TextColor3 = COLORS.accent
    valueLbl.TextSize = 11
    valueLbl.Font = FONT_BOLD
    valueLbl.TextXAlignment = Enum.TextXAlignment.Right
    valueLbl.ZIndex = 5
    valueLbl.Parent = frame

    local bar = Instance.new("Frame")
    bar.Size = UDim2.new(1, -20, 0, 6)
    bar.Position = UDim2.new(0, 10, 0, 30)
    bar.BackgroundColor3 = Color3.fromRGB(55, 55, 68)
    bar.BorderSizePixel = 0
    bar.ZIndex = 5
    bar.Parent = frame
    corner(bar, UDim.new(1, 0))

    local fill = Instance.new("Frame")
    fill.Size = UDim2.new((value - min) / (max - min), 0, 1, 0)
    fill.BackgroundColor3 = COLORS.accent
    fill.BorderSizePixel = 0
    fill.ZIndex = 6
    fill.Parent = bar
    corner(fill, UDim.new(1, 0))

    local hitbox = Instance.new("TextButton")
    hitbox.Size = UDim2.new(1, 0, 0, 32)
    hitbox.Position = UDim2.new(0, 0, 0, 20)
    hitbox.BackgroundTransparency = 1
    hitbox.Text = ""
    hitbox.ZIndex = 8
    hitbox.Parent = frame

    local dragging = false
    local function update(x)
        local rel = math.clamp((x - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
        value = math.floor(min + rel * (max - min) + 0.5)
        local p = (value - min) / (max - min)
        fill.Size = UDim2.new(p, 0, 1, 0)
        valueLbl.Text = tostring(value)
        pcall(callback, value)
    end

    hitbox.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            update(input.Position.X)
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) then
            update(input.Position.X)
        end
    end)
    pcall(callback, value)
end

-- ПЕРЕМЕННЫЕ
local flyEnabled, flySpeed = false, 60
local flyVel, flyAlign, flyAttach, flyConn
local savedWalkSpeed

local aimEnabled = false
local aimSmooth = 0.25
local aimFOV = 500
local aimCurrentTarget = nil
local aimPrediction = true

local noclipEnabled = false
local godEnabled = false
local infJumpEnabled = false
local doubleJumpOn = false
local doubleJumpUsed = false
local antiAfkEnabled = false
local autoSprintEnabled = false
local antiFlingEnabled = false
local killAllOn = false
local killDelay = 0.15
local flingRange = 12
local flingPower = 500
local boatEnabled = false
local boatModel = nil
local boatHull = nil
local boatVel = nil
local boatPos = nil
local boatAlign = nil
local boatAttach = nil
local boatSpeed = 120
local boatHeight = 8

-- FLY
local function stopFly()
    flyEnabled = false
    if flyVel then flyVel:Destroy() flyVel = nil end
    if flyAlign then flyAlign:Destroy() flyAlign = nil end
    if flyAttach then flyAttach:Destroy() flyAttach = nil end
    if flyConn then flyConn:Disconnect() flyConn = nil end
    local char = player.Character
    if char then
        for _, p in ipairs(char:GetDescendants()) do
            if p:IsA("BasePart") then p.CanCollide = true end
        end
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then hum.WalkSpeed = savedWalkSpeed or 16 end
    end
end

local function startFly()
    local char = player.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if not hrp or not hum then return end

    flyEnabled = true
    savedWalkSpeed = hum.WalkSpeed
    hum.WalkSpeed = 0
    for _, p in ipairs(char:GetDescendants()) do
        if p:IsA("BasePart") then p.CanCollide = false end
    end

    flyAttach = Instance.new("Attachment")
    flyAttach.Parent = hrp

    flyVel = Instance.new("LinearVelocity")
    flyVel.Attachment0 = flyAttach
    flyVel.MaxForce = math.huge
    flyVel.VectorVelocity = Vector3.zero
    flyVel.RelativeTo = Enum.ActuatorRelativeTo.World
    flyVel.Parent = hrp

    flyAlign = Instance.new("AlignOrientation")
    flyAlign.Attachment0 = flyAttach
    flyAlign.Mode = Enum.OrientationAlignmentMode.OneAttachment
    flyAlign.MaxTorque = math.huge
    flyAlign.Responsiveness = 200
    flyAlign.Parent = hrp

    flyConn = RunService.Heartbeat:Connect(function()
        if not flyVel or not flyVel.Parent then return end
        local ch = player.Character
        local root = ch and ch:FindFirstChild("HumanoidRootPart")
        local h = ch and ch:FindFirstChildOfClass("Humanoid")
        if not root or not h then return end

        local camera = workspace.CurrentCamera
        local look = camera.CFrame.LookVector
        local right = camera.CFrame.RightVector
        local up = Vector3.new(0, 1, 0)
        local move = Vector3.zero

        if UserInputService:IsKeyDown(Enum.KeyCode.W) then move += look end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then move -= look end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then move += right end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then move -= right end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then move += up end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then move -= up end

        if move.Magnitude < 0.05 then
            local md = h.MoveDirection
            if md.Magnitude > 0.05 then
                local flat = Vector3.new(md.X, 0, md.Z)
                if flat.Magnitude > 0.01 then move += flat.Unit end
                move += Vector3.new(0, look.Y, 0)
            end
        end

        if move.Magnitude > 0 then
            flyVel.VectorVelocity = move.Unit * flySpeed
        else
            flyVel.VectorVelocity = Vector3.zero
        end
        flyAlign.CFrame = CFrame.new(root.Position, root.Position + look)
    end)
end

-- AIMBOT
local function isAlive(char)
    if not char then return false end
    local hum = char:FindFirstChildOfClass("Humanoid")
    return hum and hum.Health > 0
end

RunService.RenderStepped:Connect(function()
    if not aimEnabled then return end
    local myChar = player.Character
    local myHead = myChar and (myChar:FindFirstChild("Head") or myChar:FindFirstChild("HumanoidRootPart"))
    if not myHead then return end
    local camera = workspace.CurrentCamera
    if not camera then return end

    if aimCurrentTarget and (not aimCurrentTarget.Parent or not isAlive(aimCurrentTarget.Parent)) then
        aimCurrentTarget = nil
    end

    local best, bestScore = nil, math.huge
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= player and p.Character and isAlive(p.Character) then
            local head = p.Character:FindFirstChild("Head") or p.Character:FindFirstChild("HumanoidRootPart")
            if head then
                local dist = (head.Position - myHead.Position).Magnitude
                if dist <= aimFOV and dist < bestScore then
                    bestScore = dist
                    best = head
                end
            end
        end
    end

    if best then aimCurrentTarget = best end
    local target = aimCurrentTarget
    if target and target.Parent then
        local pos = target.Position
        if aimPrediction then
            local vel = target.AssemblyLinearVelocity or Vector3.zero
            pos = pos + vel * 0.1
        end
        local targetCF = CFrame.new(camera.CFrame.Position, pos)
        camera.CFrame = camera.CFrame:Lerp(targetCF, aimSmooth)
    end
end)

-- NOCLIP
RunService.Stepped:Connect(function()
    if not noclipEnabled then return end
    local char = player.Character
    if not char then return end
    for _, part in ipairs(char:GetDescendants()) do
        if part:IsA("BasePart") and part.CanCollide then part.CanCollide = false end
    end
end)

-- GOD
task.spawn(function()
    while task.wait(0.2) do
        if godEnabled then
            local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
            if hum then hum.MaxHealth = math.huge; hum.Health = math.huge end
        end
    end
end)

-- DOUBLE JUMP
task.spawn(function()
    while task.wait(0.05) do
        local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
        if hum and hum.FloorMaterial ~= Enum.Material.Air then doubleJumpUsed = false end
    end
end)

UserInputService.JumpRequest:Connect(function()
    local char = player.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return end
    if infJumpEnabled then
        hum:ChangeState(Enum.HumanoidStateType.Jumping)
    elseif doubleJumpOn then
        local inAir = hum.FloorMaterial == Enum.Material.Air
        if inAir and not doubleJumpUsed then
            hum:ChangeState(Enum.HumanoidStateType.Jumping)
            doubleJumpUsed = true
        end
    end
end)

-- ANTI-AFK
player.Idled:Connect(function()
    if antiAfkEnabled then
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end
end)

-- AUTO SPRINT
task.spawn(function()
    while task.wait(0.1) do
        if autoSprintEnabled then
            local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
            if hum and hum.MoveDirection.Magnitude > 0.1 then
                hum.WalkSpeed = math.max(hum.WalkSpeed, 30)
            end
        end
    end
end)

-- KILL ALL
task.spawn(function()
    while task.wait(0.5) do
        if killAllOn then
            local char = player.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            if hrp and hum then
                local tool
                for _, t in ipairs(char:GetChildren()) do
                    if t:IsA("Tool") then tool = t break end
                end
                if tool then
                    pcall(function() hum:EquipTool(tool) end)
                    for _, p in ipairs(Players:GetPlayers()) do
                        if p ~= player and p.Character then
                            local tr = p.Character:FindFirstChild("HumanoidRootPart")
                            local th = p.Character:FindFirstChildOfClass("Humanoid")
                            if tr and th and th.Health > 0 then
                                hrp.CFrame = CFrame.new(tr.Position + Vector3.new(0, 0, 2))
                                task.wait(killDelay)
                                pcall(function() tool:Activate() end)
                                task.wait(killDelay)
                            end
                        end
                    end
                end
            end
        end
    end
end)

-- FLING
local function flingPlayer(target)
    if not target or target == player then return false end
    local myChar = player.Character
    local myHRP = myChar and myChar:FindFirstChild("HumanoidRootPart")
    local tChar = target.Character
    local tHRP = tChar and tChar:FindFirstChild("HumanoidRootPart")
    local tHum = tChar and tChar:FindFirstChildOfClass("Humanoid")
    if not myHRP or not tHRP or not tHum or tHum.Health <= 0 then return false end

    local savedCF = myHRP.CFrame
    local savedVel = myHRP.AssemblyLinearVelocity
    pcall(function() myHRP.CFrame = tHRP.CFrame * CFrame.new(0, 0, 1.5) end)

    local weld = Instance.new("WeldConstraint")
    weld.Part0 = myHRP
    weld.Part1 = tHRP
    weld.Parent = myHRP
    task.wait(0.03)

    local dir = Vector3.new((math.random()-0.5)*2, 1, (math.random()-0.5)*2).Unit
    pcall(function()
        myHRP.AssemblyLinearVelocity = dir * flingPower * 10
        myHRP.AssemblyAngularVelocity = Vector3.new(9e9, 9e9, 9e9)
    end)
    task.wait(0.08)
    pcall(function() weld:Destroy() end)
    task.wait(0.02)
    pcall(function()
        myHRP.CFrame = savedCF
        myHRP.AssemblyLinearVelocity = savedVel
    end)
    return true
end

local function getNearestPlayer(range)
    local myHRP = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if not myHRP then return nil end
    local nearest, nd = nil, range
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= player and p.Character then
            local hrp = p.Character:FindFirstChild("HumanoidRootPart")
            local hum = p.Character:FindFirstChildOfClass("Humanoid")
            if hrp and hum and hum.Health > 0 then
                local d = (hrp.Position - myHRP.Position).Magnitude
                if d < nd then nd = d; nearest = p end
            end
        end
    end
    return nearest
end

-- BOAT
local function destroyBoat()
    if boatModel then pcall(function() boatModel:Destroy() end) boatModel = nil end
    if boatVel then boatVel:Destroy() boatVel = nil end
    if boatPos then boatPos:Destroy() boatPos = nil end
    if boatAlign then boatAlign:Destroy() boatAlign = nil end
    if boatAttach then boatAttach:Destroy() boatAttach = nil end
    boatHull = nil
end

local function buildBoat()
    local char = player.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local baseCF = CFrame.new(hrp.Position + Vector3.new(0, boatHeight, 0))
    local model = Instance.new("Model")
    model.Name = "MakaziBoat"
    model.Parent = workspace

    local boatParts = {}
    local function mk(size, cf, color)
        local p = Instance.new("Part")
        p.Size = size
        p.CFrame = cf
        p.Color = color
        p.Material = Enum.Material.WoodPlanks
        p.Anchored = false
        p.Massless = true
        p.Parent = model
        table.insert(boatParts, p)
        return p
    end

    local hull = mk(Vector3.new(9, 3, 24), baseCF, Color3.fromRGB(75, 45, 20))
    mk(Vector3.new(8, 1.5, 22), baseCF * CFrame.new(0, -2, 0), Color3.fromRGB(75, 45, 20))
    mk(Vector3.new(5, 3, 8), baseCF * CFrame.new(0, 0, -15), Color3.fromRGB(120, 75, 35))
    mk(Vector3.new(10, 4, 5), baseCF * CFrame.new(0, 0.5, 14), Color3.fromRGB(120, 75, 35))
    mk(Vector3.new(8.5, 0.6, 22), baseCF * CFrame.new(0, 1.8, -1), Color3.fromRGB(180, 120, 65))
    mk(Vector3.new(0.5, 3, 24), baseCF * CFrame.new(-4.5, 3, 0), Color3.fromRGB(120, 75, 35))
    mk(Vector3.new(0.5, 3, 24), baseCF * CFrame.new(4.5, 3, 0), Color3.fromRGB(120, 75, 35))

    local mast = mk(Vector3.new(18, 0.8, 0.8), baseCF * CFrame.new(0, 10, 0) * CFrame.Angles(0, 0, math.rad(90)), Color3.fromRGB(75, 45, 20))
    mast.Shape = Enum.PartType.Cylinder
    mk(Vector3.new(0.2, 14, 10), baseCF * CFrame.new(0, 11, 0), Color3.fromRGB(240, 235, 220))
    mk(Vector3.new(0.1, 3, 5), baseCF * CFrame.new(0, 16, 3), Color3.fromRGB(220, 40, 50))

    for _, p in ipairs(boatParts) do
        if p ~= hull then
            local w = Instance.new("WeldConstraint")
            w.Part0 = hull
            w.Part1 = p
            w.Parent = p
        end
    end
    model.PrimaryPart = hull

    boatAttach = Instance.new("Attachment")
    boatAttach.Parent = hull
    boatVel = Instance.new("LinearVelocity")
    boatVel.Attachment0 = boatAttach
    boatVel.MaxForce = math.huge
    boatVel.VectorVelocity = Vector3.zero
    boatVel.RelativeTo = Enum.ActuatorRelativeTo.World
    boatVel.Parent = hull

    boatPos = Instance.new("AlignPosition")
    boatPos.Attachment0 = boatAttach
    boatPos.Mode = Enum.PositionAlignmentMode.OneAttachment
    boatPos.Position = baseCF.Position
    boatPos.MaxForce = 1e6
    boatPos.Responsiveness = 12
    boatPos.Parent = hull

    boatAlign = Instance.new("AlignOrientation")
    boatAlign.Attachment0 = boatAttach
    boatAlign.Mode = Enum.OrientationAlignmentMode.OneAttachment
    boatAlign.MaxTorque = 1e8
    boatAlign.Parent = hull

    boatModel = model
    boatHull = hull

    task.wait(0.1)
    local newHrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if newHrp then newHrp.CFrame = CFrame.new(baseCF.Position + Vector3.new(0, 3.5, 3)) end
end

local function startBoat()
    destroyBoat()
    buildBoat()
    boatEnabled = true
    notify("Корабль ⛵", true)

    RunService.Heartbeat:Connect(function()
        if not boatEnabled or not boatVel or not boatVel.Parent or not boatHull then return end
        local camera = workspace.CurrentCamera
        local look = camera.CFrame.LookVector
        local right = camera.CFrame.RightVector
        local move = Vector3.zero
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then move += look end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then move -= look end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then move += right end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then move -= right end
        local flat = Vector3.new(move.X, 0, move.Z)
        if flat.Magnitude > 0 then
            boatVel.VectorVelocity = flat.Unit * boatSpeed
            boatAlign.CFrame = CFrame.new(boatHull.Position, boatHull.Position + flat.Unit)
        else
            boatVel.VectorVelocity = Vector3.zero
        end
        boatHull.AssemblyAngularVelocity = Vector3.zero
    end)
end

local function stopBoat()
    boatEnabled = false
    destroyBoat()
    notify("Корабль исчез", false)
end

-- ТАБЫ
local tabMain = makeTab("Главное", "🏠")
local tabVisual = makeTab("Визуал", "👁")
local tabFun = makeTab("Фан", "🎉")
local tabMisc = makeTab("Прочее", "⚙")

-- ГЛАВНОЕ
sectionLabel(tabMain, "Движение")
makeSlider(tabMain, "Скорость (множитель)", 1, 10, 1, function(v)
    local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
    if hum then hum.WalkSpeed = 16 * v end
end)
makeSlider(tabMain, "Сила прыжка", 50, 500, 50, function(v)
    local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
    if hum then hum.UseJumpPower = true; hum.JumpPower = v end
end)
makeToggle(tabMain, "🦘  Бесконечный прыжок", false, function(s)
    infJumpEnabled = s
end)
makeToggle(tabMain, "🦘  Двойной прыжок", false, function(s)
    doubleJumpOn = s
    doubleJumpUsed = false
end)
makeToggle(tabMain, "🏃  Авто-бег", false, function(s)
    autoSprintEnabled = s
end)

sectionLabel(tabMain, "Полёт")
makeToggle(tabMain, "✈  Полёт", false, function(s)
    if s then startFly() notify("Полёт вкл", true) else stopFly() notify("Полёт выкл", false) end
end)
makeSlider(tabMain, "Скорость полёта", 20, 300, 60, function(v) flySpeed = v end)

sectionLabel(tabMain, "Бой")
makeToggle(tabMain, "⚔  Kill All", false, function(s) killAllOn = s end)
makeSlider(tabMain, "Задержка удара", 1, 30, 15, function(v) killDelay = v / 100 end)

sectionLabel(tabMain, "Физика")
makeToggle(tabMain, "🚪  Noclip", false, function(s) noclipEnabled = s end)
makeToggle(tabMain, "🛡  God", false, function(s) godEnabled = s end)
makeToggle(tabMain, "🕐  Anti-AFK", false, function(s) antiAfkEnabled = s end)
makeToggle(tabMain, "🛡  Anti-Fling", false, function(s) antiFlingEnabled = s end)

-- ВИЗУАЛ
sectionLabel(tabVisual, "Бой")
makeToggle(tabVisual, "🎯  Автонаведение", false, function(s)
    aimEnabled = s
    if not s then aimCurrentTarget = nil end
end)
makeSlider(tabVisual, "Плавность", 1, 20, 4, function(v) aimSmooth = 0.9 / v end)
makeSlider(tabVisual, "Дистанция", 50, 2000, 500, function(v) aimFOV = v end)

-- ФАН
sectionLabel(tabFun, "Шутки")
makeToggle(tabFun, "👻  Невидимость", false, function(s) _G.MakaziInvis = s end)
makeToggle(tabFun, "🌈  Радуга", false, function(s) _G.MakaziRainbow = s end)
makeToggle(tabFun, "🐰  Bunny Hop", false, function(s) _G.MakaziBunny = s end)

sectionLabel(tabFun, "Флинг")
makeButton(tabFun, "💥  FLING ALL", function()
    task.spawn(function()
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= player and p.Character then
                local hum = p.Character:FindFirstChildOfClass("Humanoid")
                if hum and hum.Health > 0 then flingPlayer(p) task.wait(0.12) end
            end
        end
        notify("Готово", true)
    end)
end)
makeButton(tabFun, "🎯  FLING ближайшего", function()
    local t = getNearestPlayer(flingRange)
    if t then task.spawn(function() flingPlayer(t) end) end
end)

sectionLabel(tabFun, "Корабль")
makeToggle(tabFun, "⛵  Построить корабль", false, function(s)
    if s then startBoat() else stopBoat() end
end)
makeSlider(tabFun, "Скорость", 20, 400, 120, function(v) boatSpeed = v end)

-- ПРОЧЕЕ
sectionLabel(tabMisc, "Действия")
makeButton(tabMisc, "🔄  Возродиться", function()
    if player.Character then player.Character:BreakJoints() end
end)
makeButton(tabMisc, "⬆  ТП вверх", function()
    local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if hrp then hrp.CFrame += Vector3.new(0, 50, 0) end
end)
makeButton(tabMisc, "🔁  Rejoin", function()
    pcall(function() TeleportService:Teleport(game.PlaceId, player) end)
end)

-- ЛОГИКА ФАН
task.spawn(function()
    while task.wait(0.3) do
        if _G.MakaziInvis then
            local char = player.Character
            if char then
                for _, p in ipairs(char:GetDescendants()) do
                    if p:IsA("BasePart") and p.Name ~= "HumanoidRootPart" then
                        p.LocalTransparencyModifier = 1
                    end
                end
            end
        end
    end
end)

task.spawn(function()
    while task.wait(0.08) do
        if _G.MakaziRainbow then
            local char = player.Character
            if char then
                local c = Color3.fromHSV(tick() % 1, 1, 1)
                for _, p in ipairs(char:GetDescendants()) do
                    if p:IsA("BasePart") then pcall(function() p.Color = c end) end
                end
            end
        end
    end
end)

task.spawn(function()
    while task.wait(0.05) do
        if _G.MakaziBunny then
            local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
            if hum and hum.MoveDirection.Magnitude > 0.1 and hum.FloorMaterial ~= Enum.Material.Air then
                hum:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end
    end
end)

-- МОБИЛЬНЫЕ КНОПКИ
local touchHolder = Instance.new("Frame")
touchHolder.Size = UDim2.new(0, 200, 0, 160)
touchHolder.Position = UDim2.new(0, 15, 1, -250)
touchHolder.BackgroundTransparency = 1
touchHolder.ZIndex = 55
touchHolder.Parent = gui

local function makeTouchBtn(text, size, pos, color, callback)
    local btn = Instance.new("TextButton")
    btn.Size = size
    btn.Position = pos
    btn.BackgroundColor3 = color
    btn.BackgroundTransparency = 0.15
    btn.BorderSizePixel = 0
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.TextSize = 14
    btn.Font = FONT_BOLD
    btn.AutoButtonColor = false
    btn.ZIndex = 60
    btn.Parent = touchHolder
    corner(btn, UDim.new(1, 0))
    stroke(btn, Color3.fromRGB(255,255,255), 1.5, 0.5)
    btn.MouseButton1Click:Connect(function() clickSound() pcall(callback) end)
    return btn
end

makeTouchBtn("✈\nFLY", UDim2.new(0,70,0,70), UDim2.new(0,0,0,0), COLORS.accent, function()
    if flyEnabled then stopFly() notify("Полёт выкл", false) else startFly() notify("Полёт вкл", true) end
end)
makeTouchBtn("💥\nFLING", UDim2.new(0,70,0,70), UDim2.new(0,80,0,0), Color3.fromRGB(200,60,60), function()
    local t = getNearestPlayer(flingRange)
    if t then task.spawn(function() flingPlayer(t) end) end
end)
makeTouchBtn("⛵\nBOAT", UDim2.new(0,70,0,70), UDim2.new(0,0,0,80), Color3.fromRGB(80,130,200), function()
    if boatEnabled then stopBoat() else startBoat() end
end)
makeTouchBtn("🎯\nAIM", UDim2.new(0,70,0,70), UDim2.new(0,80,0,80), Color3.fromRGB(80,180,80), function()
    aimEnabled = not aimEnabled
    if not aimEnabled then aimCurrentTarget = nil end
    notify(aimEnabled and "Aim вкл" or "Aim выкл", aimEnabled)
end)

-- ОТКРЫТИЕ/ЗАКРЫТИЕ
local opened = false

local function openMenu()
    if opened then return end
    opened = true
    openSound()
    menu.Visible = true
    uiScale.Scale = 0
    TweenService:Create(uiScale, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
        { Scale = 1 }):Play()
end

local function closeMenu()
    if not opened then return end
    opened = false
    closeSound()
    local t = TweenService:Create(uiScale, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.In),
        { Scale = 0 })
    t:Play()
    t.Completed:Connect(function() menu.Visible = false end)
end

-- Нажатие на кружок
local circleTouched = false
circle.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        circleTouched = true
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End and circleTouched then
                circleTouched = false
                if opened then closeMenu() else openMenu() end
            end
        end)
    end
end)

closeBtn.MouseButton1Click:Connect(closeMenu)
minBtn.MouseButton1Click:Connect(function()
    menu.Size = (menu.Size.Y.Offset == 44) and UDim2.new(0, 280, 0, 340) or UDim2.new(0, 280, 0, 44)
end)

selectTab("Главное")
task.delay(1, function()
    notify("Makazi Mod загружен ✅", true)
    print("[MAKAZI] Всё готово!")
end)

--==========================================================
--   MAKAZI MOD  •  v13.0  •  Enhanced
--==========================================================
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")
local TS = game:GetService("TweenService")
local CG = game:GetService("CoreGui")
local Lighting = game:GetService("Lighting")
local IS = game:GetService("InsertService")
local VU = game:GetService("VirtualUser")
local VIM
pcall(function() VIM = game:GetService("VirtualInputManager") end)

local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

print("[Makazi v13] Запуск...")

pcall(function()
    local old = CG:FindFirstChild("MakaziMod")
    if old then old:Destroy() end
end)

local guiParent = player:WaitForChild("PlayerGui", 10)
if not guiParent then guiParent = player.PlayerGui end
print("[Makazi] GUI Parent:", guiParent and guiParent.Name or "NIL")

local gui = Instance.new("ScreenGui")
gui.Name = "MakaziMod"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.DisplayOrder = 999999
gui.Parent = guiParent

local ACCENT = Color3.fromRGB(255, 45, 65)
local ACCENT_DARK = Color3.fromRGB(140, 10, 25)
local ACCENT_GLOW = Color3.fromRGB(255, 140, 160)
local BG = Color3.fromRGB(10, 10, 16)
local BG_LIGHT = Color3.fromRGB(20, 20, 28)
local BG_CARD = Color3.fromRGB(28, 28, 38)
local BG_HOVER = Color3.fromRGB(40, 40, 52)
local BORDER = Color3.fromRGB(60, 60, 80)
local TEXT = Color3.fromRGB(250, 250, 255)
local SUCCESS = Color3.fromRGB(80, 220, 120)
local FB = Enum.Font.GothamBold
local FM = Enum.Font.GothamMedium
local SAHUR_ID = "rbxassetid://114192207711666"

local function corner(o, r)
    local c = Instance.new("UICorner")
    c.CornerRadius = typeof(r) == "number" and UDim.new(0, r) or r
    c.Parent = o
end

local function stroke(o, clr, th, tr)
    local s = Instance.new("UIStroke")
    s.Color = clr
    s.Thickness = th or 1.5
    s.Transparency = tr or 0
    s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    s.Parent = o
end

local function grad(o, c1, c2, rot)
    local g = Instance.new("UIGradient")
    g.Color = ColorSequence.new(c1, c2)
    g.Rotation = rot or 90
    g.Parent = o
end

local notifH = Instance.new("Frame")
notifH.Size = UDim2.new(0, 230, 1, -40)
notifH.Position = UDim2.new(1, -240, 0, 20)
notifH.BackgroundTransparency = 1
notifH.ZIndex = 100
notifH.Parent = gui

local nL = Instance.new("UIListLayout")
nL.Padding = UDim.new(0, 6)
nL.VerticalAlignment = Enum.VerticalAlignment.Bottom
nL.Parent = notifH

local function notify(text, ok)
    local c = Instance.new("Frame")
    c.Size = UDim2.new(1, 0, 0, 40)
    c.BackgroundColor3 = BG_CARD
    c.BorderSizePixel = 0
    c.ZIndex = 101
    c.Parent = notifH
    corner(c, 8)
    stroke(c, ok and SUCCESS or ACCENT, 1.5, 0.3)

    local bar = Instance.new("Frame")
    bar.Size = UDim2.new(0, 4, 1, -10)
    bar.Position = UDim2.new(0, 5, 0, 5)
    bar.BackgroundColor3 = ok and SUCCESS or ACCENT
    bar.BorderSizePixel = 0
    bar.ZIndex = 102
    bar.Parent = c
    corner(bar, 2)

    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1, -18, 1, 0)
    l.Position = UDim2.new(0, 14, 0, 0)
    l.BackgroundTransparency = 1
    l.Text = text
    l.TextColor3 = TEXT
    l.TextSize = 11
    l.Font = FB
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.TextTruncate = Enum.TextTruncate.AtEnd
    l.ZIndex = 102
    l.Parent = c

    c.Position = UDim2.new(1, 50, 0, 0)
    TS:Create(c, TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2.new(0,0,0,0)}):Play()

    task.delay(2.5, function()
        if c then
            local t = TS:Create(c, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.In),
                {Position = UDim2.new(1,50,0,0), BackgroundTransparency = 1})
            t:Play()
            t.Completed:Connect(function() c:Destroy() end)
        end
    end)
end

-- КНОПКА-КРУЖОК
local circleHolder = Instance.new("Frame")
circleHolder.Size = UDim2.new(0, 76, 0, 76)
circleHolder.Position = UDim2.new(0, 30, 0, 150)
circleHolder.BackgroundTransparency = 1
circleHolder.Parent = gui

local pulse1 = Instance.new("Frame")
pulse1.Size = UDim2.new(1, 0, 1, 0)
pulse1.BackgroundColor3 = ACCENT
pulse1.BackgroundTransparency = 0.6
pulse1.BorderSizePixel = 0
pulse1.ZIndex = 0
pulse1.Parent = circleHolder
corner(pulse1, UDim.new(1, 0))

local pulse2 = Instance.new("Frame")
pulse2.Size = UDim2.new(1, 0, 1, 0)
pulse2.BackgroundColor3 = ACCENT
pulse2.BackgroundTransparency = 0.8
pulse2.BorderSizePixel = 0
pulse2.ZIndex = 0
pulse2.Parent = circleHolder
corner(pulse2, UDim.new(1, 0))

local circleBtn = Instance.new("TextButton")
circleBtn.Size = UDim2.new(1, 0, 1, 0)
circleBtn.BackgroundColor3 = ACCENT
circleBtn.Text = ""
circleBtn.AutoButtonColor = false
circleBtn.Active = true
circleBtn.ZIndex = 2
circleBtn.Parent = circleHolder
corner(circleBtn, UDim.new(1, 0))
stroke(circleBtn, Color3.fromRGB(255,255,255), 2.5, 0.2)
grad(circleBtn, ACCENT, ACCENT_DARK, 135)

local circleImg = Instance.new("ImageLabel")
circleImg.Name = "SahurImg"
circleImg.Size = UDim2.new(1, -6, 1, -6)
circleImg.Position = UDim2.new(0, 3, 0, 3)
circleImg.BackgroundTransparency = 1
circleImg.Image = SAHUR_ID
circleImg.ScaleType = Enum.ScaleType.Crop
circleImg.ZIndex = 3
circleImg.Active = false
circleImg.Selectable = false
circleImg.Parent = circleBtn
corner(circleImg, UDim.new(1, 0))

circleImg.ImageFailed:Connect(function()
    circleBtn.Text = "🪵"
    circleBtn.TextColor3 = Color3.fromRGB(255,255,255)
    circleBtn.TextSize = 40
    circleBtn.Font = FB
end)

task.spawn(function()
    while circleBtn.Parent do
        local t1 = TS:Create(pulse1, TweenInfo.new(1.4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
            {Size = UDim2.new(1.5,0,1.5,0), Position = UDim2.new(-0.25,0,-0.25,0), BackgroundTransparency = 0.95})
        local t2 = TS:Create(pulse2, TweenInfo.new(1.4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 0.7),
            {Size = UDim2.new(1.5,0,1.5,0), Position = UDim2.new(-0.25,0,-0.25,0), BackgroundTransparency = 0.95})
        t1:Play()
        t2:Play()
        task.wait(1.4)
    end
end)

-- МЕНЮ
local menu = Instance.new("Frame")
menu.Size = UDim2.new(0, 310, 0, 400)
menu.Position = UDim2.new(0.5, -155, 0.5, -200)
menu.BackgroundColor3 = BG
menu.BorderSizePixel = 0
menu.Visible = false
menu.Active = true
menu.ClipsDescendants = true
menu.Parent = gui
corner(menu, 18)
stroke(menu, ACCENT, 2, 0.3)

local menuBg = Instance.new("ImageLabel")
menuBg.Size = UDim2.new(1, 0, 1, 0)
menuBg.BackgroundTransparency = 1
menuBg.Image = SAHUR_ID
menuBg.ScaleType = Enum.ScaleType.Crop
menuBg.ZIndex = 0
menuBg.Active = false
menuBg.Parent = menu
corner(menuBg, 18)

menuBg.ImageFailed:Connect(function()
    menuBg.Image = ""
    menuBg.BackgroundColor3 = BG_CARD
    menuBg.BackgroundTransparency = 0.3
end)

local menuDark = Instance.new("Frame")
menuDark.Size = UDim2.new(1, 0, 1, 0)
menuDark.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
menuDark.BackgroundTransparency = 0.6
menuDark.BorderSizePixel = 0
menuDark.ZIndex = 1
menuDark.Parent = menu
corner(menuDark, 18)

local topGlow = Instance.new("Frame")
topGlow.Size = UDim2.new(1, -40, 0, 2)
topGlow.Position = UDim2.new(0, 20, 0, 0)
topGlow.BackgroundColor3 = ACCENT_GLOW
topGlow.BackgroundTransparency = 0.3
topGlow.BorderSizePixel = 0
topGlow.ZIndex = 5
topGlow.Parent = menu
corner(topGlow, 2)

local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 54)
header.BackgroundColor3 = ACCENT
header.BorderSizePixel = 0
header.ZIndex = 3
header.Parent = menu
corner(header, 18)
local hGrad = grad(header, ACCENT, ACCENT_DARK, 0)

task.spawn(function()
    while header.Parent do
        hGrad.Rotation = hGrad.Rotation + 0.7
        task.wait(0.03)
    end
end)

local headerIcon = Instance.new("ImageLabel")
headerIcon.Size = UDim2.new(0, 38, 0, 38)
headerIcon.Position = UDim2.new(0, 12, 0, 8)
headerIcon.BackgroundTransparency = 1
headerIcon.Image = SAHUR_ID
headerIcon.ZIndex = 4
headerIcon.Parent = header
corner(headerIcon, 6)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -80, 1, 0)
title.Position = UDim2.new(0, 58, 0, -4)
title.BackgroundTransparency = 1
title.Text = "MAKAZI MOD"
title.TextColor3 = Color3.fromRGB(255,255,255)
title.TextSize = 17
title.Font = FB
title.TextXAlignment = Enum.TextXAlignment.Left
title.ZIndex = 4
title.Parent = header

local fpsLbl = Instance.new("TextLabel")
fpsLbl.Size = UDim2.new(0, 120, 1, 0)
fpsLbl.Position = UDim2.new(0, 58, 0, 18)
fpsLbl.BackgroundTransparency = 1
fpsLbl.Text = "v13  •  ФПС: --"
fpsLbl.TextColor3 = Color3.fromRGB(255,220,220)
fpsLbl.TextSize = 10
fpsLbl.Font = FM
fpsLbl.TextXAlignment = Enum.TextXAlignment.Left
fpsLbl.ZIndex = 4
fpsLbl.Parent = header

task.spawn(function()
    local fr, lu = 0, tick()
    RS.RenderStepped:Connect(function()
        fr = fr + 1
        if tick() - lu >= 0.5 then
            fpsLbl.Text = "v13  •  ФПС: " .. math.floor(fr / (tick() - lu))
            fr, lu = 0, tick()
        end
    end)
end)

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 34, 0, 34)
closeBtn.Position = UDim2.new(1, -42, 0.5, -17)
closeBtn.BackgroundColor3 = Color3.fromRGB(255,255,255)
closeBtn.BackgroundTransparency = 0.85
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(255,255,255)
closeBtn.TextSize = 15
closeBtn.Font = FB
closeBtn.AutoButtonColor = false
closeBtn.ZIndex = 4
closeBtn.Parent = header
corner(closeBtn, UDim.new(1, 0))

local tabBar = Instance.new("Frame")
tabBar.Size = UDim2.new(1, -20, 0, 36)
tabBar.Position = UDim2.new(0, 10, 0, 64)
tabBar.BackgroundColor3 = BG_LIGHT
tabBar.BackgroundTransparency = 0.2
tabBar.BorderSizePixel = 0
tabBar.ZIndex = 3
tabBar.Parent = menu
corner(tabBar, 10)
stroke(tabBar, BORDER, 1, 0.6)

local tabL = Instance.new("UIListLayout")
tabL.FillDirection = Enum.FillDirection.Horizontal
tabL.HorizontalAlignment = Enum.HorizontalAlignment.Center
tabL.VerticalAlignment = Enum.VerticalAlignment.Center
tabL.Padding = UDim.new(0, 4)
tabL.Parent = tabBar

local pages = {}
local tabBtns = {}

local function selectTab(name)
    for n, p in pairs(pages) do
        p.Visible = (n == name)
    end
    for n, b in pairs(tabBtns) do
        TS:Create(b, TweenInfo.new(0.2), {BackgroundColor3 = (n == name) and ACCENT or BG_CARD}):Play()
    end
end

local function makeTab(name, label, icon)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 62, 0, 28)
    btn.BackgroundColor3 = BG_CARD
    btn.Text = ""
    btn.AutoButtonColor = false
    btn.ZIndex = 4
    btn.Parent = tabBar
    corner(btn, 7)

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, 0, 1, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = icon .. " " .. label
    lbl.TextColor3 = TEXT
    lbl.TextSize = 10
    lbl.Font = FB
    lbl.ZIndex = 5
    lbl.Parent = btn

    tabBtns[name] = btn

    local page = Instance.new("ScrollingFrame")
    page.Size = UDim2.new(1, -20, 1, -114)
    page.Position = UDim2.new(0, 10, 0, 106)
    page.BackgroundTransparency = 1
    page.BorderSizePixel = 0
    page.ScrollBarThickness = 4
    page.ScrollBarImageColor3 = ACCENT
    page.CanvasSize = UDim2.new(0, 0, 0, 0)
    page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    page.Visible = false
    page.ZIndex = 3
    page.Parent = menu
    page.ClipsDescendants = true

    local lay = Instance.new("UIListLayout")
    lay.Padding = UDim.new(0, 7)
    lay.Parent = page

    pages[name] = page

    btn.MouseButton1Click:Connect(function()
        selectTab(name)
    end)
    return page
end

local tabMain = makeTab("main", "Главное", "🏠")
local tabMove = makeTab("move", "Движение", "🏃")
local tabVisual = makeTab("visual", "Визуал", "👁")
local tabFun = makeTab("fun", "Фан", "🎉")
local tabMisc = makeTab("misc", "Прочее", "⚙")

local function section(parent, text, icon)
    local holder = Instance.new("Frame")
    holder.Size = UDim2.new(1, 0, 0, 20)
    holder.BackgroundTransparency = 1
    holder.ZIndex = 4
    holder.Parent = parent

    local dot = Instance.new("Frame")
    dot.Size = UDim2.new(0, 6, 0, 6)
    dot.Position = UDim2.new(0, 2, 0.5, -3)
    dot.BackgroundColor3 = ACCENT
    dot.BorderSizePixel = 0
    dot.ZIndex = 5
    dot.Parent = holder
    corner(dot, UDim.new(1, 0))

    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1, -20, 1, 0)
    l.Position = UDim2.new(0, 14, 0, 0)
    l.BackgroundTransparency = 1
    l.Text = text:upper()
    l.TextColor3 = ACCENT_GLOW
    l.TextSize = 10
    l.Font = FB
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.ZIndex = 5
    l.Parent = holder

    local line = Instance.new("Frame")
    line.Size = UDim2.new(1, -14, 0, 1)
    line.Position = UDim2.new(0, 14, 1, -2)
    line.BackgroundColor3 = ACCENT
    line.BackgroundTransparency = 0.7
    line.BorderSizePixel = 0
    line.ZIndex = 5
    line.Parent = holder
end

local function toggle(parent, text, default, cb)
    local state = default or false
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 44)
    btn.BackgroundColor3 = BG_CARD
    btn.BackgroundTransparency = 0.05
    btn.BorderSizePixel = 0
    btn.Text = ""
    btn.AutoButtonColor = false
    btn.ZIndex = 4
    btn.Parent = parent
    corner(btn, 10)
    stroke(btn, BORDER, 1, 0.5)

    local accentBar = Instance.new("Frame")
    accentBar.Size = UDim2.new(0, 4, 0.6, 0)
    accentBar.Position = UDim2.new(0, 0, 0.2, 0)
    accentBar.BackgroundColor3 = state and ACCENT or BORDER
    accentBar.BorderSizePixel = 0
    accentBar.ZIndex = 5
    accentBar.Parent = btn
    corner(accentBar, 2)

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -76, 1, 0)
    lbl.Position = UDim2.new(0, 16, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = TEXT
    lbl.TextSize = 12
    lbl.Font = FM
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.TextTruncate = Enum.TextTruncate.AtEnd
    lbl.ZIndex = 5
    lbl.Parent = btn

    local ind = Instance.new("Frame")
    ind.Size = UDim2.new(0, 46, 0, 24)
    ind.Position = UDim2.new(1, -56, 0.5, -12)
    ind.BackgroundColor3 = state and ACCENT or Color3.fromRGB(50,50,65)
    ind.BorderSizePixel = 0
    ind.ZIndex = 5
    ind.Parent = btn
    corner(ind, UDim.new(1, 0))
    stroke(ind, state and ACCENT_GLOW or BORDER, 1.5, state and 0.3 or 0.5)

    local dot = Instance.new("Frame")
    dot.Size = UDim2.new(0, 18, 0, 18)
    dot.Position = state and UDim2.new(1,-20,0.5,-9) or UDim2.new(0,3,0.5,-9)
    dot.BackgroundColor3 = Color3.fromRGB(255,255,255)
    dot.BorderSizePixel = 0
    dot.ZIndex = 6
    dot.Parent = ind
    corner(dot, UDim.new(1, 0))

    btn.MouseButton1Click:Connect(function()
        state = not state
        TS:Create(ind, TweenInfo.new(0.25), {BackgroundColor3 = state and ACCENT or Color3.fromRGB(50,50,65)}):Play()
        TS:Create(dot, TweenInfo.new(0.3, Enum.EasingStyle.Back),
            {Position = state and UDim2.new(1,-20,0.5,-9) or UDim2.new(0,3,0.5,-9)}):Play()
        TS:Create(accentBar, TweenInfo.new(0.25), {BackgroundColor3 = state and ACCENT or BORDER}):Play()
        pcall(cb, state)
    end)
end

local function slider(parent, text, mn, mx, d, cb)
    local v = d or mn
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1, 0, 0, 58)
    f.BackgroundColor3 = BG_CARD
    f.BackgroundTransparency = 0.05
    f.BorderSizePixel = 0
    f.ZIndex = 4
    f.Parent = parent
    corner(f, 10)
    stroke(f, BORDER, 1, 0.5)

    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1, -70, 0, 18)
    l.Position = UDim2.new(0, 16, 0, 6)
    l.BackgroundTransparency = 1
    l.Text = text
    l.TextColor3 = TEXT
    l.TextSize = 12
    l.Font = FM
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.TextTruncate = Enum.TextTruncate.AtEnd
    l.ZIndex = 5
    l.Parent = f

    local vL = Instance.new("TextLabel")
    vL.Size = UDim2.new(0, 50, 0, 18)
    vL.Position = UDim2.new(1, -66, 0, 6)
    vL.BackgroundTransparency = 1
    vL.Text = tostring(v)
    vL.TextColor3 = ACCENT_GLOW
    vL.TextSize = 12
    vL.Font = FB
    vL.TextXAlignment = Enum.TextXAlignment.Right
    vL.ZIndex = 5
    vL.Parent = f

    local bar = Instance.new("Frame")
    bar.Size = UDim2.new(1, -32, 0, 10)
    bar.Position = UDim2.new(0, 16, 0, 34)
    bar.BackgroundColor3 = Color3.fromRGB(45,45,60)
    bar.BorderSizePixel = 0
    bar.ZIndex = 5
    bar.Parent = f
    corner(bar, UDim.new(1, 0))

    local fill = Instance.new("Frame")
    fill.Size = UDim2.new((v - mn) / (mx - mn), 0, 1, 0)
    fill.BackgroundColor3 = ACCENT
    fill.BorderSizePixel = 0
    fill.ZIndex = 6
    fill.Parent = bar
    corner(fill, UDim.new(1, 0))
    grad(fill, ACCENT_GLOW, ACCENT, 0)

    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 20, 0, 20)
    knob.Position = UDim2.new((v - mn) / (mx - mn), -10, 0.5, -10)
    knob.BackgroundColor3 = Color3.fromRGB(255,255,255)
    knob.BorderSizePixel = 0
    knob.ZIndex = 7
    knob.Parent = bar
    corner(knob, UDim.new(1, 0))
    stroke(knob, ACCENT, 2.5, 0.1)

    local hb = Instance.new("TextButton")
    hb.Size = UDim2.new(1, 0, 0, 40)
    hb.Position = UDim2.new(0, 0, 0, 20)
    hb.BackgroundTransparency = 1
    hb.Text = ""
    hb.ZIndex = 8
    hb.Parent = f

    local dragging = false

    local function upd(x)
        local rl = math.clamp((x - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
        v = math.floor(mn + rl * (mx - mn) + 0.5)
        local pr = (v - mn) / (mx - mn)
        fill.Size = UDim2.new(pr, 0, 1, 0)
        knob.Position = UDim2.new(pr, -10, 0.5, -10)
        vL.Text = tostring(v)
        pcall(cb, v)
    end

    hb.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.Touch or inp.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            upd(inp.Position.X)
        end
    end)
    hb.InputEnded:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.Touch or inp.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    UIS.InputChanged:Connect(function(inp)
        if dragging and (inp.UserInputType == Enum.UserInputType.Touch or inp.UserInputType == Enum.UserInputType.MouseMovement) then
            upd(inp.Position.X)
        end
    end)

    pcall(cb, v)
end

local function button(parent, text, cb)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, 0, 0, 42)
    b.BackgroundColor3 = BG_CARD
    b.BackgroundTransparency = 0.05
    b.BorderSizePixel = 0
    b.Text = text
    b.TextColor3 = TEXT
    b.TextSize = 12
    b.Font = FB
    b.AutoButtonColor = false
    b.ZIndex = 4
    b.Parent = parent
    corner(b, 10)
    stroke(b, BORDER, 1, 0.5)

    b.MouseButton1Click:Connect(function()
        pcall(cb)
    end)
end

print("[Makazi v13] UI готов")

-- ПЕРЕМЕННЫЕ
local speedValue = 1
local jumpValue = 50
local flyOn = false
local flySpeed = 60
local noclip = false
local god = false
local infJump = false
local espOn = false
local aimOn = false
local aimFOV = 2000
local killAllOn = false
local killDelay = 0.15
local antiFl = false
local autoClk = false
local hitboxOn = false
local hitboxSize = 5
local fbOn = false
local savedL = {}
local autoSprint = false
local lowGravity = false
local origG = workspace.Gravity
local infAmmo = false
local doubleJumpOn = false
local jumpCount = 0
local antiVoidOn = false
local lastSafePos = nil
local lastSafeTime = tick()

task.spawn(function()
    while task.wait(0.1) do
        local ch = player.Character
        if ch then
            local h = ch:FindFirstChildOfClass("Humanoid")
            if h then
                if not flyOn then
                    local ts = 16 * speedValue
                    if h.WalkSpeed ~= ts then h.WalkSpeed = ts end
                end
                if h.UseJumpPower ~= true then h.UseJumpPower = true end
                if h.JumpPower ~= jumpValue then h.JumpPower = jumpValue end
                if god then
                    if h.MaxHealth < 1e10 then h.MaxHealth = 1e10 end
                    if h.Health < 1e10 then h.Health = 1e10 end
                end
            end
        end
    end
end)

task.spawn(function()
    while task.wait(0.03) do
        if noclip then
            local ch = player.Character
            if ch then
                for _, p in ipairs(ch:GetDescendants()) do
                    if p:IsA("BasePart") and p.CanCollide then p.CanCollide = false end
                end
            end
        end
    end
end)

local flyConn = nil
local function stopFly()
    flyOn = false
    if flyConn then flyConn:Disconnect(); flyConn = nil end
    local ch = player.Character
    if ch then
        for _, p in ipairs(ch:GetDescendants()) do
            if p:IsA("BasePart") then p.CanCollide = true end
        end
    end
end

local function startFly()
    if flyConn then flyConn:Disconnect() end
    flyOn = true
    flyConn = RS.RenderStepped:Connect(function()
        if not flyOn then return end
        local c = player.Character
        if not c then return end
        local hrp = c:FindFirstChild("HumanoidRootPart")
        local h = c:FindFirstChildOfClass("Humanoid")
        if not hrp or not h then return end
        for _, p in ipairs(c:GetDescendants()) do
            if p:IsA("BasePart") and p.CanCollide then p.CanCollide = false end
        end
        local cam = workspace.CurrentCamera
        local look = cam.CFrame.LookVector
        local right = cam.CFrame.RightVector
        local move = Vector3.zero
        local md = h.MoveDirection
        if md.Magnitude > 0.05 then
            move = Vector3.new(md.X, 0, md.Z).Unit * flySpeed
            move = move + Vector3.new(0, look.Y * flySpeed, 0)
        end
        if UIS:IsKeyDown(Enum.KeyCode.W) then move = move + look * flySpeed end
        if UIS:IsKeyDown(Enum.KeyCode.S) then move = move - look * flySpeed end
        if UIS:IsKeyDown(Enum.KeyCode.D) then move = move + right * flySpeed end
        if UIS:IsKeyDown(Enum.KeyCode.A) then move = move - right * flySpeed end
        if UIS:IsKeyDown(Enum.KeyCode.Space) then move = move + Vector3.new(0, flySpeed, 0) end
        if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then move = move - Vector3.new(0, flySpeed, 0) end
        hrp.CFrame = CFrame.new(hrp.Position + move * (1/60)) * CFrame.Angles(0, math.atan2(look.X, look.Z), 0)
    end)
end

UIS.JumpRequest:Connect(function()
    if not infJump then return end
    local ch = player.Character
    if not ch then return end
    local h = ch:FindFirstChildOfClass("Humanoid")
    if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end
end)

UIS.JumpRequest:Connect(function()
    if not doubleJumpOn then return end
    local ch = player.Character
    if not ch then return end
    local h = ch:FindFirstChildOfClass("Humanoid")
    if not h then return end
    if h.FloorMaterial ~= Enum.Material.Air then jumpCount = 0 end
    if jumpCount < 1 then
        h:ChangeState(Enum.HumanoidStateType.Jumping)
        jumpCount = jumpCount + 1
    end
end)

task.spawn(function()
    while task.wait(0.1) do
        if autoSprint then
            local ch = player.Character
            if ch then
                local h = ch:FindFirstChildOfClass("Humanoid")
                if h and h.MoveDirection.Magnitude > 0.1 and h.WalkSpeed < 30 then h.WalkSpeed = 30 end
            end
        end
    end
end)

task.spawn(function()
    while task.wait(0.5) do
        workspace.Gravity = lowGravity and 50 or origG
    end
end)

task.spawn(function()
    while task.wait(0.05) do
        if antiFl then
            local hr = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            if hr and hr.Velocity.Magnitude > 150 then
                hr.Velocity = Vector3.zero
                hr.RotVelocity = Vector3.zero
            end
        end
    end
end)

task.spawn(function()
    while task.wait(0.1) do
        if antiVoidOn then
            local ch = player.Character
            local hrp = ch and ch:FindFirstChild("HumanoidRootPart")
            if hrp then
                if hrp.Position.Y > -50 and hrp.Position.Y < 500 then
                    lastSafePos = hrp.CFrame
                    lastSafeTime = tick()
                end
                if hrp.Position.Y < -100 and lastSafePos and tick() - lastSafeTime < 5 then
                    hrp.CFrame = lastSafePos
                    notify("🛡 Anti-Void", true)
                end
            end
        end
    end
end)

task.spawn(function()
    while task.wait(0.2) do
        if espOn then
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= player and p.Character then
                    local ch = p.Character
                    local hum = ch:FindFirstChildOfClass("Humanoid")
                    if hum and hum.Health > 0 then
                        local hl = ch:FindFirstChild("MkESP")
                        if not hl then
                            hl = Instance.new("Highlight")
                            hl.Name = "MkESP"
                            hl.FillTransparency = 0.5
                            hl.FillColor = ACCENT
                            hl.OutlineColor = Color3.fromRGB(255,255,255)
                            hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                            hl.Adornee = ch
                            hl.Parent = ch
                        end
                    end
                end
            end
        end
    end
end)

local function clearESP()
    for _, p in ipairs(Players:GetPlayers()) do
        if p.Character then
            local hl = p.Character:FindFirstChild("MkESP")
            if hl then hl:Destroy() end
        end
    end
end

task.spawn(function()
    while task.wait(0.016) do
        if aimOn then
            local ch = player.Character
            local mh = ch and ch:FindFirstChild("Head")
            if mh then
                local cam = workspace.CurrentCamera
                if cam then
                    local best, bd
                    for _, p in ipairs(Players:GetPlayers()) do
                        if p ~= player and p.Character then
                            local th = p.Character:FindFirstChild("Head")
                            local hum = p.Character:FindFirstChildOfClass("Humanoid")
                            if th and hum and hum.Health > 0 then
                                local d = (th.Position - mh.Position).Magnitude
                                if d <= aimFOV and (not bd or d < bd) then
                                    best = th
                                    bd = d
                                end
                            end
                        end
                    end
                    if best then cam.CFrame = CFrame.new(cam.CFrame.Position, best.Position) end
                end
            end
        end
    end
end)

task.spawn(function()
    while task.wait(0.3) do
        if hitboxOn then
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= player and p.Character then
                    local hr = p.Character:FindFirstChild("HumanoidRootPart")
                    if hr then
                        hr.Size = Vector3.new(hitboxSize, hitboxSize, hitboxSize)
                        hr.Transparency = 0.7
                        hr.CanCollide = false
                    end
                end
            end
        end
    end
end)

local function resetHitbox()
    for _, p in ipairs(Players:GetPlayers()) do
        if p.Character then
            local hr = p.Character:FindFirstChild("HumanoidRootPart")
            if hr then
                hr.Size = Vector3.new(2, 2, 1)
                hr.Transparency = 1
            end
        end
    end
end

task.spawn(function()
    while task.wait(0.1) do
        if autoClk and VIM then
            pcall(function()
                VIM:SendMouseButtonEvent(camera.ViewportSize.X/2, camera.ViewportSize.Y/2, 0, true, game, 1)
                task.wait(0.02)
                VIM:SendMouseButtonEvent(camera.ViewportSize.X/2, camera.ViewportSize.Y/2, 0, false, game, 1)
            end)
        end
    end
end)

task.spawn(function()
    while task.wait(0.5) do
        if infAmmo then
            local ch = player.Character
            if ch then
                for _, t in ipairs(ch:GetChildren()) do
                    if t:IsA("Tool") then
                        for _, v in ipairs(t:GetDescendants()) do
                            if v:IsA("IntValue") or v:IsA("NumberValue") then
                                local n = v.Name:lower()
                                if n:find("ammo") or n:find("bullet") or n:find("mag") then
                                    pcall(function() v.Value = 999 end)
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end)

task.spawn(function()
    while task.wait(0.5) do
        if killAllOn then
            local ch = player.Character
            local hrp = ch and ch:FindFirstChild("HumanoidRootPart")
            if hrp then
                local tool
                for _, t in ipairs(ch:GetChildren()) do
                    if t:IsA("Tool") then tool = t break end
                end
                if tool then
                    local targets = {}
                    for _, p in ipairs(Players:GetPlayers()) do
                        if p ~= player and p.Character then
                            local tr = p.Character:FindFirstChild("HumanoidRootPart")
                            local hum = p.Character:FindFirstChildOfClass("Humanoid")
                            if tr and hum and hum.Health > 0 then table.insert(targets, tr) end
                        end
                    end
                    for _, tr in ipairs(targets) do
                        if tr.Parent then
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
end)

local function applyFB()
    savedL = {
        Brightness = Lighting.Brightness, ClockTime = Lighting.ClockTime,
        FogEnd = Lighting.FogEnd, Ambient = Lighting.Ambient,
        OutdoorAmbient = Lighting.OutdoorAmbient, GlobalShadows = Lighting.GlobalShadows
    }
    Lighting.Brightness = 3
    Lighting.ClockTime = 14
    Lighting.FogEnd = 100000
    Lighting.Ambient = Color3.fromRGB(180,180,180)
    Lighting.OutdoorAmbient = Color3.fromRGB(180,180,180)
    Lighting.GlobalShadows = false
end

local function removeFB()
    for k, v in pairs(savedL) do
        pcall(function() Lighting[k] = v end)
    end
end

local ppP = {}
local ppConn = nil
local ppSize = 5
local ppBounce = true
local ppPulse = true
local ppRainbow = false

local function clearPP()
    if ppConn then ppConn:Disconnect(); ppConn = nil end
    for _, p in ipairs(ppP) do if p and p.Parent then p:Destroy() end end
    ppP = {}
end

local function buildPP(sz)
    clearPP()
    local hr = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if not hr then return end
    local shaft = Instance.new("Part")
    shaft.Shape = Enum.PartType.Cylinder
    shaft.Size = Vector3.new(2*sz, 0.7*sz, 0.7*sz)
    shaft.Material = Enum.Material.Neon
    shaft.Color = Color3.fromRGB(255, 130, 160)
    shaft.Anchored = true
    shaft.CanCollide = false
    shaft.Parent = workspace
    table.insert(ppP, shaft)
    local head = Instance.new("Part")
    head.Shape = Enum.PartType.Ball
    head.Size = Vector3.new(1*sz, 1*sz, 1*sz)
    head.Material = Enum.Material.Neon
    head.Color = Color3.fromRGB(255, 60, 120)
    head.Anchored = true
    head.CanCollide = false
    head.Parent = workspace
    table.insert(ppP, head)
    local b1 = Instance.new("Part")
    b1.Shape = Enum.PartType.Ball
    b1.Size = Vector3.new(0.7*sz, 0.7*sz, 0.7*sz)
    b1.Material = Enum.Material.Neon
    b1.Color = Color3.fromRGB(255, 90, 140)
    b1.Anchored = true
    b1.CanCollide = false
    b1.Parent = workspace
    table.insert(ppP, b1)
    local b2 = b1:Clone()
    b2.Parent = workspace
    table.insert(ppP, b2)
    local light = Instance.new("PointLight")
    light.Color = Color3.fromRGB(255, 100, 150)
    light.Range = 10*sz
    light.Brightness = 2
    light.Parent = head
    local t, cy, cs, bv, sv, pp = 0, 0, 0, 0, 0, 0
    ppConn = RS.RenderStepped:Connect(function(dt)
        if not ppP[1] or not ppP[1].Parent then return end
        local c = player.Character
        local r = c and c:FindFirstChild("HumanoidRootPart")
        local h = c and c:FindFirstChildOfClass("Humanoid")
        if not r or not h then return end
        t = t + dt
        local bp = r.Position
        local lk = r.CFrame.LookVector
        local rt = r.CFrame.RightVector
        local isW = h.MoveDirection.Magnitude > 0.1
        local isJ = h:GetState() == Enum.HumanoidStateType.Jumping or h:GetState() == Enum.HumanoidStateType.Freefall
        local tY = 0
        if ppBounce then
            if isJ then tY = 1.2
            elseif isW then tY = math.sin(t * 12) * 0.3
            else tY = math.sin(t * 1.5) * 0.08 end
        end
        local df = tY - cy
        bv = bv + (df * 60 - bv * 8) * dt
        cy = cy + bv * dt
        local tS = 0
        if ppBounce then
            if isW then
                local mr = h.MoveDirection:Dot(rt)
                tS = mr * 0.5 + math.sin(t * 8) * 0.2
            elseif isJ then tS = math.sin(t * 6) * 0.4
            else tS = math.sin(t * 1.2) * 0.06 end
        end
        local sd = tS - cs
        sv = sv + (sd * 60 - sv * 8) * dt
        cs = cs + sv * dt
        local sm = 1
        if ppPulse then
            pp = pp + dt * 4
            sm = 1 + math.sin(pp) * 0.15
        end
        local es = sz * sm
        if ppP[1] then ppP[1].Size = Vector3.new(2*es, 0.7*es, 0.7*es) end
        if ppP[2] then ppP[2].Size = Vector3.new(1*es, 1*es, 1*es) end
        if ppP[3] then ppP[3].Size = Vector3.new(0.7*es, 0.7*es, 0.7*es) end
        if ppP[4] then ppP[4].Size = Vector3.new(0.7*es, 0.7*es, 0.7*es) end
        if ppRainbow then
            local hue = tick() % 1
            local c1 = Color3.fromHSV(hue, 0.7, 1)
            local c2 = Color3.fromHSV((hue + 0.1) % 1, 0.9, 1)
            if ppP[1] then ppP[1].Color = c1 end
            if ppP[2] then ppP[2].Color = c2 end
            if ppP[3] then ppP[3].Color = c1 end
            if ppP[4] then ppP[4].Color = c1 end
            light.Color = c2
        end
        local base = bp + Vector3.new(0, -1.5 + cy, 0) + rt * cs
        if ppP[3] then ppP[3].CFrame = CFrame.new(base + lk * (-0.2*es) + rt * (0.4*es) + Vector3.new(0, -0.3, 0)) end
        if ppP[4] then ppP[4].CFrame = CFrame.new(base + lk * (-0.2*es) + rt * (-0.4*es) + Vector3.new(0, -0.3, 0)) end
        local sp = base + lk * (1 * es)
        if ppP[1] then ppP[1].CFrame = CFrame.new(sp, sp + lk) * CFrame.Angles(0, math.rad(90), 0) end
        if ppP[2] then ppP[2].CFrame = CFrame.new(base + lk * (2.2 * es)) end
    end)
end

local invisOn = false
task.spawn(function()
    while task.wait(0.3) do
        if invisOn then
            local ch = player.Character
            if ch then
                for _, p in ipairs(ch:GetDescendants()) do
                    if p:IsA("BasePart") and p.Name ~= "HumanoidRootPart" then
                        pcall(function() p.LocalTransparencyModifier = 1 end)
                    end
                end
            end
        end
    end
end)

local rainbowOn = false
task.spawn(function()
    while task.wait(0.08) do
        if rainbowOn then
            local ch = player.Character
            if ch then
                local col = Color3.fromHSV(tick() % 1, 1, 1)
                for _, p in ipairs(ch:GetDescendants()) do
                    if p:IsA("BasePart") then pcall(function() p.Color = col end) end
                end
            end
        end
    end
end)

local bunnyOn = false
task.spawn(function()
    while task.wait(0.05) do
        if bunnyOn then
            local h = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
            if h and h.MoveDirection.Magnitude > 0.1 and h.FloorMaterial ~= Enum.Material.Air then
                h:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end
    end
end)

local fireOn = false
task.spawn(function()
    while task.wait(0.15) do
        if fireOn then
            local hr = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            if hr then
                local f = Instance.new("Fire")
                f.Size = 6
                f.Parent = hr
                task.delay(1.5, function() if f then f:Destroy() end end)
            end
        end
    end
end)

local flingOn = false
task.spawn(function()
    while task.wait(0.2) do
        if flingOn then
            local hr = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            if hr then
                for _, p in ipairs(Players:GetPlayers()) do
                    if p ~= player and p.Character then
                        local tr = p.Character:FindFirstChild("HumanoidRootPart")
                        if tr and (tr.Position - hr.Position).Magnitude < 10 then
                            pcall(function()
                                tr.Velocity = Vector3.new((math.random()-0.5)*500, 500, (math.random()-0.5)*500)
                            end)
                        end
                    end
                end
            end
        end
    end
end)

local mm2Roles = false
local KN = {"Knife","knife","KnifeTool","MurdererKnife","Blade"}
local GN = {"Gun","gun","Revolver","Pistol","SheriffGun"}

local function hasT(p, list)
    local c, b = p.Character, p:FindFirstChild("Backpack")
    for _, n in ipairs(list) do
        if (c and c:FindFirstChild(n)) or (b and b:FindFirstChild(n)) then return true end
    end
    return false
end

RS.RenderStepped:Connect(function()
    if not mm2Roles then return end
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= player and p.Character then
            local isM = hasT(p, KN)
            local isS = hasT(p, GN)
            local tag = isM and "MM2_M" or (isS and "MM2_S" or "MM2_I")
            local color = isM and Color3.fromRGB(255,0,0) or (isS and Color3.fromRGB(0,120,255) or Color3.fromRGB(240,240,240))
            for _, o in ipairs({"MM2_M", "MM2_S", "MM2_I"}) do
                if o ~= tag then
                    local h = p.Character:FindFirstChild(o)
                    if h then h:Destroy() end
                end
            end
            local hl = p.Character:FindFirstChild(tag)
            if not hl then
                hl = Instance.new("Highlight")
                hl.Name = tag
                hl.FillTransparency = 1
                hl.OutlineTransparency = 0
                hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                hl.Adornee = p.Character
                hl.Parent = p.Character
            end
            hl.OutlineColor = color
        end
    end
end)

-- UI НАПОЛНЕНИЕ
section(tabMain, "🚀 Быстрые действия")
toggle(tabMain, "🦘 Бесконечный прыжок", false, function(s) infJump = s; notify(s and "✓ Inf Jump ВКЛ" or "✗ выкл", s) end)
toggle(tabMain, "🦘 Двойной прыжок", false, function(s) doubleJumpOn = s; if not s then jumpCount = 0 end; notify(s and "✓ Double Jump ВКЛ" or "✗ выкл", s) end)
toggle(tabMain, "🛡 Бессмертие", false, function(s) god = s; notify(s and "✓ God ВКЛ" or "✗ выкл", s) end)
toggle(tabMain, "🚪 Проход сквозь стены", false, function(s) noclip = s; notify(s and "✓ Noclip ВКЛ" or "✗ выкл", s) end)
toggle(tabMain, "🛡 Anti-Void", false, function(s) antiVoidOn = s; notify(s and "✓ Anti-Void ВКЛ" or "✗ выкл", s) end)

section(tabMain, "⚔ Kill All")
toggle(tabMain, "⚔ Убить всех игроков", false, function(s) killAllOn = s; notify(s and "✓ Kill All ВКЛ" or "✗ выкл", s) end)
slider(tabMain, "Задержка", 1, 30, 15, function(v) killDelay = v / 100 end)

section(tabMain, "🎯 Автонаведение")
toggle(tabMain, "🎯 Автоматически наводиться", false, function(s) aimOn = s; notify(s and "✓ Aimbot ВКЛ" or "✗ выкл", s) end)
slider(tabMain, "Дистанция", 100, 5000, 2000, function(v) aimFOV = v end)

section(tabMain, "👁 ESP")
toggle(tabMain, "👁 ESP игроков", false, function(s) espOn = s; if not s then clearESP() end; notify(s and "✓ ESP ВКЛ" or "✗ выкл", s) end)

section(tabMove, "🏃 Скорость")
slider(tabMove, "Множитель", 1, 10, 1, function(v)
    speedValue = v
    local h = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
    if h then h.WalkSpeed = 16 * v end
end)
toggle(tabMove, "🏃 Авто-бег", false, function(s) autoSprint = s; notify(s and "✓ Авто-бег ВКЛ" or "✗ выкл", s) end)

section(tabMove, "🦘 Прыжок")
slider(tabMove, "Сила прыжка", 50, 500, 50, function(v)
    jumpValue = v
    local h = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
    if h then h.UseJumpPower = true; h.JumpPower = v end
end)

section(tabMove, "✈ Полёт")
toggle(tabMove, "✈ Полёт", false, function(s)
    if s then startFly(); notify("✓ Полёт ВКЛ", true) else stopFly(); notify("✗ выкл") end
end)
slider(tabMove, "Скорость", 20, 300, 60, function(v) flySpeed = v end)

section(tabMove, "🎈 Физика")
toggle(tabMove, "🎈 Низкая гравитация", false, function(s) lowGravity = s; notify(s and "✓ Low G ВКЛ" or "✗ выкл", s) end)
toggle(tabMove, "🛡 Анти-Флинг", false, function(s) antiFl = s; notify(s and "✓ АФ ВКЛ" or "✗ выкл", s) end)

section(tabVisual, "👁 ESP")
toggle(tabVisual, "👁 ESP игроков", false, function(s) espOn = s; if not s then clearESP() end; notify(s and "✓ ESP ВКЛ" or "✗ выкл", s) end)

section(tabVisual, "🎯 Aimbot")
toggle(tabVisual, "🎯 Автонаведение", false, function(s) aimOn = s; notify(s and "✓ Aimbot ВКЛ" or "✗ выкл", s) end)
slider(tabVisual, "Дистанция", 100, 5000, 2000, function(v) aimFOV = v end)

section(tabVisual, "📦 Хитбокс")
toggle(tabVisual, "📦 Расширить хитбокс", false, function(s) hitboxOn = s; if not s then resetHitbox() end; notify(s and "✓ Hitbox ВКЛ" or "✗ выкл", s) end)
slider(tabVisual, "Размер", 2, 20, 5, function(v) hitboxSize = v end)

section(tabVisual, "🔫 Оружие")
toggle(tabVisual, "🔫 Бесконечные патроны", false, function(s) infAmmo = s; notify(s and "✓ Патроны ∞ ВКЛ" or "✗ выкл", s) end)
toggle(tabVisual, "🖱 Авто-кликер", false, function(s) autoClk = s; notify(s and "✓ Авто-клик ВКЛ" or "✗ выкл", s) end)

section(tabVisual, "📷 Камера и свет")
slider(tabVisual, "Угол обзора (FOV)", 40, 120, 70, function(v) if camera then camera.FieldOfView = v end end)
toggle(tabVisual, "☀ Fullbright", false, function(s) fbOn = s; if s then applyFB() else removeFB() end; notify(s and "✓ Fullbright ВКЛ" or "✗ выкл", s) end)

section(tabFun, "🍆 Визуальный член")
toggle(tabFun, "🍆 Показать член", false, function(s)
    if s then buildPP(ppSize); notify("✓ Активирован 😂", true) else clearPP(); notify("✗ Убран") end
end)
slider(tabFun, "Размер", 1, 20, 5, function(v) ppSize = v; if ppP[1] and ppP[1].Parent then buildPP(v) end end)
toggle(tabFun, "🎵 Качание", true, function(s) ppBounce = s end)
toggle(tabFun, "💓 Пульсация", true, function(s) ppPulse = s end)
toggle(tabFun, "🌈 Радужный", false, function(s) ppRainbow = s end)

section(tabFun, "🎉 Эффекты")
toggle(tabFun, "👻 Невидимость", false, function(s)
    invisOn = s
    local ch = player.Character
    if ch then
        for _, p in ipairs(ch:GetDescendants()) do
            if p:IsA("BasePart") and p.Name ~= "HumanoidRootPart" then
                p.LocalTransparencyModifier = s and 1 or 0
            end
        end
    end
    notify(s and "✓ Инвиз ВКЛ" or "✗ выкл", s)
end)
toggle(tabFun, "🌈 Радужный персонаж", false, function(s) rainbowOn = s; notify(s and "✓ Радуга ВКЛ" or "✗ выкл", s) end)
toggle(tabFun, "🐰 Bunny Hop", false, function(s) bunnyOn = s; notify(s and "✓ BH ВКЛ" or "✗ выкл", s) end)
toggle(tabFun, "🔥 Огненный след", false, function(s) fireOn = s; notify(s and "✓ Огонь ВКЛ" or "✗ выкл", s) end)
toggle(tabFun, "💥 Fling игроков", false, function(s) flingOn = s; notify(s and "⚠ Fling ВКЛ" or "✗ выкл", s) end)

section(tabMisc, "🔪 Murder Mystery 2")
toggle(tabMisc, "👁 Подсветка ролей MM2", false, function(s) mm2Roles = s; notify(s and "✓ Роли ВКЛ" or "✗ выкл", s) end)

section(tabMisc, "⚡ Действия")
button(tabMisc, "🔄 Возродиться", function()
    local c = player.Character
    if c then c:BreakJoints() end
    notify("✓ Возрождение", true)
end)
button(tabMisc, "⬆ ТП вверх", function()
    local hr = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if hr then hr.CFrame = hr.CFrame + Vector3.new(0, 50, 0) end
    notify("✓ ТП", true)
end)
button(tabMisc, "🔁 Rejoin", function()
    pcall(function() game:GetService("TeleportService"):Teleport(game.PlaceId, player) end)
    notify("✓ Перезаход...", true)
end)
button(tabMisc, "❌ Выключить ВСЕ", function()
    speedValue = 1
    jumpValue = 50
    if flyOn then stopFly() end
    espOn = false; clearESP()
    aimOn = false; noclip = false; god = false; infJump = false
    killAllOn = false; antiFl = false; autoClk = false
    hitboxOn = false; resetHitbox()
    fbOn = false; removeFB()
    lowGravity = false; autoSprint = false; infAmmo = false
    clearPP()
    invisOn = false; rainbowOn = false; bunnyOn = false; fireOn = false; flingOn = false
    mm2Roles = false; doubleJumpOn = false; antiVoidOn = false
    notify("✓ Всё выключено", true)
end)

-- ОТКРЫТИЕ МЕНЮ
local opened = false

local function openMenu()
    if opened then return end
    opened = true
    menu.Visible = true
    print("[Makazi] МЕНЮ ОТКРЫТО")
end

local function closeMenu()
    if not opened then return end
    opened = false
    menu.Visible = false
    print("[Makazi] МЕНЮ ЗАКРЫТО")
end

local function toggleMenu()
    if opened then closeMenu() else openMenu() end
end

local function inBounds(pos, frame)
    if not frame or not frame.Parent then return false end
    local ap = frame.AbsolutePosition
    local as = frame.AbsoluteSize
    return pos.X >= ap.X and pos.X <= ap.X + as.X
       and pos.Y >= ap.Y and pos.Y <= ap.Y + as.Y
end

-- РЕЗЕРВНАЯ КНОПКА
local fallbackBtn = Instance.new("TextButton")
fallbackBtn.Size = UDim2.new(0, 70, 0, 30)
fallbackBtn.Position = UDim2.new(0, 30, 0, 240)
fallbackBtn.BackgroundColor3 = ACCENT
fallbackBtn.Text = "МЕНЮ"
fallbackBtn.TextColor3 = Color3.fromRGB(255,255,255)
fallbackBtn.TextSize = 13
fallbackBtn.Font = FB
fallbackBtn.AutoButtonColor = false
fallbackBtn.ZIndex = 50
fallbackBtn.Parent = gui
corner(fallbackBtn, 8)
stroke(fallbackBtn, Color3.fromRGB(255,255,255), 2, 0.3)

UIS.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.UserInputType ~= Enum.UserInputType.Touch
    and input.UserInputType ~= Enum.UserInputType.MouseButton1 then return end

    local pos = input.Position

    if inBounds(pos, circleHolder) then
        print("[Makazi] Tap Sahur → toggle")
        toggleMenu()
        return
    end

    if inBounds(pos, fallbackBtn) then
        print("[Makazi] Tap MENU → toggle")
        toggleMenu()
        return
    end

    if opened and inBounds(pos, closeBtn) then
        print("[Makazi] Tap CLOSE")
        closeMenu()
        return
    end
end)

circleBtn.MouseButton1Click:Connect(toggleMenu)
fallbackBtn.MouseButton1Click:Connect(toggleMenu)
closeBtn.MouseButton1Click:Connect(closeMenu)

-- ПЕРЕТАСКИВАНИЕ
local dragging = false
local dragStart, startPos

UIS.InputBegan:Connect(function(input, gp)
    if gp then return end
    if not opened then return end
    if input.UserInputType ~= Enum.UserInputType.Touch
    and input.UserInputType ~= Enum.UserInputType.MouseButton1 then return end
    if inBounds(input.Position, header) then
        dragging = true
        dragStart = Vector2.new(input.Position.X, input.Position.Y)
        startPos = menu.Position
    end
end)

UIS.InputChanged:Connect(function(input)
    if not dragging then return end
    if input.UserInputType == Enum.UserInputType.Touch
    or input.UserInputType == Enum.UserInputType.MouseMovement then
        local cur = Vector2.new(input.Position.X, input.Position.Y)
        local d = cur - dragStart
        menu.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + d.X,
            startPos.Y.Scale, startPos.Y.Offset + d.Y
        )
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch
    or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

selectTab("main")

-- МЕНЮ СРАЗУ ОТКРЫТО
menu.Visible = true
opened = true

print("[Makazi v13] =================")
print("[Makazi v13] ЗАГРУЖЕН!")
print("[Makazi v13] ID: 114192207711666")
print("[Makazi v13] =================")

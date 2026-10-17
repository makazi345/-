--==========================================================
--   MAKAZI MOD  •  v10.7  •  FULL MOBILE EDITION
--==========================================================
print("=== MAKAZI MOD v10.7 START ===")
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
pcall(function() CoreGui:FindFirstChild("MakaziMod"):Destroy() end)
pcall(function() playerGui:FindFirstChild("MakaziMod"):Destroy() end)
local gui = Instance.new("ScreenGui")
gui.Name = "MakaziMod"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
pcall(function() gui.Parent = CoreGui end)
if not gui.Parent then gui.Parent = playerGui end
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
local soundEnabled = true
local SOUND_IDS = { click = "rbxassetid://6895079853", open = "rbxassetid://6895080175", close = "rbxassetid://6895080059" }
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
	local count = 0
	for _, c in ipairs(notifHolder:GetChildren()) do
		if c:IsA("Frame") then count = count + 1 end
	end
	if count >= 5 then
		for _, c in ipairs(notifHolder:GetChildren()) do
			if c:IsA("Frame") then c:Destroy() break end
		end
	end
	local card = Instance.new("Frame")
	card.Size = UDim2.new(1, 0, 0, 40)
	card.BackgroundColor3 = COLORS.card
	card.BorderSizePixel = 0
	card.ZIndex = 101
	card.Parent = notifHolder
	corner(card, 8)
	stroke(card, ok and COLORS.accent or Color3.fromRGB(180, 180, 180), 1.5, 0.3)
	gradient(card, COLORS.bgLight, COLORS.card, 0)
	local bar = Instance.new("Frame")
	bar.Size = UDim2.new(0, 3, 1, -10)
	bar.Position = UDim2.new(0, 5, 0, 5)
	bar.BackgroundColor3 = ok and COLORS.accent or Color3.fromRGB(180, 180, 180)
	bar.BorderSizePixel = 0
	bar.ZIndex = 102
	bar.Parent = card
	corner(bar, 2)
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
	TweenService:Create(card, TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Position = UDim2.new(0, 0, 0, 0) }):Play()
	task.delay(2.5, function()
		local t = TweenService:Create(card, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.In), { Position = UDim2.new(1, 50, 0, 0), BackgroundTransparency = 1 })
		t:Play()
		t.Completed:Connect(function() card:Destroy() end)
	end)
end
local circleHolder = Instance.new("Frame")
circleHolder.Name = "CircleHolder"
circleHolder.Size = UDim2.new(0, 70, 0, 70)
circleHolder.Position = UDim2.new(0, 30, 0, 150)
circleHolder.BackgroundTransparency = 1
circleHolder.ZIndex = 30
circleHolder.Parent = gui
local pulse = Instance.new("Frame")
pulse.Size = UDim2.new(1, 0, 1, 0)
pulse.BackgroundColor3 = COLORS.accent
pulse.BackgroundTransparency = 0.7
pulse.BorderSizePixel = 0
pulse.ZIndex = 0
pulse.Parent = circleHolder
corner(pulse, UDim.new(1, 0))
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
task.spawn(function()
	while circle.Parent do
		local t = TweenService:Create(pulse, TweenInfo.new(1.4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), { Size = UDim2.new(1.4, 0, 1.4, 0), Position = UDim2.new(-0.2, 0, -0.2, 0), BackgroundTransparency = 0.95 })
		t:Play()
		t.Completed:Wait()
	end
end)
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
local menuBg = Instance.new("ImageLabel")
menuBg.Size = UDim2.new(1, 0, 1, 0)
menuBg.BackgroundTransparency = 1
menuBg.Image = "rbxthumb://type=Asset&id=83138270236341&w=420&h=420"
menuBg.ScaleType = Enum.ScaleType.Crop
menuBg.ZIndex = 0
menuBg.Parent = menu
corner(menuBg, 14)
local menuDark = Instance.new("Frame")
menuDark.Size = UDim2.new(1, 0, 1, 0)
menuDark.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
menuDark.BackgroundTransparency = 0.55
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
title.Text = "MAKAZI MOD v10.7"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
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
minBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
minBtn.BackgroundTransparency = 0.85
minBtn.Text = "—"
minBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
minBtn.TextSize = 18
minBtn.Font = FONT_BOLD
minBtn.AutoButtonColor = false
minBtn.ZIndex = 4
minBtn.Parent = header
corner(minBtn, UDim.new(1, 0))
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 28, 0, 28)
closeBtn.Position = UDim2.new(1, -34, 0.5, -14)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.BackgroundTransparency = 0.85
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = 14
closeBtn.Font = FONT_BOLD
closeBtn.AutoButtonColor = false
closeBtn.ZIndex = 4
closeBtn.Parent = header
corner(closeBtn, UDim.new(1, 0))
local searchBox = Instance.new("Frame")
searchBox.Size = UDim2.new(1, -16, 0, 28)
searchBox.Position = UDim2.new(0, 8, 0, 50)
searchBox.BackgroundColor3 = COLORS.bgLight
searchBox.BackgroundTransparency = 0.2
searchBox.BorderSizePixel = 0
searchBox.ZIndex = 3
searchBox.Parent = menu
corner(searchBox, 7)
local searchIcon = Instance.new("TextLabel")
searchIcon.Size = UDim2.new(0, 22, 1, 0)
searchIcon.Position = UDim2.new(0, 2, 0, 0)
searchIcon.BackgroundTransparency = 1
searchIcon.Text = "🔍"
searchIcon.TextSize = 12
searchIcon.Font = FONT
searchIcon.ZIndex = 4
searchIcon.Parent = searchBox
local searchInput = Instance.new("TextBox")
searchInput.Size = UDim2.new(1, -28, 1, 0)
searchInput.Position = UDim2.new(0, 26, 0, 0)
searchInput.BackgroundTransparency = 1
searchInput.Text = ""
searchInput.PlaceholderText = "Поиск..."
searchInput.PlaceholderColor3 = COLORS.textDim
searchInput.TextColor3 = COLORS.text
searchInput.TextSize = 11
searchInput.Font = FONT
searchInput.TextXAlignment = Enum.TextXAlignment.Left
searchInput.ClearTextOnFocus = false
searchInput.ZIndex = 4
searchInput.Parent = searchBox
local tabBar = Instance.new("Frame")
tabBar.Size = UDim2.new(1, -16, 0, 30)
tabBar.Position = UDim2.new(0, 8, 0, 84)
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
local allItems = {}
local function selectTab(name)
	for n, c in pairs(pages) do c.Visible = (n == name) end
	for n, b in pairs(tabButtons) do
		TweenService:Create(b, TweenInfo.new(0.2), { BackgroundColor3 = (n == name) and COLORS.accent or COLORS.card }):Play()
	end
end
local function makeTab(name, icon)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0, 38, 0, 24)
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
	page.Size = UDim2.new(1, -16, 1, -122)
	page.Position = UDim2.new(0, 8, 0, 118)
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
	btn.MouseEnter:Connect(function() TweenService:Create(btn, TweenInfo.new(0.15), { BackgroundColor3 = COLORS.cardHover }):Play() end)
	btn.MouseLeave:Connect(function() TweenService:Create(btn, TweenInfo.new(0.15), { BackgroundColor3 = COLORS.card }):Play() end)
	btn.MouseButton1Click:Connect(function() clickSound() pcall(callback) end)
	table.insert(allItems, { obj = btn, text = text, parent = parent })
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
	lbl.TextTruncate = Enum.TextTruncate.AtEnd
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
	dot.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	dot.BorderSizePixel = 0
	dot.ZIndex = 6
	dot.Parent = ind
	corner(dot, UDim.new(1, 0))
	local function setState(s, silent)
		state = s
		TweenService:Create(ind, TweenInfo.new(0.2), { BackgroundColor3 = state and COLORS.accent or Color3.fromRGB(60, 60, 72) }):Play()
		TweenService:Create(dot, TweenInfo.new(0.2, Enum.EasingStyle.Quart), { Position = state and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 3, 0.5, -7) }):Play()
		if not silent then pcall(callback, state) end
	end
	btn.MouseButton1Click:Connect(function()
		if not state then toggleOn() else toggleOff() end
		setState(not state)
	end)
	table.insert(allItems, { obj = btn, text = text, parent = parent })
	return setState
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
	label.TextTruncate = Enum.TextTruncate.AtEnd
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
	gradient(fill, COLORS.accent, COLORS.accentDark, 0)
	local knob = Instance.new("Frame")
	knob.Size = UDim2.new(0, 16, 0, 16)
	knob.Position = UDim2.new((value - min) / (max - min), -8, 0.5, -8)
	knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	knob.BorderSizePixel = 0
	knob.ZIndex = 7
	knob.Parent = bar
	corner(knob, UDim.new(1, 0))
	stroke(knob, COLORS.accent, 2)
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
		knob.Position = UDim2.new(p, -8, 0.5, -8)
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
	table.insert(allItems, { obj = frame, text = text, parent = parent })
end

-- ПЕРЕМЕННЫЕ
local espEnabled = false
local espLines = {}
local hasDrawing = pcall(function() return Drawing end)
local aimEnabled = false
local aimSmooth = 0.25
local aimFOV = 500
local aimTeamCheck = false
local aimVisibleOnly = false
local aimSwitchDelay = 0.5
local aimCurrentTarget = nil
local aimLastSwitch = 0
local aimPrediction = true
local aimMethod = "auto"
local aimLockedKey = nil
local aimTriggerBot = false
local aimTriggerRadius = 40
local noclipEnabled = false
local godEnabled = false
local infJumpEnabled = false
local fullbrightEnabled = false
local savedLighting = {}
local antiAfkEnabled = false
local lowGravityEnabled = false
local savedGravity = workspace.Gravity
local autoSprintEnabled = false
local antiFlingEnabled = false
local autoClickerEnabled = false
local autoClickerDelay = 0.1
local hitboxEnabled = false
local hitboxSize = 5
local hitboxOriginalSizes = {}
local infiniteAmmoEnabled = false
local fpsBoostEnabled = false
local cinematicEnabled = false
local doubleJumpOn = false
local doubleJumpUsed = false
local antiVoidOn = false
local lastSafePos = nil
local lastSafeTime = tick()
local killAllOn = false
local killDelay = 0.15
local flingRange = 12
local flingPower = 500
local flingOnTouchOn = false
local auraEnabled = false
local auraParts = {}
local auraConn = nil
local spinEnabled = false
local spinSpeed = 720
local spinAV = nil
local spinSavedAutoRotate = nil
local flyGuiLoaded = false
local FLY_GUI_V3_URL = "https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"
local babftAutoWinEnabled = false
local babftAutoWinThread = nil
local babftChestWaitTime = 3
local babftExternalLoaded = false
local mm2Kento = { AutoFarm=false, Noclip=false, TPWalk=false, InfJump=false, ESP=false, AimBot=false, KillAura=false, TPWalkSpeed=0.4 }
local mm2Coins = {}
local clickTPEnabled = false
local espNamesEnabled = false
local antiStunEnabled = false
local autoRespawnEnabled = false
local currentFpsCap = 60
-- Sheriff Auto-Shoot
local mm2SheriffAuto = false
local mm2SheriffRange = 300
local mm2SheriffDelay = 0.5
local mm2SheriffLastShot = 0
local mm2SheriffPredict = true
local mm2SheriffWallCheck = true
-- 99 Nights in the Forest
local n99_AutoFarm = false
local n99_AutoChop = false
local n99_AutoEat = false
local n99_AutoCampfire = false
local n99_GodMode = false
local n99_FreezeEnemies = false
local n99_KillAura = false
local n99_KillAuraRange = 22
local n99_TreeAura = false
local n99_TreeAuraRange = 25
local n99_InfiniteJump = false
local n99_Noclip = false
local n99_ESP_Chests = false
local n99_ESP_Enemies = false
local n99_ESP_Children = false
local n99_ESP_Players = false
local n99_BringItems = false
local n99_AutoWin = false
local n99_LastCampfireCheck = 0

-- ФУНКЦИИ
local function loadFlyGUI_V3()
	if flyGuiLoaded then return end
	flyGuiLoaded = true
	task.spawn(function()
		local ok, err = pcall(function() loadstring(game:HttpGet(FLY_GUI_V3_URL))() end)
		if not ok then
			notify("Fly GUI V3 не загрузился", false)
			warn("[Makazi] Fly V3 error:", err)
			flyGuiLoaded = false
		else
			notify("Fly GUI V3 ✈", true)
		end
	end)
end
local function unloadFlyGUI_V3()
	if not flyGuiLoaded then return end
	flyGuiLoaded = false
	for _, g in ipairs(CoreGui:GetChildren()) do
		if g:IsA("ScreenGui") and g.Name ~= "MakaziMod" then
			local n = g.Name:lower()
			if n:find("flyv3") or n:find("xeonfly") or n:find("^xn") then g:Destroy() end
		end
	end
	for _, g in ipairs(playerGui:GetChildren()) do
		if g:IsA("ScreenGui") and g.Name ~= "MakaziMod" then
			local n = g.Name:lower()
			if n:find("flyv3") or n:find("xeonfly") or n:find("^xn") then g:Destroy() end
		end
	end
	notify("Fly GUI V3 выкл", false)
end
local function isAlive(char)
	if not char then return false end
	local hum = char:FindFirstChildOfClass("Humanoid")
	return hum and hum.Health > 0
end
local function isVisible(targetPart)
	if not targetPart then return false end
	local myChar = player.Character
	if not myChar then return false end
	local myHead = myChar:FindFirstChild("Head") or myChar:FindFirstChild("HumanoidRootPart")
	if not myHead then return false end
	local params = RaycastParams.new()
	params.FilterType = Enum.RaycastFilterType.Exclude
	params.FilterDescendantsInstances = { myChar }
	params.IgnoreWater = true
	local result = workspace:Raycast(myHead.Position, targetPart.Position - myHead.Position, params)
	return result == nil or result.Instance:IsDescendantOf(targetPart.Parent)
end
local function getBestTarget()
	local myChar = player.Character
	local myHead = myChar and (myChar:FindFirstChild("Head") or myChar:FindFirstChild("HumanoidRootPart"))
	if not myHead then return nil end
	local camera = workspace.CurrentCamera
	if not camera then return nil end
	local center = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2)
	local best, bestScore = nil, math.huge
	for _, p in ipairs(Players:GetPlayers()) do
		if p ~= player and p.Character then
			if aimTeamCheck and p.Team and p.Team == player.Team then continue end
			local char = p.Character
			local hum = char:FindFirstChildOfClass("Humanoid")
			if not hum or hum.Health <= 0 then continue end
			local head = char:FindFirstChild("Head")
			local hrp = char:FindFirstChild("HumanoidRootPart")
			if not head or not hrp then continue end
			local dist = (hrp.Position - myHead.Position).Magnitude
			if dist > aimFOV then continue end
			if aimVisibleOnly and not isVisible(head) then continue end
			local sp, onScreen = camera:WorldToViewportPoint(head.Position)
			if not onScreen then continue end
			local screenDist = (Vector2.new(sp.X, sp.Y) - center).Magnitude
			local score = screenDist + dist * 0.3
			if score < bestScore then
				bestScore = score
				best = head
			end
		end
	end
	return best
end
local function aimAt(targetPos)
	local camera = workspace.CurrentCamera
	local myChar = player.Character
	if not camera or not myChar then return end
	local actualPos = targetPos
	if aimPrediction and aimCurrentTarget then
		local vel = aimCurrentTarget.AssemblyLinearVelocity or Vector3.zero
		local dist = (targetPos - camera.CFrame.Position).Magnitude
		local predictTime = math.min(dist / 500, 0.15)
		actualPos = targetPos + vel * predictTime
	end
	local targetCF = CFrame.new(camera.CFrame.Position, actualPos)
	camera.CFrame = camera.CFrame:Lerp(targetCF, aimSmooth)
	if aimMethod == "humanoid" or aimMethod == "hybrid" or aimMethod == "auto" then
		local hum = myChar:FindFirstChildOfClass("Humanoid")
		if hum then pcall(function() hum.TargetPoint = actualPos end) end
	end
end
pcall(function() RunService:UnbindFromRenderStep("MakaziAimbot") end)
RunService:BindToRenderStep("MakaziAimbot", Enum.RenderPriority.Camera.Value + 20, function()
	if not aimEnabled then return end
	local myChar = player.Character
	local myHead = myChar and (myChar:FindFirstChild("Head") or myChar:FindFirstChild("HumanoidRootPart"))
	if not myHead then return end
	if aimCurrentTarget and (not aimCurrentTarget.Parent or not isAlive(aimCurrentTarget.Parent)) then
		aimCurrentTarget = nil
		aimLockedKey = nil
	end
	local now = tick()
	local canSwitch = (now - aimLastSwitch) >= aimSwitchDelay or not aimCurrentTarget
	if not aimCurrentTarget or canSwitch then
		local newTarget = getBestTarget()
		if newTarget and newTarget ~= aimCurrentTarget then
			local targetKey = newTarget.Parent
			if not (aimLockedKey and aimLockedKey == targetKey) then
				aimCurrentTarget = newTarget
				aimLockedKey = targetKey
				aimLastSwitch = now
			end
		end
	end
	local target = aimCurrentTarget
	if target and target.Parent then
		aimAt(target.Position)
		if aimTriggerBot then
			local camera = workspace.CurrentCamera
			local sp, onScreen = camera:WorldToViewportPoint(target.Position)
			if onScreen then
				local center = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2)
				local aimDist = (Vector2.new(sp.X, sp.Y) - center).Magnitude
				if aimDist < aimTriggerRadius then
					local char = player.Character
					if char then
						for _, t in ipairs(char:GetChildren()) do
							if t:IsA("Tool") then pcall(function() t:Activate() end) break end
						end
					end
				end
			end
		end
	end
end)
RunService.RenderStepped:Connect(function()
	if espEnabled then
		local camera = workspace.CurrentCamera
		for _, p in ipairs(Players:GetPlayers()) do
			if p ~= player then
				local char = p.Character
				local head = char and char:FindFirstChild("Head")
				if char and head then
					local hl = char:FindFirstChild("ESP_HL")
					if not hl then
						hl = Instance.new("Highlight")
						hl.Name = "ESP_HL"
						hl.FillTransparency = 1
						hl.OutlineColor = COLORS.accent
						hl.OutlineTransparency = 0
						hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
						hl.Adornee = char
						hl.Parent = char
					end
					if hasDrawing then
						local ln = espLines[p]
						if not ln then
							ln = Drawing.new("Line")
							ln.Thickness = 1
							ln.Color = COLORS.accent
							ln.Transparency = 0.7
							espLines[p] = ln
						end
						local sp, onScreen = camera:WorldToViewportPoint(head.Position)
						ln.From = Vector2.new(camera.ViewportSize.X / 2, 0)
						ln.To = Vector2.new(sp.X, sp.Y)
						ln.Visible = onScreen
					end
				end
			end
		end
	end
	if cinematicEnabled then
		local camera = workspace.CurrentCamera
		camera.FieldOfView = 40
	end
end)
Players.PlayerRemoving:Connect(function(p)
	if espLines[p] then
		pcall(function() espLines[p]:Remove() end)
		espLines[p] = nil
	end
	if p.Character then
		local h = p.Character:FindFirstChild("ESP_HL")
		if h then h:Destroy() end
		local hd = p.Character:FindFirstChild("Head")
		local t = hd and hd:FindFirstChild("MakaziNameTag")
		if t then t:Destroy() end
	end
end)
local function clearESP()
	for _, p in ipairs(Players:GetPlayers()) do
		local c = p.Character
		if c then
			local h = c:FindFirstChild("ESP_HL")
			if h then h:Destroy() end
		end
	end
	for _, ln in pairs(espLines) do pcall(function() ln:Remove() end) end
	espLines = {}
end
RunService.RenderStepped:Connect(function()
	if not espNamesEnabled then return end
	for _, p in ipairs(Players:GetPlayers()) do
		if p ~= player and p.Character then
			local head = p.Character:FindFirstChild("Head")
			if head then
				local tag = head:FindFirstChild("MakaziNameTag")
				if not tag then
					tag = Instance.new("BillboardGui")
					tag.Name = "MakaziNameTag"
					tag.Size = UDim2.new(0, 140, 0, 22)
					tag.StudsOffsetWorldSpace = Vector3.new(0, 2.5, 0)
					tag.AlwaysOnTop = true
					tag.Parent = head
					local lbl = Instance.new("TextLabel")
					lbl.Name = "Lbl"
					lbl.Size = UDim2.new(1, 0, 1, 0)
					lbl.BackgroundTransparency = 1
					lbl.TextColor3 = COLORS.accent
					lbl.TextStrokeTransparency = 0
					lbl.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
					lbl.TextSize = 14
					lbl.Font = FONT_BOLD
					lbl.Parent = tag
				end
				local myHead = player.Character and player.Character:FindFirstChild("Head")
				local lbl = tag:FindFirstChild("Lbl")
				if lbl and myHead then
					local d = math.floor((head.Position - myHead.Position).Magnitude)
					lbl.Text = p.Name .. "  [" .. d .. "m]"
				end
			end
		end
	end
end)
local function clearNameTags()
	for _, p in ipairs(Players:GetPlayers()) do
		local c = p.Character
		if c then
			local h = c:FindFirstChild("Head")
			local t = h and h:FindFirstChild("MakaziNameTag")
			if t then t:Destroy() end
		end
	end
end
RunService.Stepped:Connect(function()
	if not noclipEnabled then return end
	local char = player.Character
	if not char then return end
	for _, part in ipairs(char:GetChildren()) do
		if part:IsA("BasePart") and part.CanCollide then part.CanCollide = false end
	end
end)
task.spawn(function()
	while true do
		if godEnabled then
			local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
			if hum then hum.MaxHealth = math.huge hum.Health = math.huge end
			task.wait(0.2)
		else
			task.wait(0.5)
		end
	end
end)
task.spawn(function()
	while true do
		local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
		if hum and hum.FloorMaterial ~= Enum.Material.Air then doubleJumpUsed = false end
		task.wait(0.1)
	end
end)
UserInputService.JumpRequest:Connect(function()
	local char = player.Character
	if not char then return end
	local hum = char:FindFirstChildOfClass("Humanoid")
	if not hum then return end
	if infJumpEnabled or mm2Kento.InfJump or n99_InfiniteJump then
		hum:ChangeState(Enum.HumanoidStateType.Jumping)
	elseif doubleJumpOn then
		local inAir = hum.FloorMaterial == Enum.Material.Air
		if inAir and not doubleJumpUsed then
			hum:ChangeState(Enum.HumanoidStateType.Jumping)
			doubleJumpUsed = true
		end
	end
end)
local function applyFullbright()
	if next(savedLighting) == nil then
		savedLighting = {
			Brightness = Lighting.Brightness,
			ClockTime = Lighting.ClockTime,
			FogEnd = Lighting.FogEnd,
			Ambient = Lighting.Ambient,
			OutdoorAmbient = Lighting.OutdoorAmbient,
			GlobalShadows = Lighting.GlobalShadows
		}
	end
	Lighting.Brightness = 3
	Lighting.ClockTime = 14
	Lighting.FogEnd = 100000
	Lighting.Ambient = Color3.fromRGB(180, 180, 180)
	Lighting.OutdoorAmbient = Color3.fromRGB(180, 180, 180)
	Lighting.GlobalShadows = false
end
local function removeFullbright()
	for k, v in pairs(savedLighting) do pcall(function() Lighting[k] = v end) end
	savedLighting = {}
end
player.Idled:Connect(function()
	if antiAfkEnabled then
		VirtualUser:CaptureController()
		VirtualUser:ClickButton2(Vector2.new())
	end
end)
task.spawn(function()
	while true do
		if lowGravityEnabled then workspace.Gravity = 50 else workspace.Gravity = savedGravity end
		task.wait(0.5)
	end
end)
task.spawn(function()
	while true do
		if autoSprintEnabled then
			local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
			if hum and hum.MoveDirection.Magnitude > 0.1 then hum.WalkSpeed = math.max(hum.WalkSpeed, 30) end
			task.wait(0.1)
		else
			task.wait(0.5)
		end
	end
end)
local lastSafeFlingPos = nil
local flingStrikes = 0
task.spawn(function()
	while true do
		if antiFlingEnabled then
			local char = player.Character
			local hrp = char and char:FindFirstChild("HumanoidRootPart")
			if hrp then
				local speed = hrp.AssemblyLinearVelocity.Magnitude
				local spin = hrp.AssemblyAngularVelocity.Magnitude
				if speed > 150 or spin > 50 then
					hrp.AssemblyLinearVelocity = Vector3.zero
					hrp.AssemblyAngularVelocity = Vector3.zero
					flingStrikes = flingStrikes + 1
					if flingStrikes > 4 and lastSafeFlingPos then
						pcall(function() hrp.CFrame = lastSafeFlingPos end)
						flingStrikes = 0
					end
				elseif speed < 40 and spin < 15 then
					lastSafeFlingPos = hrp.CFrame
					flingStrikes = math.max(0, flingStrikes - 1)
				end
			end
			task.wait(0.1)
		else
			task.wait(0.5)
		end
	end
end)
task.spawn(function()
	while true do
		if antiVoidOn then
			local char = player.Character
			local hrp = char and char:FindFirstChild("HumanoidRootPart")
			if hrp then
				if hrp.Position.Y > -50 and hrp.Position.Y < 500 then
					lastSafePos = hrp.CFrame
					lastSafeTime = tick()
				end
				if hrp.Position.Y < -100 and lastSafePos and tick() - lastSafeTime < 5 then
					hrp.CFrame = lastSafePos
					notify("Anti-Void спас 🛡", true)
				end
			end
			task.wait(0.3)
		else
			task.wait(0.5)
		end
	end
end)
RunService.Heartbeat:Connect(function()
	if not antiStunEnabled then return end
	local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
	if hum then
		local st = hum:GetState()
		if st == Enum.HumanoidStateType.FallingDown
		or st == Enum.HumanoidStateType.Ragdoll
		or st == Enum.HumanoidStateType.PlatformStanding then
			hum:ChangeState(Enum.HumanoidStateType.GettingUp)
		end
		pcall(function() hum.PlatformStand = false end)
	end
end)
task.spawn(function()
	while true do
		if autoRespawnEnabled then
			local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
			if hum and hum.Health <= 0 then
				task.wait(1)
				pcall(function() player:LoadCharacter() end)
			end
		end
		task.wait(0.5)
	end
end)
UserInputService.InputBegan:Connect(function(input, gp)
	if gp or not clickTPEnabled then return end
	if input.UserInputType ~= Enum.UserInputType.Touch
	and input.UserInputType ~= Enum.UserInputType.MouseButton1 then return end
	local cam = workspace.CurrentCamera
	if not cam then return end
	local ray = cam:ViewportPointToRay(input.Position.X, input.Position.Y)
	local params = RaycastParams.new()
	params.FilterType = Enum.RaycastFilterType.Exclude
	params.FilterDescendantsInstances = { player.Character }
	local res = workspace:Raycast(ray.Origin, ray.Direction * 5000, params)
	if res then
		local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
		if hrp then
			hrp.CFrame = CFrame.new(res.Position + Vector3.new(0, 3, 0))
			playSound(SOUND_IDS.click, 0.4, 1.4)
		end
	end
end)
task.spawn(function()
	while true do
		if killAllOn then
			local char = player.Character
			local hrp = char and char:FindFirstChild("HumanoidRootPart")
			local hum = char and char:FindFirstChildOfClass("Humanoid")
			if hrp and hum then
				local tool
				for _, t in ipairs(char:GetChildren()) do if t:IsA("Tool") then tool = t break end end
				if tool then
					pcall(function() hum:EquipTool(tool) end)
					for _, p in ipairs(Players:GetPlayers()) do
						if p ~= player and p.Character then
							local tr = p.Character:FindFirstChild("HumanoidRootPart")
							local th = p.Character:FindFirstChildOfClass("Humanoid")
							if tr and th and th.Health > 0 then
								local targetStartPos = tr.Position
								local stuckTime = 0
								while killAllOn and th.Health > 0 and tr.Parent and char.Parent and stuckTime < 3 do
									hrp.CFrame = tr.CFrame * CFrame.new(0, 0, 1.5)
									pcall(function() tool:Activate() end)
									task.wait(0.08)
									stuckTime = stuckTime + 0.08
									if (tr.Position - targetStartPos).Magnitude > 100 then break end
								end
								task.wait(killDelay)
							end
						end
					end
				end
			end
			task.wait(0.5)
		else
			task.wait(1)
		end
	end
end)
task.spawn(function()
	while true do
		if autoClickerEnabled then
			local cam = workspace.CurrentCamera
			if cam then
				local center = Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y / 2)
				pcall(function()
					VirtualUser:CaptureController()
					VirtualUser:ClickButton1(center)
				end)
			end
			task.wait(autoClickerDelay)
		else
			task.wait(0.5)
		end
	end
end)
task.spawn(function()
	while true do
		if hitboxEnabled then
			for _, p in ipairs(Players:GetPlayers()) do
				if p ~= player and p.Character then
					local hrp = p.Character:FindFirstChild("HumanoidRootPart")
					if hrp then
						if not hitboxOriginalSizes[p] then
							hitboxOriginalSizes[p] = hrp.Size
						end
						hrp.Size = Vector3.new(hitboxSize, hitboxSize, hitboxSize)
						hrp.Transparency = 0.7
						hrp.CanCollide = false
						hrp.Massless = true
					end
				end
			end
			task.wait(0.3)
		else
			task.wait(1)
		end
	end
end)
local function clearHitbox()
	for _, p in ipairs(Players:GetPlayers()) do
		if p.Character then
			local hrp = p.Character:FindFirstChild("HumanoidRootPart")
			if hrp then
				hrp.Size = hitboxOriginalSizes[p] or Vector3.new(2, 2, 1)
				hrp.Transparency = 1
				hrp.CanCollide = false
				hrp.Massless = true
			end
		end
	end
	hitboxOriginalSizes = {}
end
task.spawn(function()
	while true do
		if infiniteAmmoEnabled then
			local char = player.Character
			if char then
				for _, tool in ipairs(char:GetChildren()) do
					if tool:IsA("Tool") then
						for _, v in ipairs(tool:GetDescendants()) do
							if v:IsA("IntValue") or v:IsA("NumberValue") then
								local n = v.Name:lower()
								if n:find("ammo") or n:find("bullet") or n:find("mag") then pcall(function() v.Value = 999 end) end
							end
						end
					end
				end
			end
			task.wait(0.5)
		else
			task.wait(1)
		end
	end
end)
local fpsBoostedObjects = {}
task.spawn(function()
	while true do
		if fpsBoostEnabled then
			for _, obj in ipairs(workspace:GetDescendants()) do
				if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Smoke") or obj:IsA("Fire") or obj:IsA("Sparkles") then
					if obj.Enabled then
						table.insert(fpsBoostedObjects, obj)
						pcall(function() obj.Enabled = false end)
					end
				end
			end
			task.wait(2)
		else
			for _, obj in ipairs(fpsBoostedObjects) do pcall(function() obj.Enabled = true end) end
			fpsBoostedObjects = {}
			task.wait(2)
		end
	end
end)

-- MM2 KENTO
local function mm2GetRole(pl)
	if not pl then return "I" end
	local c = pl.Character
	local b = pl:FindFirstChild("Backpack")
	if (b and (b:FindFirstChild("Knife") or b:FindFirstChild("KnifeVisuals")))
	   or (c and (c:FindFirstChild("Knife") or c:FindFirstChild("KnifeVisuals")
	   or (c:FindFirstChild("LeftHand") and c.LeftHand:FindFirstChild("KnifeVisuals")))) then return "M" end
	if (b and (b:FindFirstChild("Gun") or b:FindFirstChild("GunVisuals")))
	   or (c and (c:FindFirstChild("Gun") or c:FindFirstChild("GunVisuals")
	   or (c:FindFirstChild("LeftHand") and c.LeftHand:FindFirstChild("GunVisuals")))) then return "S" end
	if pl:FindFirstChild("Status") and pl.Status:FindFirstChild("Role") then
		local r = pl.Status.Role.Value
		if r == "Murderer" then return "M" end
		if r == "Sheriff" or r == "Hero" then return "S" end
	end
	return "I"
end
task.spawn(function()
	while true do
		if mm2Kento.AutoFarm then
			local char = player.Character
			local hrp = char and char:FindFirstChild("HumanoidRootPart")
			if hrp then
				local folder = workspace:FindFirstChild("Normal") or workspace
				local closest, dist = nil, math.huge
				for _, o in pairs(folder:GetDescendants()) do
					if o:IsA("BasePart") and o.Parent and not mm2Coins[o]
					   and (o.Name:sub(1,4) == "Coin" or o.Name == "GoldCoin"
					   or o.Name == "CandyCane" or o:GetAttribute("Coin")) then
						local d = (hrp.Position - o.Position).Magnitude
						if d < dist then closest, dist = o, d end
					end
				end
				if closest then
					mm2Coins[closest] = true
					task.delay(5, function() mm2Coins[closest] = nil end)
					local tw = TweenService:Create(hrp, TweenInfo.new(dist / 22, Enum.EasingStyle.Linear), { CFrame = closest.CFrame })
					tw:Play()
					tw.Completed:Wait()
				end
			end
			task.wait(0.1)
		else
			task.wait(0.5)
		end
	end
end)
task.spawn(function()
	while true do
		if mm2Kento.KillAura then
			local char = player.Character
			local hrp = char and char:FindFirstChild("HumanoidRootPart")
			local knife = char and char:FindFirstChild("Knife")
			if hrp and knife and knife:FindFirstChild("Handle") then
				for _, v in pairs(Players:GetPlayers()) do
					if v ~= player and v.Character then
						local vhrp = v.Character:FindFirstChild("HumanoidRootPart")
						if vhrp and (hrp.Position - vhrp.Position).Magnitude <= 16 then
							pcall(function()
								knife:Activate()
								if firetouchinterest then
									firetouchinterest(vhrp, knife.Handle, 0)
									firetouchinterest(vhrp, knife.Handle, 1)
								end
							end)
						end
					end
				end
			end
			task.wait(0.1)
		else
			task.wait(0.5)
		end
	end
end)
RunService.Stepped:Connect(function()
	local char = player.Character
	if not char then return end
	if mm2Kento.Noclip or mm2Kento.AutoFarm then
		for _, p in pairs(char:GetChildren()) do
			if p:IsA("BasePart") and p.CanCollide then p.CanCollide = false end
		end
	end
	if mm2Kento.TPWalk then
		local hum = char:FindFirstChildOfClass("Humanoid")
		local hrp = char:FindFirstChild("HumanoidRootPart")
		if hum and hrp and hum.MoveDirection.Magnitude > 0 then
			hrp.CFrame = hrp.CFrame + hum.MoveDirection * mm2Kento.TPWalkSpeed
		end
	end
end)
RunService.RenderStepped:Connect(function()
	if not mm2Kento.AimBot then return end
	local char = player.Character
	if not char or not char:FindFirstChild("Gun") then return end
	local camera = workspace.CurrentCamera
	for _, p in pairs(Players:GetPlayers()) do
		if p ~= player and p.Character then
			local vhrp = p.Character:FindFirstChild("HumanoidRootPart")
			if vhrp and mm2GetRole(p) == "M" then
				camera.CFrame = CFrame.new(camera.CFrame.Position, vhrp.Position)
				break
			end
		end
	end
end)
RunService.Heartbeat:Connect(function()
	if not mm2Kento.ESP then return end
	for _, p in pairs(Players:GetPlayers()) do
		if p ~= player and p.Character then
			local vhrp = p.Character:FindFirstChild("HumanoidRootPart")
			if vhrp then
				local box = p.Character:FindFirstChild("KentoBox")
				if not box then
					box = Instance.new("BoxHandleAdornment")
					box.Name = "KentoBox"
					box.AlwaysOnTop = true
					box.ZIndex = 10
					box.Transparency = 0.6
					box.Size = Vector3.new(4, 5, 1)
					box.Parent = p.Character
				end
				box.Adornee = vhrp
				local r = mm2GetRole(p)
				if r == "M" then box.Color3 = Color3.fromRGB(255, 50, 50)
				elseif r == "S" then box.Color3 = Color3.fromRGB(50, 100, 255)
				else box.Color3 = Color3.fromRGB(50, 255, 100) end
			end
		end
	end
end)
local function mm2ClearESP()
	for _, p in pairs(Players:GetPlayers()) do
		if p.Character then
			local box = p.Character:FindFirstChild("KentoBox")
			if box then box:Destroy() end
		end
	end
end

-- Sheriff Auto-Shoot
local function mm2IsSheriff()
	local char = player.Character
	if not char then return false end
	local c = char:FindFirstChild("Gun") or char:FindFirstChild("GunVisuals")
	if c then return true end
	local lh = char:FindFirstChild("LeftHand")
	if lh and lh:FindFirstChild("GunVisuals") then return true end
	local bp = player:FindFirstChild("Backpack")
	if bp and (bp:FindFirstChild("Gun") or bp:FindFirstChild("GunVisuals")) then return true end
	if player:FindFirstChild("Status") and player.Status:FindFirstChild("Role") then
		local r = player.Status.Role.Value
		if r == "Sheriff" or r == "Hero" then return true end
	end
	return false
end
local function mm2GetMurderer()
	local myChar = player.Character
	local myHRP = myChar and myChar:FindFirstChild("HumanoidRootPart")
	if not myHRP then return nil end
	local best, bestDist = nil, mm2SheriffRange
	for _, p in ipairs(Players:GetPlayers()) do
		if p ~= player and p.Character then
			if mm2GetRole(p) == "M" then
				local hum = p.Character:FindFirstChildOfClass("Humanoid")
				if hum and hum.Health > 0 then
					local tHRP = p.Character:FindFirstChild("HumanoidRootPart")
					local tHead = p.Character:FindFirstChild("Head")
					if tHRP and tHead then
						local d = (tHRP.Position - myHRP.Position).Magnitude
						if d < bestDist then
							if mm2SheriffWallCheck then
								local params = RaycastParams.new()
								params.FilterType = Enum.RaycastFilterType.Exclude
								params.FilterDescendantsInstances = { myChar }
								params.IgnoreWater = true
								local ray = workspace:Raycast(myHRP.Position, tHead.Position - myHRP.Position, params)
								if (ray == nil) or ray.Instance:IsDescendantOf(p.Character) then
									bestDist = d
									best = { hrp = tHRP, head = tHead, char = p.Character }
								end
							else
								bestDist = d
								best = { hrp = tHRP, head = tHead, char = p.Character }
							end
						end
					end
				end
			end
		end
	end
	return best
end
local function mm2EnsureGunEquipped()
	local char = player.Character
	if not char then return nil end
	local gun = char:FindFirstChild("Gun")
	if gun then return gun end
	local hum = char:FindFirstChildOfClass("Humanoid")
	local bp = player:FindFirstChild("Backpack")
	if hum and bp then
		local g = bp:FindFirstChild("Gun")
		if g then
			pcall(function() hum:EquipTool(g) end)
			task.wait(0.1)
			return char:FindFirstChild("Gun")
		end
	end
	return nil
end
task.spawn(function()
	while true do
		if mm2SheriffAuto then
			if mm2IsSheriff() then
				local gun = mm2EnsureGunEquipped()
				if gun and gun.Parent == player.Character then
					local target = mm2GetMurderer()
					if target then
						local camera = workspace.CurrentCamera
						local myHRP = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
						if camera and myHRP then
							local aimPos = target.head.Position
							if mm2SheriffPredict then
								local vel = target.hrp.AssemblyLinearVelocity or Vector3.zero
								local dist = (aimPos - camera.CFrame.Position).Magnitude
								aimPos = aimPos + vel * math.min(dist / 500, 0.15)
							end
							camera.CFrame = CFrame.new(camera.CFrame.Position, aimPos)
							if tick() - mm2SheriffLastShot > mm2SheriffDelay then
								pcall(function() gun:Activate() end)
								mm2SheriffLastShot = tick()
							end
						end
					end
				end
			end
			task.wait(0.03)
		else
			task.wait(0.3)
		end
	end
end)

-- ============================================================
-- 99 NIGHTS IN THE FOREST
-- ============================================================
local function n99_Char()
	local c = player.Character
	return c, c and c:FindFirstChild("HumanoidRootPart"), c and c:FindFirstChildOfClass("Humanoid")
end
local function n99_GetTool(namePart)
	local char, _, hum = n99_Char()
	if not char or not hum then return nil end
	for _, t in ipairs(char:GetChildren()) do
		if t:IsA("Tool") and t.Name:lower():find(namePart) then return t end
	end
	local bp = player:FindFirstChild("Backpack")
	if bp then
		for _, t in ipairs(bp:GetChildren()) do
			if t:IsA("Tool") and t.Name:lower():find(namePart) then
				pcall(function() hum:EquipTool(t) end)
				task.wait(0.1)
				return char:FindFirstChild(t.Name)
			end
		end
	end
	return nil
end
-- Auto Campfire
task.spawn(function()
	while true do
		if n99_AutoCampfire and tick() - n99_LastCampfireCheck > 2 then
			n99_LastCampfireCheck = tick()
			local _, hrp, hum = n99_Char()
			if hrp and hum and hum.Health > 0 then
				local fuelTool = n99_GetTool("fuel") or n99_GetTool("wood") or n99_GetTool("log") or n99_GetTool("coal")
				if fuelTool then
					local campfire = workspace:FindFirstChild("Campfire", true)
					if campfire and campfire:IsA("BasePart") then
						local old = hrp.CFrame
						hrp.CFrame = campfire.CFrame * CFrame.new(0, 2, 0)
						task.wait(0.2)
						pcall(function() fuelTool:Activate() end)
						task.wait(0.1)
						hrp.CFrame = old
					end
				end
			end
		end
		task.wait(1)
	end
end)
-- Auto Farm
task.spawn(function()
	while true do
		if n99_AutoFarm then
			local _, hrp, hum = n99_Char()
			if hrp and hum and hum.Health > 0 then
				local best, dist = nil, 120
				for _, obj in ipairs(workspace:GetDescendants()) do
					if obj:IsA("BasePart") and obj.Parent then
						local n = obj.Name:lower()
						if n:find("diamond") or n:find("flower") or n:find("berry") or n:find("sapling") or n:find("gold") then
							local d = (obj.Position - hrp.Position).Magnitude
							if d < dist then dist = d best = obj end
						end
					end
				end
				if best then
					hrp.CFrame = best.CFrame * CFrame.new(0, 2, 0)
					task.wait(0.25)
				end
			end
			task.wait(0.15)
		else task.wait(0.5) end
	end
end)
-- Auto Chop
task.spawn(function()
	while true do
		if n99_AutoChop then
			local _, hrp, hum = n99_Char()
			if hrp and hum then
				local tool = n99_GetTool("axe") or n99_GetTool("pickaxe")
				if tool then
					local best, dist = nil, 35
					for _, obj in ipairs(workspace:GetDescendants()) do
						if obj:IsA("BasePart") and obj.Name:lower():find("tree") then
							local d = (obj.Position - hrp.Position).Magnitude
							if d < dist then dist = d best = obj end
						end
					end
					if best then
						hrp.CFrame = best.CFrame * CFrame.new(0, 0, 3)
						pcall(function() tool:Activate() end)
					end
				end
			end
			task.wait(0.35)
		else task.wait(0.5) end
	end
end)
-- Tree Aura
task.spawn(function()
	while true do
		if n99_TreeAura then
			local _, hrp, hum = n99_Char()
			if hrp and hum then
				local tool = n99_GetTool("axe")
				if tool then
					for _, obj in ipairs(workspace:GetDescendants()) do
						if obj:IsA("BasePart") and obj.Name:lower():find("tree") then
							if (obj.Position - hrp.Position).Magnitude <= n99_TreeAuraRange then
								pcall(function() tool:Activate() end)
							end
						end
					end
				end
			end
			task.wait(0.15)
		else task.wait(0.5) end
	end
end)
-- Auto Eat
task.spawn(function()
	while true do
		if n99_AutoEat then
			local char, _, hum = n99_Char()
			if char and hum and hum.Health > 0 then
				local hunger = char:FindFirstChild("Hunger") or char:FindFirstChild("Food")
				if hunger and hunger:IsA("NumberValue") and hunger.Value < 50 then
					local food = n99_GetTool("food") or n99_GetTool("berry") or n99_GetTool("meat") or n99_GetTool("apple") or n99_GetTool("carrot")
					if food then
						pcall(function() food:Activate() end)
					end
				end
			end
			task.wait(1.5)
		else task.wait(2) end
	end
end)
-- Kill Aura
task.spawn(function()
	while true do
		if n99_KillAura then
			local char, hrp, hum = n99_Char()
			if hrp and hum then
				local tool
				for _, t in ipairs(char:GetChildren()) do
					if t:IsA("Tool") then tool = t break end
				end
				if tool then
					for _, p in ipairs(Players:GetPlayers()) do
						if p ~= player and p.Character then
							local tHRP = p.Character:FindFirstChild("HumanoidRootPart")
							local tHum = p.Character:FindFirstChildOfClass("Humanoid")
							if tHRP and tHum and tHum.Health > 0 and (tHRP.Position - hrp.Position).Magnitude <= n99_KillAuraRange then
								pcall(function() tool:Activate() end)
							end
						end
					end
					for _, obj in ipairs(workspace:GetDescendants()) do
						if obj:IsA("Humanoid") and obj.Parent ~= char and obj.Health > 0 then
							local model = obj.Parent
							local tHRP = model and (model:FindFirstChild("HumanoidRootPart") or model:FindFirstChild("Torso"))
							if tHRP and (tHRP.Position - hrp.Position).Magnitude <= n99_KillAuraRange then
								pcall(function() tool:Activate() end)
							end
						end
					end
				end
			end
			task.wait(0.15)
		else task.wait(0.5) end
	end
end)
-- God Mode + Freeze Enemies
RunService.Heartbeat:Connect(function()
	if n99_GodMode then
		local _, _, hum = n99_Char()
		if hum then hum.MaxHealth = math.huge hum.Health = math.huge end
	end
	if n99_FreezeEnemies then
		for _, obj in ipairs(workspace:GetDescendants()) do
			if obj:IsA("Humanoid") and obj.Parent ~= player.Character and obj.Health > 0 then
				local model = obj.Parent
				local hrp = model and model:FindFirstChild("HumanoidRootPart")
				if hrp and hrp:IsA("BasePart") then hrp.Anchored = true end
			end
		end
	end
end)
-- Noclip (99)
RunService.Stepped:Connect(function()
	if not n99_Noclip then return end
	local char = player.Character
	if char then
		for _, p in ipairs(char:GetChildren()) do
			if p:IsA("BasePart") and p.CanCollide then p.CanCollide = false end
		end
	end
end)
-- ESP
local function n99_AddESP(obj, color, nameTag)
	if not obj or obj:FindFirstChild("N99_ESP") then return end
	local hl = Instance.new("Highlight")
	hl.Name = "N99_ESP"
	hl.FillTransparency = 0.55
	hl.OutlineColor = color
	hl.Parent = obj
	if nameTag then
		local bb = Instance.new("BillboardGui")
		bb.Name = "N99_Tag"
		bb.Size = UDim2.new(0, 120, 0, 18)
		bb.StudsOffsetWorldSpace = Vector3.new(0, 2, 0)
		bb.AlwaysOnTop = true
		bb.Parent = obj
		local lbl = Instance.new("TextLabel")
		lbl.Size = UDim2.new(1, 0, 1, 0)
		lbl.BackgroundTransparency = 1
		lbl.Text = nameTag
		lbl.TextColor3 = color
		lbl.TextStrokeTransparency = 0
		lbl.TextSize = 12
		lbl.Font = Enum.Font.GothamBold
		lbl.Parent = bb
	end
end
RunService.RenderStepped:Connect(function()
	if not (n99_ESP_Chests or n99_ESP_Enemies or n99_ESP_Children or n99_ESP_Players) then return end
	for _, obj in ipairs(workspace:GetDescendants()) do
		local n = obj.Name:lower()
		if n99_ESP_Chests and obj:IsA("BasePart") and n:find("chest") then
			n99_AddESP(obj, Color3.fromRGB(255, 215, 0), "СУНДУК")
		end
		if n99_ESP_Enemies and obj:IsA("Model") and (n:find("wolf") or n:find("bear") or n:find("cultist") or n:find("enemy")) then
			local hrp = obj:FindFirstChild("HumanoidRootPart") or obj:FindFirstChild("Torso")
			if hrp then n99_AddESP(hrp, Color3.fromRGB(255, 50, 50), "ВРАГ") end
		end
		if n99_ESP_Children and obj:IsA("Model") and (n:find("child") or n:find("kid") or n:find("lost")) then
			local hrp = obj:FindFirstChild("HumanoidRootPart") or obj:FindFirstChild("Torso")
			if hrp then n99_AddESP(hrp, Color3.fromRGB(50, 255, 255), "РЕБЁНОК") end
		end
		if n99_ESP_Players and obj:IsA("Model") and Players:GetPlayerFromCharacter(obj) and obj ~= player.Character then
			local hrp = obj:FindFirstChild("HumanoidRootPart")
			if hrp then n99_AddESP(hrp, COLORS.accent, "ИГРОК") end
		end
	end
end)
-- Bring Items
task.spawn(function()
	while true do
		if n99_BringItems then
			local _, hrp, _ = n99_Char()
			if hrp then
				for _, obj in ipairs(workspace:GetDescendants()) do
					if obj:IsA("BasePart") and obj.Parent then
						local n = obj.Name:lower()
						if n:find("diamond") or n:find("gold") or n:find("coin") or n:find("chest") then
							if (obj.Position - hrp.Position).Magnitude < 150 then
								pcall(function() obj.CFrame = hrp.CFrame * CFrame.new(0, 2, 0) end)
							end
						end
					end
				end
			end
			task.wait(0.5)
		else task.wait(1) end
	end
end)
-- Auto Win (Skip Day)
task.spawn(function()
	while true do
		if n99_AutoWin then
			local _, hrp, hum = n99_Char()
			if hrp and hum and hum.Health > 0 then
				local skip = workspace:FindFirstChild("SkipDay", true) or workspace:FindFirstChild("NextDay", true)
				if skip and skip:IsA("BasePart") then hrp.CFrame = skip.CFrame end
			end
			task.wait(2)
		else task.wait(3) end
	end
end)

-- RIVALS
local autoWinEnabled = false
local autoWinRange = 500
local autoWinSmooth = 0.35
local autoWinFireRate = 0.1
local autoWinLastFire = 0
local autoWinTarget = nil
local autoWinHeadshotBias = 0.85
local function getRivalsEnemy()
	local myChar = player.Character
	local myHRP = myChar and myChar:FindFirstChild("HumanoidRootPart")
	if not myHRP then return nil end
	local camera = workspace.CurrentCamera
	if not camera then return nil end
	local best, bestScore = nil, math.huge
	for _, p in ipairs(Players:GetPlayers()) do
		if p ~= player and p.Character then
			if p.Team and player.Team and p.Team == player.Team then continue end
			local hum = p.Character:FindFirstChildOfClass("Humanoid")
			if not hum or hum.Health <= 0 then continue end
			local head = p.Character:FindFirstChild("Head")
			local hrp = p.Character:FindFirstChild("HumanoidRootPart")
			if not head or not hrp then continue end
			local dist = (hrp.Position - myHRP.Position).Magnitude
			if dist > autoWinRange then continue end
			local params = RaycastParams.new()
			params.FilterType = Enum.RaycastFilterType.Exclude
			params.FilterDescendantsInstances = { myChar }
			params.IgnoreWater = true
			local ray = workspace:Raycast(myHRP.Position, head.Position - myHRP.Position, params)
			local visible = (ray == nil) or ray.Instance:IsDescendantOf(p.Character)
			if not visible then continue end
			if dist < bestScore then bestScore = dist best = { char = p.Character, head = head, hrp = hrp } end
		end
	end
	return best
end
local function tryFire()
	local char = player.Character
	if not char then return end
	for _, t in ipairs(char:GetChildren()) do if t:IsA("Tool") then pcall(function() t:Activate() end) return end end
end
RunService.RenderStepped:Connect(function()
	if not autoWinEnabled then return end
	local camera = workspace.CurrentCamera
	local myChar = player.Character
	if not myChar or not camera then return end
	local target = autoWinTarget
	if target then
		local stillAlive = target.char and target.char.Parent and target.char:FindFirstChildOfClass("Humanoid") and target.char:FindFirstChildOfClass("Humanoid").Health > 0
		if not stillAlive then autoWinTarget = nil target = nil end
	end
	if not target then target = getRivalsEnemy() autoWinTarget = target end
	if target and target.head and target.head.Parent then
		local aimPos = target.head.Position
		if autoWinHeadshotBias < 1 then aimPos = aimPos:Lerp(target.hrp.Position, 1 - autoWinHeadshotBias) end
		local vel = target.hrp.AssemblyLinearVelocity or Vector3.zero
		local dist = (aimPos - camera.CFrame.Position).Magnitude
		local predictTime = math.min(dist / 500, 0.12)
		aimPos = aimPos + vel * predictTime
		local targetCF = CFrame.new(camera.CFrame.Position, aimPos)
		camera.CFrame = camera.CFrame:Lerp(targetCF, autoWinSmooth)
		local sp, onScreen = camera:WorldToViewportPoint(aimPos)
		local center = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2)
		local aimDist = (Vector2.new(sp.X, sp.Y) - center).Magnitude
		if onScreen and aimDist < 60 and tick() - autoWinLastFire > autoWinFireRate then tryFire() autoWinLastFire = tick() end
	end
end)

-- ТАБЫ
local tabMain = makeTab("Главное", "🏠")
local tabVisual = makeTab("Визуал", "👁")
local tabPlayers = makeTab("Игроки", "👥")
local tabGames = makeTab("Игры", "🎮")
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
	if hum then hum.UseJumpPower = true hum.JumpPower = v end
end)
makeToggle(tabMain, "🦘  Бесконечный прыжок", false, function(s) infJumpEnabled = s notify(s and "Inf Jump вкл" or "Inf Jump выкл", s) end)
makeToggle(tabMain, "🦘  Двойной прыжок", false, function(s) doubleJumpOn = s doubleJumpUsed = false notify(s and "Двойной вкл" or "Двойной выкл", s) end)
makeToggle(tabMain, "🏃  Авто-бег", false, function(s) autoSprintEnabled = s notify(s and "Авто-бег вкл" or "Авто-бег выкл", s) end)
sectionLabel(tabMain, "Полёт")
makeToggle(tabMain, "✈  Fly GUI V3", false, function(s) if s then loadFlyGUI_V3() else unloadFlyGUI_V3() end end)
sectionLabel(tabMain, "Бой")
makeToggle(tabMain, "⚔  Kill All (нужно оружие)", false, function(s) killAllOn = s notify(s and "Kill All вкл" or "Kill All выкл", s) end)
makeSlider(tabMain, "Задержка между ударами", 1, 30, 15, function(v) killDelay = v / 100 end)
sectionLabel(tabMain, "Физика")
makeToggle(tabMain, "🚪  Noclip", false, function(s)
	noclipEnabled = s
	if not s then
		local char = player.Character
		if char then for _, part in ipairs(char:GetDescendants()) do if part:IsA("BasePart") then part.CanCollide = true end end end
	end
	notify(s and "Noclip вкл" or "Noclip выкл", s)
end)
makeToggle(tabMain, "🛡  Бессмертие", false, function(s)
	godEnabled = s
	local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
	if hum then if s then hum.MaxHealth = math.huge hum.Health = math.huge else hum.MaxHealth = 100 hum.Health = 100 end end
	notify(s and "God вкл" or "God выкл", s)
end)
makeToggle(tabMain, "🎈  Низкая гравитация", false, function(s) lowGravityEnabled = s if not s then workspace.Gravity = savedGravity end notify(s and "Low G вкл" or "Low G выкл", s) end)
makeToggle(tabMain, "🕐  Анти-АФК", false, function(s) antiAfkEnabled = s notify(s and "Anti-AFK вкл" or "Anti-AFK выкл", s) end)
makeToggle(tabMain, "🛡  Анти-Флинг", false, function(s) antiFlingEnabled = s notify(s and "Anti-Fling вкл" or "Anti-Fling выкл", s) end)
makeToggle(tabMain, "🛡  Anti-Void", false, function(s) antiVoidOn = s notify(s and "Anti-Void вкл" or "Anti-Void выкл", s) end)
makeToggle(tabMain, "🛡  Анти-стан", false, function(s) antiStunEnabled = s notify(s and "Anti-Stun вкл" or "Anti-Stun выкл", s) end)

-- ВИЗУАЛ
sectionLabel(tabVisual, "Подсветка")
makeToggle(tabVisual, "👁  ESP игроков", false, function(s) espEnabled = s if not s then clearESP() end notify(s and "ESP вкл" or "ESP выкл", s) end)
makeToggle(tabVisual, "🏷  Имена над игроками", false, function(s) espNamesEnabled = s if not s then clearNameTags() end notify(s and "NameTags вкл" or "NameTags выкл", s) end)
sectionLabel(tabVisual, "Бой")
makeToggle(tabVisual, "🎯  Автонаведение", false, function(s)
	aimEnabled = s
	if not s then aimCurrentTarget = nil aimLockedKey = nil end
	notify(s and "Aim вкл 🎯" or "Aim выкл", s)
end)
makeSlider(tabVisual, "Плавность наведения", 1, 20, 4, function(v) aimSmooth = 0.9 / v end)
makeSlider(tabVisual, "Дистанция наведения", 50, 2000, 500, function(v) aimFOV = v end)
makeSlider(tabVisual, "Задержка смены цели", 1, 20, 5, function(v) aimSwitchDelay = v / 10 end)
makeToggle(tabVisual, "👁  Только видимые цели", false, function(s) aimVisibleOnly = s notify(s and "Видимые" or "Все цели", s) end)
makeToggle(tabVisual, "🤝  Игнорировать тиммейтов", false, function(s) aimTeamCheck = s notify(s and "Тиммейты игнор" or "Все цели", s) end)
makeToggle(tabVisual, "🔮  Предикция движения", true, function(s) aimPrediction = s notify(s and "Предикция вкл" or "Предикция выкл", s) end)
makeToggle(tabVisual, "🔫  TriggerBot", false, function(s) aimTriggerBot = s notify(s and "TriggerBot вкл" or "TriggerBot выкл", s) end)
makeSlider(tabVisual, "Радиус триггера (пиксели)", 10, 100, 40, function(v) aimTriggerRadius = v end)
makeButton(tabVisual, "🎯  Метод наведения: AUTO", function()
	if aimMethod == "auto" then aimMethod = "camera" notify("Метод: Camera", true)
	elseif aimMethod == "camera" then aimMethod = "humanoid" notify("Метод: Humanoid", true)
	elseif aimMethod == "humanoid" then aimMethod = "hybrid" notify("Метод: Гибрид", true)
	else aimMethod = "auto" notify("Метод: AUTO", true) end
end)
makeToggle(tabVisual, "📦  Расширитель хитбокса", false, function(s) hitboxEnabled = s if not s then clearHitbox() end notify(s and "Hitbox вкл" or "Hitbox выкл", s) end)
makeSlider(tabVisual, "Размер хитбокса", 2, 20, 5, function(v) hitboxSize = v end)
makeToggle(tabVisual, "🔫  Бесконечные патроны", false, function(s) infiniteAmmoEnabled = s notify(s and "Inf Ammo вкл" or "Inf Ammo выкл", s) end)
makeToggle(tabVisual, "🖱  Автокликер", false, function(s) autoClickerEnabled = s notify(s and "AutoClicker вкл" or "AutoClicker выкл", s) end)
makeSlider(tabVisual, "Скорость кликера (в сек)", 1, 50, 10, function(v) autoClickerDelay = 1 / v end)
sectionLabel(tabVisual, "Камера и свет")
makeSlider(tabVisual, "Обзор камеры", 40, 120, 70, function(v)
	local camera = workspace.CurrentCamera
	if camera then camera.FieldOfView = v end
end)
makeToggle(tabVisual, "☀  Яркое освещение", false, function(s)
	fullbrightEnabled = s
	if s then applyFullbright() notify("Fullbright вкл", true) else removeFullbright() notify("Fullbright выкл", false) end
end)
makeToggle(tabVisual, "🎬  Кинокамера", false, function(s)
	cinematicEnabled = s
	if not s then local camera = workspace.CurrentCamera if camera then camera.FieldOfView = 70 end end
	notify(s and "Cinematic вкл" or "Cinematic выкл", s)
end)
sectionLabel(tabVisual, "Производительность")
makeToggle(tabVisual, "⚡  Ускорение ФПС", false, function(s) fpsBoostEnabled = s notify(s and "FPS Boost вкл" or "FPS Boost выкл", s) end)
sectionLabel(tabVisual, "Эффекты")
makeToggle(tabVisual, "🔴  Красная аура", false, function(s)
	auraEnabled = s
	if s then
		local char = player.Character
		local hrp = char and char:FindFirstChild("HumanoidRootPart")
		if hrp then
			for _, p in ipairs(auraParts) do pcall(function() p:Destroy() end) end
			auraParts = {}
			local disk = Instance.new("Part")
			disk.Shape = Enum.PartType.Cylinder
			disk.Size = Vector3.new(0.2, 10, 10)
			disk.Material = Enum.Material.Neon
			disk.Color = Color3.fromRGB(255, 30, 40)
			disk.Transparency = 0.35
			disk.Anchored = true
			disk.CanCollide = false
			disk.CanQuery = false
			disk.CastShadow = false
			disk.Parent = workspace
			table.insert(auraParts, disk)
			local ring = Instance.new("Part")
			ring.Shape = Enum.PartType.Cylinder
			ring.Size = Vector3.new(0.25, 11, 11)
			ring.Material = Enum.Material.Neon
			ring.Color = Color3.fromRGB(255, 0, 0)
			ring.Transparency = 0.1
			ring.Anchored = true
			ring.CanCollide = false
			ring.Parent = workspace
			table.insert(auraParts, ring)
			for i = 1, 8 do
				local dot = Instance.new("Part")
				dot.Shape = Enum.PartType.Ball
				dot.Size = Vector3.new(0.6, 0.6, 0.6)
				dot.Material = Enum.Material.Neon
				dot.Color = Color3.fromRGB(255, 50, 60)
				dot.Anchored = true
				dot.CanCollide = false
				dot.Parent = workspace
				table.insert(auraParts, dot)
			end
			local light = Instance.new("PointLight")
			light.Color = Color3.fromRGB(255, 30, 40)
			light.Brightness = 3
			light.Range = 12
			light.Parent = disk
			local auraStart = tick()
			local auraRotation = 0
			if auraConn then auraConn:Disconnect() end
			auraConn = RunService.RenderStepped:Connect(function(dt)
				if not auraEnabled then return end
				local c = player.Character
				local h = c and c:FindFirstChild("HumanoidRootPart")
				if not h then return end
				local t = tick() - auraStart
				auraRotation += dt * 90
				local diskPos = h.Position - Vector3.new(0, 2.7, 0)
				local pulse2 = 1 + math.sin(t * 3) * 0.08
				if auraParts[1] then auraParts[1].CFrame = CFrame.new(diskPos) * CFrame.Angles(0, 0, math.rad(90)) auraParts[1].Size = Vector3.new(0.2, 10 * pulse2, 10 * pulse2) end
				if auraParts[2] then auraParts[2].CFrame = CFrame.new(diskPos) * CFrame.Angles(0, 0, math.rad(90)) auraParts[2].Size = Vector3.new(0.25, 11 * pulse2, 11 * pulse2) end
				local dotRadius = 5.2 * pulse2
				local count = 0
				for i = 3, 10 do
					local dot = auraParts[i]
					if dot then
						count += 1
						local angle = math.rad(auraRotation + count * 45)
						local x = math.cos(angle) * dotRadius
						local z = math.sin(angle) * dotRadius
						local y = math.sin(t * 2 + count) * 0.4
						dot.CFrame = CFrame.new(diskPos + Vector3.new(x, y, z))
					end
				end
			end)
		end
		notify("Аура вкл 🔴", true)
	else
		if auraConn then auraConn:Disconnect() auraConn = nil end
		for _, p in ipairs(auraParts) do pcall(function() p:Destroy() end) end
		auraParts = {}
		notify("Аура выкл", false)
	end
end)

-- ИГРОКИ
local playerButtons = {}
local function refreshPlayerList()
	for _, b in ipairs(playerButtons) do b:Destroy() end
	playerButtons = {}
	local sorted = {}
	for _, p in ipairs(Players:GetPlayers()) do
		if p ~= player then table.insert(sorted, p) end
	end
	table.sort(sorted, function(a, b) return a.Name:lower() < b.Name:lower() end)
	for _, p in ipairs(sorted) do
		local btn = Instance.new("TextButton")
		btn.Size = UDim2.new(1, 0, 0, 34)
		btn.BackgroundColor3 = COLORS.card
		btn.BackgroundTransparency = 0.1
		btn.BorderSizePixel = 0
		btn.Text = "🎯  " .. p.Name
		btn.TextColor3 = COLORS.text
		btn.TextSize = 11
		btn.Font = FONT_BOLD
		btn.AutoButtonColor = false
		btn.ZIndex = 4
		btn.Parent = tabPlayers
		corner(btn, 7)
		table.insert(playerButtons, btn)
		btn.MouseEnter:Connect(function()
			TweenService:Create(btn, TweenInfo.new(0.15), { BackgroundColor3 = COLORS.cardHover }):Play()
		end)
		btn.MouseLeave:Connect(function()
			TweenService:Create(btn, TweenInfo.new(0.15), { BackgroundColor3 = COLORS.card }):Play()
		end)
		btn.MouseButton1Click:Connect(function()
			clickSound()
			local myHRP = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
			local tHRP = p.Character and p.Character:FindFirstChild("HumanoidRootPart")
			if myHRP and tHRP then
				myHRP.CFrame = tHRP.CFrame * CFrame.new(0, 0, 3)
				notify("TP к " .. p.Name, true)
			else
				notify("Цель недоступна", false)
			end
		end)
	end
end
refreshPlayerList()
Players.PlayerAdded:Connect(function() task.wait(0.5) refreshPlayerList() end)
Players.PlayerRemoving:Connect(function() task.wait(0.5) refreshPlayerList() end)
makeButton(tabPlayers, "🔄  Обновить список", refreshPlayerList)
makeButton(tabPlayers, "🎯  TP ко всем по очереди", function()
	task.spawn(function()
		for _, p in ipairs(Players:GetPlayers()) do
			if p ~= player and p.Character then
				local myHRP = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
				local tHRP = p.Character:FindFirstChild("HumanoidRootPart")
				if myHRP and tHRP then
					myHRP.CFrame = tHRP.CFrame * CFrame.new(0, 0, 3)
					task.wait(0.5)
				end
			end
		end
	end)
end)

-- ИГРЫ: MM2
sectionLabel(tabGames, "🔪 Murder Mystery 2 (Kento + Gjfssbn23)")
makeToggle(tabGames, "💰  Автофарм монет", false, function(s) mm2Kento.AutoFarm = s notify(s and "Auto Farm вкл 💰" or "Auto Farm выкл", s) end)
makeToggle(tabGames, "🚪  Noclip (MM2)", false, function(s) mm2Kento.Noclip = s notify(s and "Noclip вкл" or "Noclip выкл", s) end)
makeToggle(tabGames, "🏃  TP Walk", false, function(s) mm2Kento.TPWalk = s notify(s and "TP Walk вкл" or "TP Walk выкл", s) end)
makeSlider(tabGames, "Скорость TP Walk", 1, 20, 4, function(v) mm2Kento.TPWalkSpeed = v / 10 end)
makeToggle(tabGames, "🦘  Бесконечный прыжок (MM2)", false, function(s) mm2Kento.InfJump = s notify(s and "Inf Jump вкл" or "Inf Jump выкл", s) end)
makeToggle(tabGames, "👁  ESP Ролей (боксы)", false, function(s) mm2Kento.ESP = s if not s then mm2ClearESP() end notify(s and "ESP вкл 👁" or "ESP выкл", s) end)
makeToggle(tabGames, "🎯  Aim Bot (только убийца)", false, function(s) mm2Kento.AimBot = s notify(s and "Aim Bot вкл 🎯" or "Aim Bot выкл", s) end)
makeToggle(tabGames, "⚔  Kill Aura (нужен нож)", false, function(s) mm2Kento.KillAura = s notify(s and "Kill Aura вкл ⚔" or "Kill Aura выкл", s) end)
makeButton(tabGames, "🔱  Подобрать пистолет (TP)", function()
	local gd = workspace:FindFirstChild("GunDrop", true) or workspace:FindFirstChild("Gun", true)
	local char = player.Character
	local hrp = char and char:FindFirstChild("HumanoidRootPart")
	if gd and hrp then
		local old = hrp.CFrame
		local target = gd:IsA("Model") and (gd:FindFirstChild("Handle") or gd:FindFirstChildWhichIsA("BasePart")) or gd
		if target and target:IsA("BasePart") then
			hrp.CFrame = target.CFrame * CFrame.new(0, 1, 0)
			task.wait(0.2)
			hrp.CFrame = old
			notify("Пистолет подобран 🔱", true)
		end
	end
end)
sectionLabel(tabGames, "🔫 Sheriff Auto-Shoot (Шериф)")
makeToggle(tabGames, "🔫  Авто-стрельба за шерифа", false, function(s)
	mm2SheriffAuto = s
	notify(s and "Sheriff Auto вкл 🔫" or "Sheriff Auto выкл", s)
end)
makeSlider(tabGames, "Дистанция авто-стрельбы", 50, 500, 300, function(v) mm2SheriffRange = v end)
makeSlider(tabGames, "Задержка выстрела (мс)", 100, 2000, 500, function(v) mm2SheriffDelay = v / 1000 end)
makeToggle(tabGames, "🔮  Предикция (опережение)", true, function(s)
	mm2SheriffPredict = s
	notify(s and "Предикция вкл" or "Предикция выкл", s)
end)
makeToggle(tabGames, "👁  Проверка стен", true, function(s)
	mm2SheriffWallCheck = s
	notify(s and "Wall-check вкл" or "Wall-check выкл", s)
end)

-- ИГРЫ: 99 Nights
sectionLabel(tabGames, "🌲 99 Nights in the Forest")
makeToggle(tabGames, "💰  Автофарм (ресурсы/алмазы)", false, function(s) n99_AutoFarm = s notify(s and "Автофарм вкл" or "Автофарм выкл", s) end)
makeToggle(tabGames, "🪓  Авто-рубка деревьев", false, function(s) n99_AutoChop = s notify(s and "Авто-рубка вкл" or "Авто-рубка выкл", s) end)
makeToggle(tabGames, "🌳  Лесорубка (всё в радиусе)", false, function(s) n99_TreeAura = s notify(s and "Лесорубка вкл" or "Лесорубка выкл", s) end)
makeSlider(tabGames, "Радиус лесорубки", 10, 50, 25, function(v) n99_TreeAuraRange = v end)
makeToggle(tabGames, "🍖  Авто-еда (голод)", false, function(s) n99_AutoEat = s notify(s and "Авто-еда вкл" or "Авто-еда выкл", s) end)
makeToggle(tabGames, "🔥  Авто-костёр (топливо)", false, function(s) n99_AutoCampfire = s notify(s and "Авто-костёр вкл" or "Авто-костёр выкл", s) end)
makeToggle(tabGames, "🛡  Бессмертие", false, function(s) n99_GodMode = s notify(s and "Бог вкл" or "Бог выкл", s) end)
makeToggle(tabGames, "❄  Заморозка врагов", false, function(s) n99_FreezeEnemies = s notify(s and "Заморозка вкл" or "Заморозка выкл", s) end)
makeToggle(tabGames, "⚔  Аура убийства (враги+игроки)", false, function(s) n99_KillAura = s notify(s and "Аура убийства вкл" or "Аура убийства выкл", s) end)
makeSlider(tabGames, "Радиус ауры убийства", 5, 50, 22, function(v) n99_KillAuraRange = v end)
makeToggle(tabGames, "🦘  Бесконечный прыжок", false, function(s) n99_InfiniteJump = s notify(s and "Inf Jump вкл" or "Inf Jump выкл", s) end)
makeToggle(tabGames, "🚪  Noclip", false, function(s) n99_Noclip = s notify(s and "Noclip вкл" or "Noclip выкл", s) end)
makeToggle(tabGames, "👁  ESP сундуков", false, function(s) n99_ESP_Chests = s notify(s and "Сундуки вкл" or "Сундуки выкл", s) end)
makeToggle(tabGames, "🐺  ESP врагов", false, function(s) n99_ESP_Enemies = s notify(s and "Враги вкл" or "Враги выкл", s) end)
makeToggle(tabGames, "🧒  ESP детей", false, function(s) n99_ESP_Children = s notify(s and "Дети вкл" or "Дети выкл", s) end)
makeToggle(tabGames, "👥  ESP игроков", false, function(s) n99_ESP_Players = s notify(s and "Игроки вкл" or "Игроки выкл", s) end)
makeToggle(tabGames, "📦  Притянуть предметы", false, function(s) n99_BringItems = s notify(s and "Притяжение вкл" or "Притяжение выкл", s) end)
makeToggle(tabGames, "🏆  Авто-победа (пропуск дня)", false, function(s) n99_AutoWin = s notify(s and "Авто-победа вкл" or "Авто-победа выкл", s) end)
makeButton(tabGames, "📦  Ringta Hub (внешний)", function()
	notify("Загрузка Ringta Hub...", true)
	pcall(function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/wehibuyfgyuwe/99nights.github.io/refs/heads/main/ringta.lua"))()
	end)
end)

-- ИГРЫ: BABFT
sectionLabel(tabGames, "⛵ Build A Boat For Treasure")
makeToggle(tabGames, "🏆  Auto Win (свой)", false, function(s)
	babftAutoWinEnabled = s
	if s then
		if not babftAutoWinThread then
			babftAutoWinThread = task.spawn(function()
				while babftAutoWinEnabled do
					local char = player.Character
					local hrp = char and char:FindFirstChild("HumanoidRootPart")
					local hum = char and char:FindFirstChildOfClass("Humanoid")
					if hrp and hum and hum.Health > 0 then
						local chest
						for _, obj in ipairs(workspace:GetDescendants()) do
							local n = obj.Name:lower()
							if n:find("treasure") or n:find("chest") or n:find("reward") or n:find("prize") or n:find("goal") or n:find("finish") then chest = obj break end
						end
						local chestPart = chest and (chest:IsA("BasePart") and chest or chest:FindFirstChildWhichIsA("BasePart") or chest.PrimaryPart)
						if chestPart then
							local oldMax = hum.MaxHealth
							hum.MaxHealth = math.huge hum.Health = math.huge
							for _, p in ipairs(char:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide = false end end
							local startPos = hrp.Position
							for i = 1, 30 do
								if not babftAutoWinEnabled then break end
								hrp.CFrame = CFrame.new(startPos:Lerp(chestPart.Position, i / 30))
								task.wait(0.02)
							end
							hrp.CFrame = CFrame.new(chestPart.Position + Vector3.new(0, 2, 0))
							hrp.AssemblyLinearVelocity = Vector3.zero
							task.delay(2, function()
								if hum and hum.Parent then hum.MaxHealth = oldMax if hum.Health > oldMax then hum.Health = oldMax end end
								if char and char.Parent then for _, p in ipairs(char:GetDescendants()) do if p:IsA("BasePart") and p.Name ~= "HumanoidRootPart" then p.CanCollide = true end end end
							end)
							task.wait(0.5)
							for i = 1, 10 do
								if not babftAutoWinEnabled then break end
								pcall(function() firetouchinterest(hrp, chestPart, 0) task.wait(0.05) firetouchinterest(hrp, chestPart, 1) end)
								task.wait(0.1)
							end
							task.wait(babftChestWaitTime)
						else
							task.wait(0.5)
						end
					end
					task.wait(0.3)
				end
				babftAutoWinThread = nil
			end)
		end
		notify("BABFT Auto Win вкл 🏆", true)
	else
		if babftAutoWinThread then pcall(function() task.cancel(babftAutoWinThread) end) babftAutoWinThread = nil end
		local char = player.Character
		local hum = char and char:FindFirstChildOfClass("Humanoid")
		if hum then hum.MaxHealth = 100 if hum.Health > 100 then hum.Health = 100 end end
		if char then for _, p in ipairs(char:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide = true end end end
		notify("BABFT Auto Win выкл", false)
	end
end)
makeSlider(tabGames, "Время сбора награды (сек)", 1, 10, 3, function(v) babftChestWaitTime = v end)
makeButton(tabGames, "🚀  TheRealAsu Auto Farm (загрузить)", function()
	if babftExternalLoaded then notify("Уже загружен", false) return end
	babftExternalLoaded = true
	notify("Загрузка BABFT Auto Farm...", true)
	task.spawn(function()
		local ok, err = pcall(function()
			loadstring(game:HttpGet('https://raw.githubusercontent.com/TheRealAsu/BABFT/refs/heads/main/Loader.lua'))()
		end)
		if ok then notify("BABFT Auto Farm загружен 🚀", true)
		else babftExternalLoaded = false notify("Ошибка загрузки", false) warn(err) end
	end)
end)

-- ИГРЫ: Rivals
sectionLabel(tabGames, "🏆 Rivals — Auto Win")
makeToggle(tabGames, "🏆  AUTO WIN", false, function(s) autoWinEnabled = s if not s then autoWinTarget = nil end notify(s and "AUTO WIN вкл 🏆" or "AUTO WIN выкл", s) end)
makeSlider(tabGames, "Дистанция захвата", 50, 1500, 500, function(v) autoWinRange = v end)
makeSlider(tabGames, "Скорость стрельбы", 1, 20, 10, function(v) autoWinFireRate = v / 100 end)
makeSlider(tabGames, "Хедшот-биас (%)", 0, 100, 85, function(v) autoWinHeadshotBias = v / 100 end)

-- ФАН
sectionLabel(tabFun, "Шутки")
_G.MakaziPP_Length = _G.MakaziPP_Length or 2
_G.MakaziPP_Thick = _G.MakaziPP_Thick or 2
_G.MakaziPP_TipSize = _G.MakaziPP_TipSize or 2
_G.MakaziPP_Color = _G.MakaziPP_Color or "pink"
local ppParts = {}
local ppConn = nil
local ppWeldShaft = nil
local ppAnimOffset = 0
local PP_COLORS = {
	pink   = Color3.fromRGB(255, 105, 180),
	purple = Color3.fromRGB(190, 90, 255),
	red    = Color3.fromRGB(255, 50, 50),
	blue   = Color3.fromRGB(80, 180, 255),
	green  = Color3.fromRGB(80, 255, 130),
}
local function destroyPP()
	if ppConn then ppConn:Disconnect() ppConn = nil end
	for _, p in ipairs(ppParts) do pcall(function() p:Destroy() end) end
	ppParts = {}
	ppWeldShaft = nil
end
local function createPP()
	local char = player.Character
	if not char then return end
	local torso = char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso")
	if not torso then return end
	local len   = _G.MakaziPP_Length or 2
	local thick = _G.MakaziPP_Thick or 2
	local tipS  = _G.MakaziPP_TipSize or 2
	local color
	if _G.MakaziPP_Color == "rainbow" then color = Color3.fromHSV(tick() % 1, 1, 1)
	else color = PP_COLORS[_G.MakaziPP_Color] or PP_COLORS.pink end
	local shaft = Instance.new("Part")
	shaft.Name = "MakaziPPShaft"
	shaft.Shape = Enum.PartType.Cylinder
	shaft.Size = Vector3.new(1.4 * len, 0.7 * thick / 2, 0.7 * thick / 2)
	shaft.Material = Enum.Material.Neon
	shaft.Color = color
	shaft.CanCollide = false
	shaft.CanQuery = false
	shaft.CastShadow = false
	shaft.Massless = true
	shaft.Parent = workspace
	table.insert(ppParts, shaft)
	local tip = Instance.new("Part")
	tip.Name = "MakaziPPTip"
	tip.Shape = Enum.PartType.Ball
	tip.Size = Vector3.new(0.85 * tipS, 0.85 * tipS, 0.85 * tipS)
	tip.Material = Enum.Material.Neon
	tip.Color = color:Lerp(Color3.fromRGB(255, 255, 255), 0.15)
	tip.CanCollide = false
	tip.CanQuery = false
	tip.CastShadow = false
	tip.Massless = true
	tip.Parent = workspace
	table.insert(ppParts, tip)
	for i = 1, 2 do
		local ball = Instance.new("Part")
		ball.Shape = Enum.PartType.Ball
		ball.Size = Vector3.new(0.55 * tipS, 0.55 * tipS, 0.55 * tipS)
		ball.Material = Enum.Material.Neon
		ball.Color = color:Lerp(Color3.fromRGB(255, 255, 255), -0.1)
		ball.CanCollide = false
		ball.CanQuery = false
		ball.CastShadow = false
		ball.Massless = true
		ball.Parent = workspace
		table.insert(ppParts, ball)
	end
	local light = Instance.new("PointLight")
	light.Color = color
	light.Brightness = 3
	light.Range = 8
	light.Parent = tip
	table.insert(ppParts, light)
	ppWeldShaft = Instance.new("Weld")
	ppWeldShaft.Part0 = torso
	ppWeldShaft.Part1 = shaft
	ppWeldShaft.C0 = CFrame.new(0, -1.0, 0.9) * CFrame.Angles(0, math.rad(90), math.rad(90))
	ppWeldShaft.Parent = shaft
	local wTip = Instance.new("Weld")
	wTip.Part0 = shaft
	wTip.Part1 = tip
	wTip.C0 = CFrame.new(0.7 * len, 0, 0)
	wTip.Parent = tip
	local wB1 = Instance.new("Weld")
	wB1.Part0 = torso
	wB1.Part1 = ppParts[3]
	wB1.C0 = CFrame.new(-0.35 * tipS, -1.15, 0.35)
	wB1.Parent = ppParts[3]
	local wB2 = Instance.new("Weld")
	wB2.Part0 = torso
	wB2.Part1 = ppParts[4]
	wB2.C0 = CFrame.new(0.35 * tipS, -1.15, 0.35)
	wB2.Parent = ppParts[4]
	ppAnimOffset = 0
	local rainbowTick = 0
	ppConn = RunService.RenderStepped:Connect(function(dt)
		if not _G.MakaziPP or not ppWeldShaft then return end
		ppAnimOffset = ppAnimOffset + dt * 3
		local bob = math.sin(ppAnimOffset) * 0.06
		local tilt = math.sin(ppAnimOffset * 0.7) * 0.08
		ppWeldShaft.C0 = CFrame.new(0, -1.0 + bob, 0.9) * CFrame.Angles(tilt, math.rad(90), math.rad(90))
		if _G.MakaziPP_Color == "rainbow" then
			rainbowTick = rainbowTick + dt * 0.3
			local c = Color3.fromHSV(rainbowTick % 1, 1, 1)
			if ppParts[1] then ppParts[1].Color = c end
			if ppParts[2] then ppParts[2].Color = c:Lerp(Color3.fromRGB(255,255,255), 0.15) end
			if ppParts[3] then ppParts[3].Color = c end
			if ppParts[4] then ppParts[4].Color = c end
			if ppParts[5] and ppParts[5]:IsA("PointLight") then ppParts[5].Color = c end
		end
	end)
end
task.spawn(function()
	while true do
		if _G.MakaziPP then
			local char = player.Character
			local torso = char and (char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso"))
			if torso and #ppParts == 0 then
				createPP()
			elseif (not torso or not char) and #ppParts > 0 then
				destroyPP()
			end
		elseif #ppParts > 0 then
			destroyPP()
		end
		task.wait(0.4)
	end
end)
makeToggle(tabFun, "🍆  Визуальный PP (неон)", false, function(s) _G.MakaziPP = s notify(s and "PP вкл 😂" or "PP выкл", s) end)
makeSlider(tabFun, "Длина PP", 1, 10, 2, function(v) _G.MakaziPP_Length = v if _G.MakaziPP then destroyPP() task.wait(0.1) createPP() end end)
makeSlider(tabFun, "Толщина PP", 1, 10, 2, function(v) _G.MakaziPP_Thick = v if _G.MakaziPP then destroyPP() task.wait(0.1) createPP() end end)
makeSlider(tabFun, "Размер головки", 1, 10, 2, function(v) _G.MakaziPP_TipSize = v if _G.MakaziPP then destroyPP() task.wait(0.1) createPP() end end)
makeButton(tabFun, "🎨  Цвет PP", function()
	local colors = {"pink", "purple", "red", "blue", "green", "rainbow"}
	local currentIdx = 1
	for i, c in ipairs(colors) do if c == _G.MakaziPP_Color then currentIdx = i break end end
	local nextIdx = (currentIdx % #colors) + 1
	_G.MakaziPP_Color = colors[nextIdx]
	notify("Цвет: " .. colors[nextIdx], true)
	if _G.MakaziPP then destroyPP() task.wait(0.1) createPP() end
end)
makeToggle(tabFun, "🪵  Tung Tung Sahur", false, function(s) _G.MakaziSahur = s notify(s and "Sahur 🪵" or "Sahur ушёл", s) end)
makeToggle(tabFun, "👻  Невидимость", false, function(s) _G.MakaziInvis = s notify(s and "Invis вкл" or "Invis выкл", s) end)
makeToggle(tabFun, "🌈  Радуга", false, function(s) _G.MakaziRainbow = s notify(s and "Rainbow вкл" or "Rainbow выкл", s) end)
makeToggle(tabFun, "🐰  Bunny Hop", false, function(s) _G.MakaziBunny = s notify(s and "Bunny вкл" or "Bunny выкл", s) end)
makeToggle(tabFun, "🔥  Огненный след", false, function(s) _G.MakaziFire = s notify(s and "Fire вкл" or "Fire выкл", s) end)
sectionLabel(tabFun, "Вращение")
makeToggle(tabFun, "🌀  Спин (камера на месте)", false, function(s)
	if s then
		local char = player.Character
		local hrp = char and char:FindFirstChild("HumanoidRootPart")
		local hum = char and char:FindFirstChildOfClass("Humanoid")
		if hrp and hum then
			spinEnabled = true
			spinSavedAutoRotate = hum.AutoRotate
			hum.AutoRotate = false
			local attach = Instance.new("Attachment")
			attach.Parent = hrp
			spinAV = Instance.new("AngularVelocity")
			spinAV.Attachment0 = attach
			spinAV.MaxTorque = 1e6
			spinAV.AngularVelocity = Vector3.new(0, math.rad(spinSpeed), 0)
			spinAV.RelativeTo = Enum.ActuatorRelativeTo.World
			spinAV.Parent = hrp
			notify("Спин вкл 🌀", true)
		end
	else
		spinEnabled = false
		if spinAV then spinAV:Destroy() spinAV = nil end
		local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
		if hum and spinSavedAutoRotate ~= nil then hum.AutoRotate = spinSavedAutoRotate end
		notify("Спин выкл", false)
	end
end)
makeSlider(tabFun, "Скорость спина (°/сек)", 180, 2160, 720, function(v) spinSpeed = v if spinAV then spinAV.AngularVelocity = Vector3.new(0, math.rad(v), 0) end end)
sectionLabel(tabFun, "Флинг")
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
	local dir = Vector3.new((math.random() - 0.5) * 2, 1, (math.random() - 0.5) * 2).Unit
	pcall(function() myHRP.AssemblyLinearVelocity = dir * flingPower * 10 myHRP.AssemblyAngularVelocity = Vector3.new(9e9, 9e9, 9e9) end)
	task.wait(0.08)
	pcall(function() weld:Destroy() end)
	task.wait(0.02)
	pcall(function() myHRP.CFrame = savedCF myHRP.AssemblyLinearVelocity = savedVel end)
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
				if d < nd then nd = d nearest = p end
			end
		end
	end
	return nearest
end
makeButton(tabFun, "💥  Флинг всех", function()
	task.spawn(function()
		local count = 0
		for _, p in ipairs(Players:GetPlayers()) do
			if p ~= player and p.Character then
				local hum = p.Character:FindFirstChildOfClass("Humanoid")
				if hum and hum.Health > 0 then if flingPlayer(p) then count = count + 1 end task.wait(0.12) end
			end
		end
		notify("Откинул: " .. count, count > 0)
	end)
end)
makeButton(tabFun, "🎯  Флинг ближайшего", function() local t = getNearestPlayer(flingRange) if t then task.spawn(function() flingPlayer(t) end) end end)
makeToggle(tabFun, "🤝  Флинг при касании", false, function(s) flingOnTouchOn = s notify(s and "Touch Fling вкл" or "Touch Fling выкл", s) end)
makeSlider(tabFun, "Дистанция флинга", 5, 40, 12, function(v) flingRange = v end)
makeSlider(tabFun, "Сила флинга", 100, 2000, 500, function(v) flingPower = v end)
task.spawn(function()
	while true do
		if flingOnTouchOn then
			local myHRP = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
			if myHRP then
				for _, p in ipairs(Players:GetPlayers()) do
					if p ~= player and p.Character then
						local hrp = p.Character:FindFirstChild("HumanoidRootPart")
						local hum = p.Character:FindFirstChildOfClass("Humanoid")
						if hrp and hum and hum.Health > 0 then
							local d = (hrp.Position - myHRP.Position).Magnitude
							if d < flingRange and d > 0.5 then flingPlayer(p) end
						end
					end
				end
			end
			task.wait(0.4)
		else
			task.wait(0.5)
		end
	end
end)

-- ПРОЧЕЕ
sectionLabel(tabMisc, "Настройки")
makeToggle(tabMisc, "🔊  Звуки меню", true, function(s) soundEnabled = s notify(s and "Звуки вкл" or "Звуки выкл", s) end)
makeSlider(tabMisc, "Лимит ФПС", 30, 240, 60, function(v)
	currentFpsCap = v
	if setfpscap then pcall(setfpscap, v) end
end)
sectionLabel(tabMisc, "Быстрые действия")
makeToggle(tabMisc, "🖱  Click TP (тап по земле)", false, function(s) clickTPEnabled = s notify(s and "Click TP вкл" or "Click TP выкл", s) end)
makeToggle(tabMisc, "♻  Авто-возрождение", false, function(s) autoRespawnEnabled = s notify(s and "Auto-Respawn вкл" or "Auto-Respawn выкл", s) end)
makeButton(tabMisc, "🔄  Возродиться", function() local c = player.Character if c then c:BreakJoints() end end)
makeButton(tabMisc, "⬆  Телепорт вверх", function() local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart") if hrp then hrp.CFrame += Vector3.new(0, 50, 0) end end)
makeButton(tabMisc, "🔁  Rejoin", function() notify("Перезаход...", true) task.wait(0.5) pcall(function() TeleportService:Teleport(game.PlaceId, player) end) end)
makeButton(tabMisc, "❌  Выключить всё", function()
	if spinEnabled then spinEnabled = false if spinAV then spinAV:Destroy() spinAV = nil end local h = player.Character and player.Character:FindFirstChildOfClass("Humanoid") if h and spinSavedAutoRotate ~= nil then h.AutoRotate = spinSavedAutoRotate end end
	if auraEnabled then auraEnabled = false if auraConn then auraConn:Disconnect() auraConn = nil end for _, p in ipairs(auraParts) do pcall(function() p:Destroy() end) end auraParts = {} end
	if flyGuiLoaded then unloadFlyGUI_V3() end
	if babftAutoWinEnabled then babftAutoWinEnabled = false if babftAutoWinThread then pcall(function() task.cancel(babftAutoWinThread) end) babftAutoWinThread = nil end end
	espEnabled = false clearESP()
	espNamesEnabled = false clearNameTags()
	aimEnabled = false aimCurrentTarget = nil
	noclipEnabled = false
	godEnabled = false
	infJumpEnabled = false
	doubleJumpOn = false
	fullbrightEnabled = false removeFullbright()
	antiAfkEnabled = false
	lowGravityEnabled = false
	workspace.Gravity = savedGravity
	autoSprintEnabled = false
	antiFlingEnabled = false
	antiVoidOn = false
	antiStunEnabled = false
	autoRespawnEnabled = false
	clickTPEnabled = false
	autoClickerEnabled = false
	killAllOn = false
	hitboxEnabled = false clearHitbox()
	infiniteAmmoEnabled = false
	fpsBoostEnabled = false
	cinematicEnabled = false
	flingOnTouchOn = false
	autoWinEnabled = false autoWinTarget = nil
	mm2Kento.AutoFarm = false mm2Kento.Noclip = false mm2Kento.TPWalk = false mm2Kento.InfJump = false mm2Kento.ESP = false mm2Kento.AimBot = false mm2Kento.KillAura = false
	mm2SheriffAuto = false
	mm2ClearESP()
	n99_AutoFarm = false n99_AutoChop = false n99_AutoEat = false n99_AutoCampfire = false
	n99_GodMode = false n99_FreezeEnemies = false n99_KillAura = false n99_TreeAura = false
	n99_InfiniteJump = false n99_Noclip = false n99_ESP_Chests = false n99_ESP_Enemies = false
	n99_ESP_Children = false n99_ESP_Players = false n99_BringItems = false n99_AutoWin = false
	_G.MakaziPP = false _G.MakaziSahur = false _G.MakaziInvis = false _G.MakaziRainbow = false _G.MakaziBunny = false _G.MakaziFire = false
	local char = player.Character
	if char then
		for _, part in ipairs(char:GetDescendants()) do if part:IsA("BasePart") then part.CanCollide = true part.LocalTransparencyModifier = 0 end end
		local hum = char:FindFirstChildOfClass("Humanoid")
		if hum then hum.MaxHealth = 100 hum.Health = 100 hum.WalkSpeed = 16 end
	end
	local camera = workspace.CurrentCamera
	if camera then camera.FieldOfView = 70 end
	notify("Всё выключено", false)
end)

-- ФАН-ЛОГИКА
task.spawn(function()
	while true do
		if _G.MakaziInvis then
			local char = player.Character
			if char then
				for _, part in ipairs(char:GetChildren()) do
					if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then part.LocalTransparencyModifier = 1 end
				end
			end
			task.wait(0.3)
		else task.wait(0.5) end
	end
end)
task.spawn(function()
	while true do
		if _G.MakaziRainbow then
			local char = player.Character
			if char then
				local c = Color3.fromHSV(tick() % 1, 1, 1)
				for _, p in ipairs(char:GetChildren()) do if p:IsA("BasePart") then pcall(function() p.Color = c end) end end
			end
			task.wait(0.08)
		else task.wait(0.5) end
	end
end)
task.spawn(function()
	while true do
		if _G.MakaziBunny then
			local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
			if hum and hum.MoveDirection.Magnitude > 0.1 and hum.FloorMaterial ~= Enum.Material.Air then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
			task.wait(0.05)
		else task.wait(0.5) end
	end
end)
task.spawn(function()
	while true do
		if _G.MakaziFire then
			local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
			if hrp then
				local fire = Instance.new("Fire")
				fire.Size = 6
				fire.Parent = hrp
				task.delay(1.5, function() if fire then fire:Destroy() end end)
			end
			task.wait(0.15)
		else task.wait(0.5) end
	end
end)
local sahurModel
local SAHUR_ID = 83138270236341
task.spawn(function()
	while true do
		if _G.MakaziSahur and not sahurModel then
			local char = player.Character
			local hrp = char and char:FindFirstChild("HumanoidRootPart")
			if hrp then
				for _, part in ipairs(char:GetChildren()) do
					if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then pcall(function() part.LocalTransparencyModifier = 1 end) end
					if part:IsA("Decal") then pcall(function() part.Transparency = 1 end) end
				end
				local ok, model = pcall(function() return InsertService:LoadAsset(SAHUR_ID) end)
				if not ok or not model then
					local bb = Instance.new("BillboardGui")
					bb.Size = UDim2.new(0, 300, 0, 300)
					bb.StudsOffsetWorldSpace = Vector3.new(0, 4, 0)
					bb.AlwaysOnTop = true
					bb.LightInfluence = 0
					bb.Adornee = hrp
					bb.Parent = hrp
					local img = Instance.new("ImageLabel")
					img.Size = UDim2.new(1, 0, 1, 0)
					img.BackgroundTransparency = 1
					img.Image = "rbxthumb://type=Asset&id=" .. SAHUR_ID .. "&w=420&h=420"
					img.ScaleType = Enum.ScaleType.Fit
					img.Parent = bb
					sahurModel = bb
					notify("Sahur 2D 🪵", true)
				else
					model.Name = "MakaziSahurModel"
					model.Parent = workspace
					local primary
					for _, d in ipairs(model:GetDescendants()) do
						if d:IsA("BasePart") then
							d.CanCollide = false
							d.Anchored = false
							d.Massless = true
							if not primary or d.Size.Magnitude > primary.Size.Magnitude then primary = d end
						end
					end
					if primary then
						local s = 8 / primary.Size.Y
						for _, d in ipairs(model:GetDescendants()) do if d:IsA("BasePart") then d.Size = d.Size * s end end
						local weld = Instance.new("WeldConstraint")
						weld.Part0 = hrp
						weld.Part1 = primary
						weld.Parent = primary
						primary.CFrame = hrp.CFrame * CFrame.new(0, 3, 0)
						sahurModel = model
						notify("Sahur 3D 🪵", true)
					else model:Destroy() end
				end
			end
			task.wait(0.4)
		elseif not _G.MakaziSahur and sahurModel then
			pcall(function() sahurModel:Destroy() end)
			sahurModel = nil
			local char = player.Character
			if char then
				for _, part in ipairs(char:GetChildren()) do
					if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then pcall(function() part.LocalTransparencyModifier = 0 end) end
					if part:IsA("Decal") then pcall(function() part.Transparency = 0 end) end
				end
			end
			task.wait(0.4)
		else task.wait(0.5) end
	end
end)

-- ОТКРЫТИЕ / ЗАКРЫТИЕ
local opened = false
local function openMenu()
	if opened then return end
	opened = true
	openSound()
	menu.Visible = true
	uiScale.Scale = 0
	TweenService:Create(uiScale, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { Scale = 1 }):Play()
end
local function closeMenu()
	if not opened then return end
	opened = false
	closeSound()
	local t = TweenService:Create(uiScale, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.In), { Scale = 0 })
	t:Play()
	t.Completed:Connect(function() menu.Visible = false end)
end
local function makeDraggable(frame, dragPart, isCircle)
	dragPart = dragPart or frame
	local dragging = false
	local dragStart, startPos
	local moved = false
	dragPart.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			moved = false
			dragStart = input.Position
			startPos = frame.Position
		end
	end)
	UserInputService.InputChanged:Connect(function(input)
		if not dragging then return end
		if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement then
			local d = input.Position - dragStart
			if math.abs(d.X) > 6 or math.abs(d.Y) > 6 then moved = true end
			if moved then
				local newPos = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
				local cam = workspace.CurrentCamera
				local sw = cam and cam.ViewportSize.X or 1920
				local sh = cam and cam.ViewportSize.Y or 1080
				local sz = frame.AbsoluteSize
				frame.Position = UDim2.new(newPos.X.Scale, math.clamp(newPos.X.Offset, 0, sw - sz.X), newPos.Y.Scale, math.clamp(newPos.Y.Offset, 0, sh - sz.Y))
			end
		end
	end)
	UserInputService.InputEnded:Connect(function(input)
		if not dragging then return end
		dragging = false
		if isCircle and not moved then
			if opened then closeMenu() else openMenu() end
		end
	end)
end
makeDraggable(circleHolder, circle, true)
makeDraggable(menu, header, false)
local minimized = false
minBtn.MouseButton1Click:Connect(function()
	clickSound()
	minimized = not minimized
	menu.Size = minimized and UDim2.new(0, 280, 0, 44) or UDim2.new(0, 280, 0, 340)
	searchBox.Visible = not minimized
	tabBar.Visible = not minimized
	for _, p in pairs(pages) do p.Visible = false end
	if not minimized then selectTab("Главное") end
end)
closeBtn.MouseButton1Click:Connect(closeMenu)
searchInput:GetPropertyChangedSignal("Text"):Connect(function()
	local query = searchInput.Text:lower()
	if query == "" then
		for _, item in ipairs(allItems) do if item.obj and item.obj.Parent then item.obj.Visible = true end end
		selectTab("Главное")
	else
		for _, c in pairs(pages) do c.Visible = true end
		for _, item in ipairs(allItems) do
			if item.obj and item.obj.Parent then item.obj.Visible = item.text:lower():find(query) ~= nil end
		end
	end
end)
selectTab("Главное")
task.delay(1, function()
	notify("Makazi Mod v10.7 загружен ✅", true)
	print("[MAKAZI] Всё готово! v10.7 FULL")
end)

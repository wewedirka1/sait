-- LocalScript: LojusHub Premium UI
-- Автор: ты 😎

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- Статы
local speed = 16
local gravity = math.floor(workspace.Gravity) -- Initialize as integer

-- Обновление персонажа
local function updateHumanoid()
    character = player.Character or player.CharacterAdded:Wait()
    humanoid = character:WaitForChild("Humanoid")
end

player.CharacterAdded:Connect(updateHumanoid)

-- Движение
RunService.RenderStepped:Connect(function()
    if not humanoid or humanoid.Health <= 0 then return end
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not rootPart then return end

    local moveDir = humanoid.MoveDirection
    local currentSpeed = speed

    if moveDir.Magnitude > 0 then
        rootPart.Velocity = Vector3.new(moveDir.X * currentSpeed, rootPart.Velocity.Y, moveDir.Z * currentSpeed)
    end
end)

---------------------------------------------------------------------
-- 🌟 GUI: Sania-style LojusHub
---------------------------------------------------------------------
local screen = Instance.new("ScreenGui")
screen.Name = "LojusHub_UI"
screen.ResetOnSpawn = false
screen.Parent = player:WaitForChild("PlayerGui")

local uiScale = Instance.new("UIScale")
uiScale.Scale = 0.8
uiScale.Parent = screen

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 300)
frame.Position = UDim2.new(0, 20, 0, 100)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
frame.BorderSizePixel = 0
frame.Parent = screen

-- Обводка (светящаяся)
local glow = Instance.new("UIStroke")
glow.Thickness = 2
glow.Color = Color3.fromRGB(0, 170, 255)
glow.Transparency = 0.3
glow.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
glow.Parent = frame

-- Тень
local shadow = Instance.new("ImageLabel")
shadow.Size = UDim2.new(1, 20, 1, 20)
shadow.Position = UDim2.new(0, -10, 0, -10)
shadow.BackgroundTransparency = 1
shadow.Image = "rbxassetid://1316045217"
shadow.ImageTransparency = 0.6
shadow.ZIndex = 0
shadow.Parent = frame

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 14)
corner.Parent = frame

-- Заголовок
local title = Instance.new("TextLabel")
title.Text = "LojusHub"
title.Size = UDim2.new(1, 0, 0, 40)
title.Font = Enum.Font.GothamBold
title.TextSize = 24
title.TextColor3 = Color3.fromRGB(255,255,255)
title.BackgroundTransparency = 1
title.Parent = frame

-- Speed Label
local speedLabel = Instance.new("TextLabel")
speedLabel.Text = "Speed: "..speed
speedLabel.Position = UDim2.new(0, 20, 0, 50)
speedLabel.Size = UDim2.new(0, 260, 0, 30)
speedLabel.Font = Enum.Font.Gotham
speedLabel.TextSize = 20
speedLabel.TextColor3 = Color3.fromRGB(200,200,200)
speedLabel.BackgroundTransparency = 1
speedLabel.Parent = frame

-- Speed Buttons
local function makeButton(txt, pos, callback)
    local btn = Instance.new("TextButton")
    btn.Text = txt
    btn.Size = UDim2.new(0, 120, 0, 32)
    btn.Position = pos
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 18
    btn.BackgroundColor3 = Color3.fromRGB(35,35,40)
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.AutoButtonColor = false
    btn.Parent = frame

    local bcorner = Instance.new("UICorner")
    bcorner.CornerRadius = UDim.new(0,10)
    bcorner.Parent = btn

    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(0, 170, 255)
    stroke.Thickness = 1
    stroke.Transparency = 0.5
    stroke.Parent = btn

    btn.MouseButton1Click:Connect(function()
        callback()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 170, 255)}):Play()
        wait(0.2)
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(35,35,40)}):Play()
    end)

    return btn
end

makeButton("-", UDim2.new(0, 20, 0, 90), function()
    speed = math.max(8, speed - 2)
    speedLabel.Text = "Speed: "..speed
end)

makeButton("+", UDim2.new(0, 160, 0, 90), function()
    speed = math.min(100, speed + 2)
    speedLabel.Text = "Speed: "..speed
end)

-- Gravity Label
local gravityLabel = Instance.new("TextLabel")
gravityLabel.Text = "Gravity: "..gravity
gravityLabel.Position = UDim2.new(0, 20, 0, 135)
gravityLabel.Size = UDim2.new(0, 260, 0, 30)
gravityLabel.Font = Enum.Font.Gotham
gravityLabel.TextSize = 20
gravityLabel.TextColor3 = Color3.fromRGB(200,200,200)
gravityLabel.BackgroundTransparency = 1
gravityLabel.Parent = frame

-- Gravity Input
local gravityInput = Instance.new("TextBox")
gravityInput.Text = tostring(gravity)
gravityInput.Size = UDim2.new(0, 260, 0, 32)
gravityInput.Position = UDim2.new(0, 20, 0, 175)
gravityInput.Font = Enum.Font.Gotham
gravityInput.TextSize = 18
gravityInput.BackgroundColor3 = Color3.fromRGB(35,35,40)
gravityInput.TextColor3 = Color3.fromRGB(255,255,255)
gravityInput.PlaceholderText = "Enter Gravity (0-500)"
gravityInput.Parent = frame

local inputCorner = Instance.new("UICorner")
inputCorner.CornerRadius = UDim.new(0,10)
inputCorner.Parent = gravityInput

-- Gravity Buttons
makeButton("-", UDim2.new(0, 20, 0, 220), function()
    gravity = math.max(0, gravity - 10)
    workspace.Gravity = gravity
    gravityLabel.Text = "Gravity: "..gravity
    gravityInput.Text = tostring(gravity)
end)

makeButton("+", UDim2.new(0, 160, 0, 220), function()
    gravity = math.min(500, gravity + 10)
    workspace.Gravity = gravity
    gravityLabel.Text = "Gravity: "..gravity
    gravityInput.Text = tostring(gravity)
end)

-- Gravity Input Handling
gravityInput.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        local inputValue = tonumber(gravityInput.Text)
        if inputValue then
            gravity = math.clamp(math.floor(inputValue), 0, 500) -- Round to integer
            workspace.Gravity = gravity
            gravityLabel.Text = "Gravity: "..gravity
            gravityInput.Text = tostring(gravity)
        else
            gravityInput.Text = tostring(gravity)
        end
    end
end)
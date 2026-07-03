local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local UserInputService = game:GetService("UserInputService")

-- Detect if on mobile
local isMobile = game:GetService("UserInputService").TouchEnabled and not game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.RightControl)

-- Create main ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "(970) Find the Chomiks"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Get screen size
local screenSize = screenGui and screenGui.AbsoluteSize or Vector2.new(1920, 1080)

-- Determine menu size based on device
local menuWidth = isMobile and 300 or 350
local menuHeight = isMobile and 550 or 500

-- Main frame
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainMenu"
mainFrame.Size = UDim2.new(0, menuWidth, 0, menuHeight)
mainFrame.Position = UDim2.new(0.5, -menuWidth/2, 0.5, -menuHeight/2)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

-- Add corner radius
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = mainFrame

-- Dragging variables
local dragging = false
local dragStart
local startPos

-- Title (draggable area)
local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "Title"
titleLabel.Size = UDim2.new(1, 0, 0, 50)
titleLabel.Position = UDim2.new(0, 0, 0, 0)
titleLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
titleLabel.TextColor3 = Color3.fromRGB(100, 200, 255)
titleLabel.TextSize = isMobile and 18 or 24
titleLabel.Font = Enum.Font.GothamBold
titleLabel.Text = "(970) Find the Chomiks"
titleLabel.BorderSizePixel = 0
titleLabel.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 12)
titleCorner.Parent = titleLabel

-- Mouse dragging for PC
titleLabel.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input, gameProcessed)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(
            startPos.X.Scale, 
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

-- Touch dragging for mobile
titleLabel.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
    end
end)

titleLabel.InputChanged:Connect(function(input, gameProcessed)
    if dragging and input.UserInputType == Enum.UserInputType.Touch then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(
            startPos.X.Scale, 
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

titleLabel.InputEnded:Connect(function(input, gameProcessed)
    if input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

-- Tab buttons frame
local tabFrame = Instance.new("Frame")
tabFrame.Name = "TabFrame"
tabFrame.Size = UDim2.new(1, 0, 0, 50)
tabFrame.Position = UDim2.new(0, 0, 0, 50)
tabFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
tabFrame.BorderSizePixel = 0
tabFrame.Parent = mainFrame

local tabLayout = Instance.new("UIListLayout")
tabLayout.FillDirection = Enum.FillDirection.Horizontal
tabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
tabLayout.VerticalAlignment = Enum.VerticalAlignment.Center
tabLayout.Padding = UDim.new(0, isMobile and 5 or 10)
tabLayout.Parent = tabFrame

-- TP Tab Button
local tpTabBtn = Instance.new("TextButton")
tpTabBtn.Name = "TPTab"
tpTabBtn.Size = UDim2.new(0, isMobile and 120 or 140, 0, 40)
tpTabBtn.BackgroundColor3 = Color3.fromRGB(100, 200, 255)
tpTabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
tpTabBtn.TextSize = isMobile and 14 or 16
tpTabBtn.Font = Enum.Font.GothamBold
tpTabBtn.Text = "TP"
tpTabBtn.BorderSizePixel = 0
tpTabBtn.Parent = tabFrame

local tpCorner = Instance.new("UICorner")
tpCorner.CornerRadius = UDim.new(0, 8)
tpCorner.Parent = tpTabBtn

-- Backroom Tab Button
local backroomTabBtn = Instance.new("TextButton")
backroomTabBtn.Name = "BackroomTab"
backroomTabBtn.Size = UDim2.new(0, isMobile and 120 or 140, 0, 40)
backroomTabBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 90)
backroomTabBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
backroomTabBtn.TextSize = isMobile and 14 or 16
backroomTabBtn.Font = Enum.Font.GothamBold
backroomTabBtn.Text = "Backroom"
backroomTabBtn.BorderSizePixel = 0
backroomTabBtn.Parent = tabFrame

local backroomCorner = Instance.new("UICorner")
backroomCorner.CornerRadius = UDim.new(0, 8)
backroomCorner.Parent = backroomTabBtn

-- Поле поиска (Search Bar) - Переведено на английский
local searchBox = Instance.new("TextBox")
searchBox.Name = "SearchBar"
searchBox.Size = UDim2.new(1, -20, 0, 35)
searchBox.Position = UDim2.new(0, 10, 0, 105)
searchBox.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
searchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
searchBox.PlaceholderColor3 = Color3.fromRGB(100, 100, 120)
searchBox.PlaceholderText = "🔍 Search Chomik..."
searchBox.Text = ""
searchBox.TextSize = 14
searchBox.Font = Enum.Font.Gotham
searchBox.BorderSizePixel = 0
searchBox.ClearTextOnFocus = false
searchBox.Parent = mainFrame

local searchCorner = Instance.new("UICorner")
searchCorner.CornerRadius = UDim.new(0, 6)
searchCorner.Parent = searchBox

-- Content frame
local contentFrame = Instance.new("Frame")
contentFrame.Name = "ContentFrame"
contentFrame.Size = UDim2.new(1, 0, 1, -150)
contentFrame.Position = UDim2.new(0, 0, 0, 150)
contentFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
contentFrame.BorderSizePixel = 0
contentFrame.Parent = mainFrame

-- TP Tab Content (ScrollingFrame)
local tpContent = Instance.new("ScrollingFrame")
tpContent.Name = "TPContent"
tpContent.Size = UDim2.new(1, 0, 1, 0)
tpContent.Position = UDim2.new(0, 0, 0, 0)
tpContent.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
tpContent.BorderSizePixel = 0
tpContent.ScrollBarThickness = isMobile and 10 or 8
tpContent.ScrollBarImageColor3 = Color3.fromRGB(100, 200, 255)
tpContent.CanvasSize = UDim2.new(0, 0, 0, 0)
tpContent.Parent = contentFrame

local tpLayout = Instance.new("UIListLayout")
tpLayout.FillDirection = Enum.FillDirection.Vertical
tpLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
tpLayout.VerticalAlignment = Enum.VerticalAlignment.Top
tpLayout.Padding = UDim.new(0, 8)
tpLayout.Parent = tpContent

local tpPadding = Instance.new("UIPadding")
tpPadding.PaddingLeft = UDim.new(0, 10)
tpPadding.PaddingRight = UDim.new(0, 10)
tpPadding.PaddingTop = UDim.new(0, 10)
tpPadding.PaddingBottom = UDim.new(0, 10)
tpPadding.Parent = tpContent

-- Backroom Tab Content (ScrollingFrame)
local backroomContent = Instance.new("ScrollingFrame")
backroomContent.Name = "BackroomContent"
backroomContent.Size = UDim2.new(1, 0, 1, 0)
backroomContent.Position = UDim2.new(0, 0, 0, 0)
backroomContent.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
backroomContent.BorderSizePixel = 0
backroomContent.ScrollBarThickness = isMobile and 10 or 8
backroomContent.ScrollBarImageColor3 = Color3.fromRGB(100, 200, 255)
backroomContent.CanvasSize = UDim2.new(0, 0, 0, 0)
backroomContent.Visible = false
backroomContent.Parent = contentFrame

local backroomLayout = Instance.new("UIListLayout")
backroomLayout.FillDirection = Enum.FillDirection.Vertical
backroomLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
backroomLayout.VerticalAlignment = Enum.VerticalAlignment.Top
backroomLayout.Padding = UDim.new(0, 8)
backroomLayout.Parent = backroomContent

local backroomPadding = Instance.new("UIPadding")
backroomPadding.PaddingLeft = UDim.new(0, 10)
backroomPadding.PaddingRight = UDim.new(0, 10)
backroomPadding.PaddingTop = UDim.new(0, 10)
backroomPadding.PaddingBottom = UDim.new(0, 10)
backroomPadding.Parent = backroomContent

-- Function to create TP button
local function createTPButton(parent, name, cframe)
    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.Size = UDim2.new(1, -10, 0, isMobile and 50 or 40)
    btn.BackgroundColor3 = Color3.fromRGB(50, 100, 150)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = isMobile and 16 or 14
    btn.Font = Enum.Font.Gotham
    btn.Text = name
    btn.BorderSizePixel = 0
    btn.Parent = parent
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = btn
    
    btn.MouseEnter:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(100, 150, 200)
    end)
    
    btn.MouseLeave:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(50, 100, 150)
    end)
    
    btn.MouseButton1Click:Connect(function()
        local character = player.Character or player.CharacterAdded:Wait()
        local hrp = character:WaitForChild("HumanoidRootPart")
        if cframe then
            hrp.CFrame = cframe
        end
    end)
    
    btn.TouchTap:Connect(function()
        local character = player.Character or player.CharacterAdded:Wait()
        local hrp = character:WaitForChild("HumanoidRootPart")
        if cframe then
            hrp.CFrame = cframe
        end
    end)
    
    return btn
end

-- Create TP buttons with coordinates
local tpLocations = {
    {name = "16-Bit Chomik + Noob Chomik", cframe = CFrame.new(-17.9987755, 281.499969, 492.475891, -1, 0, 0, 0, 1, 0, 0, 0, -1)},
    {name = "Location 2", cframe = nil},
    {name = "Location 3", cframe = nil},
    {name = "Location 4", cframe = nil},
    {name = "Location 5", cframe = nil},
    {name = "Location 6", cframe = nil},
    {name = "Location 7", cframe = nil},
    {name = "Location 8", cframe = nil},
    {name = "Location 9", cframe = nil},
    {name = "Chomspirasits", cframe = CFrame.new(2806.34229, 384, 998.670349, -0.258864403, 0, -0.965913713, 0, 1, 0, 0.965913713, 0, -0.258864403)},
    {name = "Periodic Chomik (BUG)", cframe = CFrame.new(-320.919647, 241.961548, 196.081055, 0, 0, -1, 0, 1, 0, 1, 0, 0)},
    {name = "party Chomik", cframe = CFrame.new(58.974987, 273.500061, -213.500015, 0, 0, 1, 0, 1, 0, -1, 0, 0)},
    {name = "Rainbow Chomik", cframe = CFrame.new(-23.9996872, 278.000092, -150.974915, -1, 0, 0, 0, 1, 0, 0, 0, -1)},
    {name = "Reggimik", cframe = CFrame.new(331.500031, 250.000626, 460.499603, 1, 0, 0, 0, 0, 1, 0, -1, 0)},
    {name = "Location 15", cframe = nil},
    {name = "Location 16", cframe = nil},
    {name = "Location 17", cframe = nil},
    {name = "Location 18", cframe = nil},
    {name = "Location 19", cframe = nil},
    {name = "Location 20", cframe = nil},
}

for _, location in ipairs(tpLocations) do
    createTPButton(tpContent, location.name, location.cframe)
end

-- Create Backroom buttons
local backroomLocations = {
    {name = "Backrooms (teleport)", cframe = CFrame.new(-489.499908, 256.500061, -3356.53491, 1, 0, 0, 0, 1, 0, 0, 0, 1)},
    {name = "SOON", cframe = nil},
    {name = "SOON", cframe = nil},
    {name = "SOON", cframe = nil},
    {name = "SOON", cframe = nil},
}

for _, location in ipairs(backroomLocations) do
    createTPButton(backroomContent, location.name, location.cframe)
end

-- Логика работы поиска
searchBox:GetPropertyChangedSignal("Text"):Connect(function()
    local filterText = string.lower(searchBox.Text)
    
    -- Фильтруем кнопки во вкладке TP
    for _, child in ipairs(tpContent:GetChildren()) do
        if child:IsA("TextButton") then
            if filterText == "" or string.find(string.lower(child.Text), filterText) then
                child.Visible = true
            else
                child.Visible = false
            end
        end
    end
    
    -- Фильтруем кнопки во вкладке Backroom
    for _, child in ipairs(backroomContent:GetChildren()) do
        if child:IsA("TextButton") then
            if filterText == "" or string.find(string.lower(child.Text), filterText) then
                child.Visible = true
            else
                child.Visible = false
            end
        end
    end
end)

-- Update canvas size
tpLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    tpContent.CanvasSize = UDim2.new(0, 0, 0, tpLayout.AbsoluteContentSize.Y + 20)
end)

backroomLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    backroomContent.CanvasSize = UDim2.new(0, 0, 0, backroomLayout.AbsoluteContentSize.Y + 20)
end)

-- Tab switching
tpTabBtn.MouseButton1Click:Connect(function()
    tpContent.Visible = true
    backroomContent.Visible = false
    tpTabBtn.BackgroundColor3 = Color3.fromRGB(100, 200, 255)
    tpTabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    backroomTabBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 90)
    backroomTabBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
end)

tpTabBtn.TouchTap:Connect(function()
    tpContent.Visible = true
    backroomContent.Visible = false
    tpTabBtn.BackgroundColor3 = Color3.fromRGB(100, 200, 255)
    tpTabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    backroomTabBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 90)
    backroomTabBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
end)

backroomTabBtn.MouseButton1Click:Connect(function()
    tpContent.Visible = false
    backroomContent.Visible = true
    tpTabBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 90)
    tpTabBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    backroomTabBtn.BackgroundColor3 = Color3.fromRGB(100, 200, 255)
    backroomTabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
end)

backroomTabBtn.TouchTap:Connect(function()
    tpContent.Visible = false
    backroomContent.Visible = true
    tpTabBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 90)
    tpTabBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    backroomTabBtn.BackgroundColor3 = Color3.fromRGB(100, 200, 255)
    backroomTabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
end)

-- Create minimize button (avatar) with menu image
local avatarSize = isMobile and 70 or 60
local avatarBtn = Instance.new("ImageButton")
avatarBtn.Name = "AvatarBtn"
avatarBtn.Size = UDim2.new(0, avatarSize, 0, avatarSize)
avatarBtn.Position = UDim2.new(1, -avatarSize - 10, 1, -avatarSize - 10)
avatarBtn.BackgroundColor3 = Color3.fromRGB(255, 200, 50)
avatarBtn.BorderSizePixel = 2
avatarBtn.BorderColor3 = Color3.fromRGB(200, 150, 0)
avatarBtn.Image = "rbxassetid://134707111242336"
avatarBtn.ScaleType = Enum.ScaleType.Stretch
avatarBtn.Visible = false
avatarBtn.Parent = screenGui

local avatarCorner = Instance.new("UICorner")
avatarCorner.CornerRadius = UDim.new(0, 10)
avatarCorner.Parent = avatarBtn

-- Avatar button functionality
avatarBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = true
    avatarBtn.Visible = false
end)

avatarBtn.TouchTap:Connect(function()
    mainFrame.Visible = true
    avatarBtn.Visible = false
end)

-- Close button
local closeBtn = Instance.new("TextButton")
closeBtn.Name = "CloseBtn"
closeBtn.Size = UDim2.new(0, isMobile and 40 or 30, 0, isMobile and 40 or 30)
closeBtn.Position = UDim2.new(1, isMobile and -50 or -40, 0, 10)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = isMobile and 20 or 16
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Text = "X"
closeBtn.BorderSizePixel = 0
closeBtn.Parent = mainFrame

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 6)
closeCorner.Parent = closeBtn

closeBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
    avatarBtn.Visible = true
end)

closeBtn.TouchTap:Connect(function()
    mainFrame.Visible = false
    avatarBtn.Visible = true
end)

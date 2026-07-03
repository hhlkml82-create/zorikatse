local player = game.Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "TeleportMenu"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 180, 0, 100)
frame.Position = UDim2.new(0.5, -90, 0.5, -50)
frame.Parent = gui

local button = Instance.new("TextButton")
button.Size = UDim2.new(1, -20, 0, 40)
button.Position = UDim2.new(0, 10, 0, 30)
button.Text = "Телепорт"
button.Parent = frame

button.MouseButton1Click:Connect(function()
    local character = player.Character or player.CharacterAdded:Wait()
    local hrp = character:WaitForChild("HumanoidRootPart")

    hrp.CFrame = CFrame.new(
        -27.875, 3.27508545, -13219.5,
        0, 0, 1,
        0, 1, 0,
        -1, 0, 0
    )
end)
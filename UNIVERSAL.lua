local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local function createLabel(player)
    if player.Character and player.Character:FindFirstChild("Torso") then
        local billboardGui = Instance.new("BillboardGui")
        billboardGui.Adornee = player.Character.Torso
        billboardGui.Size = UDim2.new(0, 100, 0, 50)
        billboardGui.StudsOffset = Vector3.new(0, 3, 0)
        
        local textLabel = Instance.new("TextLabel")
        textLabel.Size = UDim2.new(1, 0, 1, 0)
        textLabel.Text = player.Name
        textLabel.BackgroundTransparency = 1
        textLabel.TextColor3 = Color3.new(1, 1, 1)
        textLabel.Parent = billboardGui
        
        billboardGui.Parent = player.Character.Torso
    end
end


local function highlightTorso(player)
    if player.Character and player.Character:FindFirstChild("Torso") then
        local highlight = Instance.new("Highlight")
        highlight.Adornee = player.Character.Torso
        highlight.FillColor = Color3.new(1, 0, 0)
        highlight.FillTransparency = 0.5
        highlight.OutlineColor = Color3.new(1, 1, 0)
        highlight.OutlineTransparency = 0
        highlight.Parent = player.Character.Torso
    end
end


local function createESPLine(player)
    local line = Instance.new("Line")
    line.Color = Color3.new(1, 1, 1) 
    line.Transparency = 0.5
    line.Parent = workspace

    RunService.RenderStepped:Connect(function()
        if player.Character and player.Character:FindFirstChild("Torso") then
            line.Position = player.Character.Torso.Position
            line.Length = (workspace.CurrentCamera.CFrame.Position - player.Character.Torso.Position).magnitude
            line.CFrame = CFrame.new(player.Character.Torso.Position, workspace.CurrentCamera.CFrame.Position)
        end
    end)
end

for _, player in ipairs(Players:GetPlayers()) do
    highlightTorso(player)
    createLabel(player)
    createESPLine(player)
end


Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function()
        highlightTorso(player)
        createLabel(player)
        createESPLine(player)
    end)
end)

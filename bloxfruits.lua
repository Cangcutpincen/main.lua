-- BloxNexus Ultra - Blox Fruits Visual GUI Hub Module
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local ProtectedGui = (gethui and gethui()) or CoreGui
-- Hapus GUI lama jika ada
if ProtectedGui:FindFirstChild("BloxFruitsHubGUI") then
ProtectedGui.BloxFruitsHubGUI:Destroy()
end
-- Membuat ScreenGui Utama
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BloxFruitsHubGUI"
ScreenGui.Parent = ProtectedGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false
-- Frame Utama Hub
local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 23, 42)
MainFrame.Position = UDim2.new(0.5, -225, 0.5, -160)
MainFrame.Size = UDim2.new(0, 450, 0, 320)
MainFrame.Active = true
MainFrame.Draggable = true
local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 14)
Corner.Parent = MainFrame
local Stroke = Instance.new("UIStroke")
Stroke.Color = Color3.fromRGB(139, 92, 246)
Stroke.Thickness = 1.5
Stroke.Parent = MainFrame
-- Judul
local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.BackgroundTransparency = 1.0
Title.Position = UDim2.new(0, 20, 0, 15)
Title.Size = UDim2.new(0, 350, 0, 30)
Title.Font = Enum.Font.GothamBold
Title.Text = "BLOX FRUITS PRO HUB"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 15
Title.TextXAlignment = Enum.TextXAlignment.Left
-- Tombol Close (X)
local CloseBtn = Instance.new("TextButton")
CloseBtn.Parent = MainFrame
CloseBtn.BackgroundColor3 = Color3.fromRGB(244, 63, 94)
CloseBtn.Position = UDim2.new(1, -40, 0, 15)
CloseBtn.Size = UDim2.new(0, 26, 0, 26)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 12
local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseBtn
CloseBtn.MouseButton1Click:Connect(function()
ScreenGui:Destroy()
end)
-- Tombol 1: Auto Farm Level
local Btn1 = Instance.new("TextButton")
Btn1.Parent = MainFrame
Btn1.BackgroundColor3 = Color3.fromRGB(139, 92, 246)
Btn1.Position = UDim2.new(0, 20, 0, 65)
Btn1.Size = UDim2.new(0, 410, 0, 45)
Btn1.Font = Enum.Font.GothamBold
Btn1.Text = "Status Auto Farm: OFF"
Btn1.TextColor3 = Color3.fromRGB(255, 255, 255)
Btn1.TextSize = 13
local Btn1C = Instance.new("UICorner")
Btn1C.CornerRadius = UDim.new(0, 8)
Btn1C.Parent = Btn1
local autoFarmActive = false
Btn1.MouseButton1Click:Connect(function()
autoFarmActive = not autoFarmActive
if autoFarmActive then
Btn1.Text = "Status Auto Farm: ACTIVE (Hunting Nearest Enemy)"
Btn1.BackgroundColor3 = Color3.fromRGB(16, 185, 129)
else
Btn1.Text = "Status Auto Farm: OFF"
Btn1.BackgroundColor3 = Color3.fromRGB(139, 92, 246)
end
end)
-- Looping Auto Farm
task.spawn(function()
while task.wait(1) do
if autoFarmActive then
pcall(function()
local char = LocalPlayer.Character
if char and char:FindFirstChild("HumanoidRootPart") then
local enemies = workspace:FindFirstChild("Enemies")
if enemies then
for _, enemy in pairs(enemies:GetChildren()) do
if autoFarmActive and enemy:FindFirstChild("HumanoidRootPart") and enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
char.HumanoidRootPart.CFrame = enemy.HumanoidRootPart.CFrame + Vector3.new(0, 4, 0)
end
end
end
end
end)
end
end
end)
-- Tombol 2: ESP Devil Fruit
local Btn2 = Instance.new("TextButton")
Btn2.Parent = MainFrame
Btn2.BackgroundColor3 = Color3.fromRGB(30, 41, 59)
Btn2.Position = UDim2.new(0, 20, 0, 125)
Btn2.Size = UDim2.new(0, 410, 0, 45)
Btn2.Font = Enum.Font.GothamBold
Btn2.Text = "Toggle ESP Devil Fruit"
Btn2.TextColor3 = Color3.fromRGB(255, 255, 255)
Btn2.TextSize = 13
local Btn2C = Instance.new("UICorner")
Btn2C.CornerRadius = UDim.new(0, 8)
Btn2C.Parent = Btn2
Btn2.MouseButton1Click:Connect(function()
pcall(function()
for _, obj in pairs(workspace:GetChildren()) do
if obj.Name:find("Fruit") and obj:IsA("BasePart") then
if not obj:FindFirstChild("BillboardGui") then
local bg = Instance.new("BillboardGui")
bg.Size = UDim2.new(0, 100, 0, 40)
bg.AlwaysOnTop = true
bg.Parent = obj
local txt = Instance.new("TextLabel")
txt.Size = UDim2.new(1,0,1,0)
txt.BackgroundTransparency = 1
txt.TextColor3 = Color3.fromRGB(255, 0, 0)
txt.TextScaled = true
txt.Text = "FRUIT HERE!"
txt.Parent = bg
end
end
end
end)
Btn2.Text = "ESP Devil Fruit Scanned!"
Btn2.BackgroundColor3 = Color3.fromRGB(56, 189, 248)
end)
-- Tombol 3: Anti-AFK
local Btn3 = Instance.new("TextButton")
Btn3.Parent = MainFrame
Btn3.BackgroundColor3 = Color3.fromRGB(30, 41, 59)
Btn3.Position = UDim2.new(0, 20, 0, 185)
Btn3.Size = UDim2.new(0, 410, 0, 45)
Btn3.Font = Enum.Font.GothamBold
Btn3.Text = "Enable Anti-AFK Bypass"
Btn3.TextColor3 = Color3.fromRGB(255, 255, 255)
Btn3.TextSize = 13
local Btn3C = Instance.new("UICorner")
Btn3C.CornerRadius = UDim.new(0, 8)
Btn3C.Parent = Btn3
Btn3.MouseButton1Click:Connect(function()
local vu = game:GetService("VirtualUser")
LocalPlayer.Idled:Connect(function()
vu:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
task.wait(1)
vu:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
end)
Btn3.Text = "Anti-AFK Active (Safe from 20m Kick)"
Btn3.BackgroundColor3 = Color3.fromRGB(16, 185, 129)
end)
print("[BloxFruits Hub]: Visual GUI successfully loaded!")

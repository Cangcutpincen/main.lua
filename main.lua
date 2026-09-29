-- BloxNexus Ultra - In-Game Roblox GUI Hub Template
-- Salin seluruh kode ini ke file main.lua di GitHub Anda.
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
-- Hapus GUI lama jika ada agar tidak menumpuk saat di-execute ulang
if CoreGui:FindFirstChild("BloxNexusHubGUI") then
CoreGui.BloxNexusHubGUI:Destroy()
end
-- Membuat ScreenGui utama
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BloxNexusHubGUI"
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false
-- Frame Utama (Desain Cyberpunk Dark)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(11, 15, 25) -- Warna gelap konsisten
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -130)
MainFrame.Size = UDim2.new(0, 400, 0, 260)
MainFrame.Active = true
MainFrame.Draggable = true -- Membuat jendela bisa digeser (ditarik) di layar HP/PC
-- Sudut Melengkung Frame
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame
-- Garis Tepi (Stroke) Neon Cyan
local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(14, 165, 233)
UIStroke.Thickness = 1.5
UIStroke.Parent = MainFrame
-- Judul Hub di Header
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Parent = MainFrame
TitleLabel.BackgroundTransparency = 1.0
TitleLabel.Position = UDim2.new(0, 15, 0, 12)
TitleLabel.Size = UDim2.new(0, 300, 0, 30)
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.Text = "BLOXNEXUS ULTRA HUB"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 14
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
-- Tombol Close (X)
local CloseBtn = Instance.new("TextButton")
CloseBtn.Parent = MainFrame
CloseBtn.BackgroundColor3 = Color3.fromRGB(244, 63, 94)
CloseBtn.Position = UDim2.new(1, -35, 0, 12)
CloseBtn.Size = UDim2.new(0, 24, 0, 24)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 11
local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseBtn
CloseBtn.MouseButton1Click:Connect(function()
ScreenGui:Destroy()
end)
-- Teks Status Informasi User
local StatusText = Instance.new("TextLabel")
StatusText.Parent = MainFrame
StatusText.BackgroundTransparency = 1.0
StatusText.Position = UDim2.new(0, 15, 0, 52)
StatusText.Size = UDim2.new(0, 370, 0, 20)
StatusText.Font = Enum.Font.Code
StatusText.Text = "Status: Connected | User: " .. LocalPlayer.Name
StatusText.TextColor3 = Color3.fromRGB(148, 163, 184)
StatusText.TextSize = 11
StatusText.TextXAlignment = Enum.TextXAlignment.Left
-- Tombol 1: Load Infinite Yield
local Btn1 = Instance.new("TextButton")
Btn1.Parent = MainFrame
Btn1.BackgroundColor3 = Color3.fromRGB(14, 165, 233)
Btn1.Position = UDim2.new(0, 15, 0, 95)
Btn1.Size = UDim2.new(0, 370, 0, 42)
Btn1.Font = Enum.Font.GothamBold
Btn1.Text = "Load Infinite Yield Admin"
Btn1.TextColor3 = Color3.fromRGB(255, 255, 255)
Btn1.TextSize = 12
local Btn1Corner = Instance.new("UICorner")
Btn1Corner.CornerRadius = UDim.new(0, 8)
Btn1Corner.Parent = Btn1
Btn1.MouseButton1Click:Connect(function()
pcall(function()
loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
end)
end)
-- Tombol 2: Aktifkan Anti-AFK
local Btn2 = Instance.new("TextButton")
Btn2.Parent = MainFrame
Btn2.BackgroundColor3 = Color3.fromRGB(30, 41, 59)
Btn2.Position = UDim2.new(0, 15, 0, 150)
Btn2.Size = UDim2.new(0, 370, 0, 42)
Btn2.Font = Enum.Font.GothamBold
Btn2.Text = "Enable Anti-AFK Bypass"
Btn2.TextColor3 = Color3.fromRGB(255, 255, 255)
Btn2.TextSize = 12
local Btn2Corner = Instance.new("UICorner")
Btn2Corner.CornerRadius = UDim.new(0, 8)
Btn2Corner.Parent = Btn2
Btn2.MouseButton1Click:Connect(function()
local vu = game:GetService("VirtualUser")
LocalPlayer.Idled:Connect(function()
vu:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
task.wait(1)
vu:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
end)
print("[BloxNexus]: Anti-AFK Bypass Activated!")
end)
print("[BloxNexus]: Hub GUI successfully rendered inside Roblox!")

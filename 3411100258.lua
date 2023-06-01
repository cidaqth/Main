setclipboard("https://discord.gg/2GxncFs5dB")

if on ~= false and on ~= true and on ~= nil then on = true end 

if on == nil then on = false end 

repeat task.wait() until game:GetService("Players").LocalPlayer

for i,v in pairs(getconnections(game:GetService("Players").LocalPlayer.Idled)) do

	v:Disable()

end

local ci = game.ReplicatedStorage:WaitForChild("CargoInfo")

local remote = game.ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Shop")

local Main = {

    Bricklandia = {

        CFrame = CFrame.new(-461, -25, 234),

        Info = ci:WaitForChild("BricklandiaCargoTrader"),

        Cargo = {"flowers", "iron", "chalices"},

    },

    Farlands = {

        CFrame = CFrame.new(1090, -25, -185),

        Info = ci:WaitForChild("FarlandsCargoTrader"),

        Cargo = {"coal", "lumber", "potions"},

    },

    Pirate = {

        CFrame = CFrame.new(160, -25, -1535),

        Info = ci:WaitForChild("PirateCargoTrader"),

        Cargo = {"fish", "gunpowder", "gold"},

    }

}

function Main:GetSellerFromItem(item)

    if table.find(Main.Bricklandia.Cargo, item) then return Main.Bricklandia end

    if table.find(Main.Farlands.Cargo, item) then return Main.Farlands end

    if table.find(Main.Pirate.Cargo, item) then return Main.Pirate end

end

function Main:GetHighestValuedItem()

    local highestmoney

    local highestitem

    local trader

    local function ForLoop(item, tr) 

        if not highestmoney and not highestitem and not trader then

            highestmoney = item.Value

            highestitem = item.Name

            trader = tr

        elseif item.Value > highestmoney then

            highestmoney = item.Value

            highestitem = item.Name

            trader = tr

        end

    end

    for _, v in pairs(Main.Bricklandia.Info.Sell:GetChildren()) do ForLoop(v, Main.Bricklandia) end

    for _, v in pairs(Main.Farlands.Info.Sell:GetChildren()) do ForLoop(v, Main.Farlands) end

    for _, v in pairs(Main.Pirate.Info.Sell:GetChildren()) do ForLoop(v, Main.Pirate) end

    return highestitem, trader, highestmoney

end

function Main:Shop(item, isbuying)

    remote:FireServer(item, false, isbuying)

end

Main.DoYourThing = function(chr) 

    local ncf = nil

    local hrp = chr:WaitForChild("HumanoidRootPart")

    local hum = chr:WaitForChild("Humanoid")

    local noclip = game:GetService("RunService").Stepped:Connect(function() -- Noclip and teleporting

        if ncf then

            hrp.CFrame = ncf

            hrp.Velocity = Vector3.new(0, 0, 0)

        end

        for _, v in pairs(chr:GetDescendants()) do

            if v:IsA("BasePart") and v.CanCollide then

                v.CanCollide = false

            end

        end

    end)

    task.wait(3) 

    repeat

        local buy, seller, mon = Main:GetHighestValuedItem() 

        Buying.Text = "Highest Valued Item: " .. buy .. " ($" .. tostring(mon) .. ")" 

        local buyer = Main:GetSellerFromItem(buy) 

        ncf = buyer.CFrame 

        task.wait(0.1) 

        Main:Shop(buy, true) 

        task.wait(5) 

        ncf = seller.CFrame

        task.wait(0.1) 

        Main:Shop(buy, false)

        task.wait(0.1)

    until hum.Health <= 0 or not on 

    noclip:Disconnect() 

    hum.Health = 0 

end

if showui then

    game:GetService("RunService"):Set3dRenderingEnabled(not on) 

else

    game:GetService("RunService"):Set3dRenderingEnabled(true)

end

if on and not conn then

    ls = game.Players.LocalPlayer:WaitForChild("leaderstats")

    coins = ls:WaitForChild("coins")

    if coins.Value < 50 then

        game:GetService("StarterGui"):SetCore("SendNotification", {

	        Title = "Z0r Ware";

	        Text = "u need 50 coins.";

	        Duration = 10;

        })

        game:GetService("RunService"):Set3dRenderingEnabled(true)

        getgenv().on = false

        return

    end

    if game.Players.LocalPlayer.Team == game:GetService("Teams").choosing then

        game:GetService("StarterGui"):SetCore("SendNotification", {

	        Title = "Z0r Ware";

	        Text = "Please select a team before executing.";

	        Duration = 5;

        })

        game:GetService("RunService"):Set3dRenderingEnabled(true) 

        getgenv().on = false

        return 

    end

    

	CargoShipper = Instance.new("ScreenGui")

	Background = Instance.new("Frame")

	Title = Instance.new("TextLabel")

	Subtitle = Instance.new("TextLabel")

	Profit = Instance.new("TextLabel")

	Loss = Instance.new("TextLabel")

	Total = Instance.new("TextLabel")

	Buying = Instance.new("TextLabel")

	CargoShipper.Name = "CargoShipper"

	CargoShipper.Parent = game.CoreGui

	CargoShipper.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

	CargoShipper.Enabled = showui

	Background.Name = "Background"

	Background.Parent = CargoShipper

	Background.BackgroundColor3 = Color3.fromRGB(20, 20, 20)

	Background.BorderSizePixel = 0

	Background.Size = UDim2.new(1, 0, 1.05, 0)

	Background.Position = UDim2.new(0, 0, -0.05, 0)

	Title.Name = "Title"

	Title.Parent = Background

	Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

	Title.BackgroundTransparency = 1.000

	Title.BorderSizePixel = 0

	Title.Size = UDim2.new(1, 0, 0.200000003, 0)

	Title.FontFace = Font.new("rbxasset://fonts/families/PressStart2P.json", Enum.FontWeight.Bold)

	Title.Text = "Z0r Ware"

	Title.TextColor3 = Color3.fromRGB(255, 255, 0)

	Title.TextScaled = true

	Title.TextSize = 14.000

	Title.TextWrapped = true

	Subtitle.Name = "Subtitle"

	Subtitle.Parent = Background

	Subtitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

	Subtitle.BackgroundTransparency = 1.000

	Subtitle.BorderSizePixel = 0

	Subtitle.Position = UDim2.new(0, 0, 0.120370358, 0)

	Subtitle.Size = UDim2.new(1, 0, 0.100000001, 0)

	Subtitle.FontFace = Font.new("rbxasset://fonts/families/PressStart2P.json", Enum.FontWeight.Bold, Enum.FontStyle.Italic)

	Subtitle.Text = "by hountor haziste"

	Subtitle.TextColor3 = Color3.fromRGB(255, 255, 0)

	Subtitle.TextSize = 36.000

	Subtitle.TextWrapped = true

	Profit.Name = "Profit"

	Profit.Parent = Background

	Profit.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

	Profit.BackgroundTransparency = 1.000

	Profit.BorderSizePixel = 0

	Profit.Position = UDim2.new(0, 0, 0.300000012, 0)

	Profit.Size = UDim2.new(1, 0, 0.100000001, 0)

	Profit.Font = Enum.Font.Arcade

	Profit.Text = "Profits: $0"

	Profit.TextColor3 = Color3.fromRGB(0, 255, 0)

	Profit.TextSize = 75.000

	Profit.TextWrapped = true

	Loss.Name = "Loss"

	Loss.Parent = Background

	Loss.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

	Loss.BackgroundTransparency = 1.000

	Loss.BorderSizePixel = 0

	Loss.Position = UDim2.new(0, 0, 0.600000024, 0)

	Loss.Size = UDim2.new(1, 0, 0.100000001, 0)

	Loss.Font = Enum.Font.Arcade

	Loss.Text = "Expenses: $0"

	Loss.TextColor3 = Color3.fromRGB(255, 0, 0)

	Loss.TextSize = 75.000

	Loss.TextWrapped = true

	Total.Name = "Total"

	Total.Parent = Background

	Total.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

	Total.BackgroundTransparency = 1.000

	Total.BorderSizePixel = 0

	Total.Position = UDim2.new(0, 0, 0.450000018, 0)

	Total.Size = UDim2.new(1, 0, 0.100000001, 0)

	Total.Font = Enum.Font.Arcade

	Total.Text = "Total: $0"

	Total.TextColor3 = Color3.fromRGB(255, 255, 255)

	Total.TextSize = 100.000

	Total.TextWrapped = true

	Buying.Name = "Buying"

	Buying.Parent = Background

	Buying.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

	Buying.BackgroundTransparency = 1.000

	Buying.BorderSizePixel = 0

	Buying.Position = UDim2.new(0, 0, 0.9, 0)

	Buying.Size = UDim2.new(1, 0, 0.100000001, 0)

	Buying.Font = Enum.Font.Arcade

	Buying.Text = "Highest Valued Item: ???? ($???)"

	Buying.TextColor3 = Color3.fromRGB(255, 255, 0)

	Buying.TextSize = 75.000

	Buying.TextWrapped = true

    getgenv().conn = conn or {} 

    local ov = coins.Value

    local win = 0

    local lose = 0

    local tot = 0

    local d  = coins.Changed:Connect(function(nv)

        local diff = nv - ov

        ov = nv

        if diff == 0 then return end

        if diff < 0 then

            lose = lose + math.abs(diff)

            Loss.Text = "Expenses: -$" .. tostring(lose)

            tot = win - lose

        elseif diff > 0 then

            win = win + math.abs(diff)

            Profit.Text = "Profits: +$" .. tostring(win)

            tot = win - lose

        end

        if tot == 0 then

            Total.TextColor3 = Color3.new(1, 1, 1)

            Total.Text = "Total: $0"

        elseif tot > 0 then

            Total.TextColor3 = Color3.new(1, 1, 0)

            Total.Text = "Total: +$" .. tostring(math.abs(tot))

        elseif tot < 0 then

            Total.TextColor3 = Color3.fromRGB(255, 100, 0)

            Total.Text = "Total: -$" .. tostring(math.abs(tot))

        end

    end)

    local c = game.Players.LocalPlayer.CharacterAdded:Connect(Main.DoYourThing)

    table.insert(conn, c)

    if game.Players.LocalPlayer.Character then

        Main.DoYourThing(game.Players.LocalPlayer.Character)

    end

elseif not on and conn then

    game:GetService("StarterGui"):SetCore("SendNotification", { 

	   Title = "Z0r Ware";

	   Text = "Rejoin to reuse the script again ";

	   Duration = 10;

    })

    for _, con in pairs(conn) do 

        con:Disconnect()

    end

    conn = nil

    if game.CoreGui:FindFirstChild("CargoShipper") then game.CoreGui:FindFirstChild("CargoShipper"):Destroy() end

    game:GetService("RunService"):Set3dRenderingEnabled(true)

elseif  on and conn then 

    local CargoShipper = game.CoreGui:FindFirstChild("CargoShipper")

    game:GetService("RunService"):Set3dRenderingEnabled(not showui)

    if CargoShipper then

        CargoShipper.Enabled = showui

    end

end

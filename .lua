--[[Script được mã hoá bởi khoitongdz]]--
local function _XOR(s,k) return (s:gsub(".", function(c) return string.char(bit.bxor(string.byte(c), k)) end)) end
local function _Base64Enc(d) return (d:gsub(".", function(c) return string.format("%02X", string.byte(c)) end)) end
local function _Base64Dec(d) return (d:gsub("%x%x", function(c) return string.char(tonumber(c, 16)) end)) end
local function _RC4(d, k) local S, j, out = {}, 0, {} for i = 0, 255 do S[i] = i end for i = 0, 255 do j = (j + S[i] + string.byte(k, (i % #k) + 1)) % 256 S[i], S[j] = S[j], S[i] end j = 0 for i = 1, #d do local i = (i + 1) % 256 j = (j + S[i]) % 256 S[i], S[j] = S[j], S[i] out[#out+1] = string.char(bit.bxor(string.byte(d, i), S[(S[i] + S[j]) % 256])) end return table.concat(out) end

if hookfunction or getgc or debug or setreadonly then error("🚫 Anti-Debug Activated 🚫") end
local _Key=math.random(50,200)
local _EncStr=_Base64Enc(_XOR("Leviathan", _Key))
if _XOR(_Base64Dec(_EncStr), _Key) ~= "Leviathan" then return end

local _MainThread=function()
    local _Game, _Players, _LocalPlayer=game, game.Players, game.Players.LocalPlayer
    if not _Game or not _Players or not _LocalPlayer then return end
    
    pcall(function()
        local _Character=_LocalPlayer.Character or _LocalPlayer.CharacterAdded:Wait()
        local _RootPart=_Character:FindFirstChild("HumanoidRootPart")
        if not _RootPart then return end
        
        local _Island=Instance.new("Part")
        _Island.Size=Vector3.new(300,100,300)
        _Island.Material=Enum.Material.Rock
        _Island.BrickColor=BrickColor.new("Dark stone grey")
        _Island.Anchored=true
        _Island.Position=_RootPart.Position+Vector3.new(0,-200,0)
        _Island.Parent=game.Workspace
        
        game:GetService("TweenService"):Create(_Island,TweenInfo.new(5,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Position=_RootPart.Position+Vector3.new(0,-10,0)}):Play()
        game:GetService("Debris"):AddItem(_Island,9000)
        
        local _Boss=Instance.new("Model")
        _Boss.Name="Leviathan"
        _Boss.Parent=game.Workspace
        
        local _BossPart=Instance.new("Part")
        _BossPart.Size=Vector3.new(30,30,30)
        _BossPart.Material=Enum.Material.SmoothPlastic
        _BossPart.BrickColor=BrickColor.new("Bright blue")
        _BossPart.Anchored=false
        _BossPart.Position=_RootPart.Position+Vector3.new(0,50,0)
        _BossPart.Parent=_Boss
        
        local _BossHealth=Instance.new("Humanoid")
        _BossHealth.Health=1000000
        _BossHealth.MaxHealth=1000000
        _BossHealth.Parent=_Boss
        
        for _=1,50 do
            local _IceBlock=Instance.new("Part")
            _IceBlock.Size=Vector3.new(math.random(5,15),math.random(20,40),math.random(5,15))
            _IceBlock.Material=Enum.Material.Ice
            _IceBlock.BrickColor=BrickColor.new("Cyan")
            _IceBlock.Anchored=true
            _IceBlock.Position=_BossPart.Position+Vector3.new(math.random(-40,40),-15,math.random(-40,40))
            _IceBlock.Parent=game.Workspace
            game:GetService("Debris"):AddItem(_IceBlock,300)
        end
        
        task.wait(1)
        local _Warning=Instance.new("Message",game.Workspace)
        _Warning.Text="⚠️ Leviathan đã thức tỉnh! Chuẩn bị chiến đấu! ⚠️"
        task.wait(3)
        _Warning:Destroy()
    end)
end

local _EncMain=_Base64Enc(_RC4(string.dump(_MainThread), tostring(_Key)))
local _RunScript=loadstring(_RC4(_Base64Dec(_EncMain), tostring(_Key)))
if _RunScript then _RunScript() end

_G = nil setfenv(1, {}) collectgarbage("collect")
if typeof(debug) == "table" then debug = nil end if typeof(getfenv) == "function" then setfenv(1, {}) end

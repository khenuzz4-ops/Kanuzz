local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

local maxStamina = 100
local currentStamina = maxStamina

local normalSpeed = 16
local sprintSpeed = 25

local staminaDrain = 20
local staminaRegen = 15

local isSprinting = false
local connection

local function setupCharacter(character)
	if connection then
		connection:Disconnect()
	end

	local humanoid = character:WaitForChild("Humanoid")
	currentStamina = maxStamina
	isSprinting = false
	humanoid.WalkSpeed = normalSpeed

	connection = RunService.RenderStepped:Connect(function(deltaTime)
		if isSprinting and humanoid.MoveDirection.Magnitude > 0 and currentStamina > 0 then
			currentStamina = math.max(0, currentStamina - staminaDrain * deltaTime)
			humanoid.WalkSpeed = sprintSpeed

			if currentStamina <= 0 then
				isSprinting = false
			end
		else
			currentStamina = math.min(maxStamina, currentStamina + staminaRegen * deltaTime)
			humanoid.WalkSpeed = normalSpeed
		end
	end)
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end

	if input.KeyCode == Enum.KeyCode.LeftShift then
		isSprinting = true
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.LeftShift then
		isSprinting = false
	end
end)

if player.Character then
	setupCharacter(player.Character)
end

player.CharacterAdded:Connect(setupCharacter)

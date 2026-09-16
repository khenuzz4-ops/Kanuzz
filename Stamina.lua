local CollectionService = game:GetService("CollectionService")

local function addESP(object)
	if not object:IsA("Model") then return end
	if object:FindFirstChild("GhostESP") then return end

	local highlight = Instance.new("Highlight")
	highlight.Name = "GhostESP"
	highlight.Adornee = object
	highlight.FillTransparency = 0.5
	highlight.OutlineTransparency = 0
	highlight.Parent = object
end

for _, ghost in ipairs(CollectionService:GetTagged("Ghost")) do
	addESP(ghost)
end

CollectionService:GetInstanceAddedSignal("Ghost"):Connect(addESP)

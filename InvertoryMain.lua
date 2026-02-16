local Players: Players = game:GetService("Players")

local Player: Player = Players.LocalPlayer
local PlayerGui: PlayerGui = Player:WaitForChild("PlayerGui")

local GuiMain: ScreenGui = PlayerGui:WaitForChild("Ui_Slots")
local ClientScripts: Folder = GuiMain:WaitForChild("Client_Scripts")


local Modules: Folder = ClientScripts:WaitForChild("Core"):WaitForChild("Modules")
local ConfigModule: ModuleScript = require(Modules:WaitForChild("Slots_Config"))


local function CreateSlots()
	local SlotTemplate: Frame = script:WaitForChild("SlotTemplate")
	local maxSlots = ConfigModule.MaxSlots

	local function ShowSlot(SlotName: Frame)
		local Slot = SlotName
		Slot.Visible = true
	end

	local function AjustSlotPosition(Slot: Frame)
		if Slot.Name == "Slot_2" then
			Slot.Position = UDim2.new(0.259, 0, -0.01, 0)

		elseif Slot.Name == "Slot_3" then
			Slot.Position = UDim2.new(0.515, 0, -0.01, 0)

		elseif Slot.Name == "Slot_4" then
			Slot.Position = UDim2.new(0.779, 0, -0.01, 0)
		end
	end


	for i = 1, maxSlots do
		local Slot: Frame = SlotTemplate:Clone()

		Slot.Name = "Slot_"..tostring(i)

		local numberLabel = Slot:FindFirstChild("NumberLabel") :: TextLabel
		numberLabel.Text = tostring(i)

		local handlerBody = GuiMain:FindFirstChild("Handler_Body") :: Frame
		Slot.Parent = handlerBody

		Slot.Visible = false
		if ConfigModule.debugMode then
			print("CreateSlot: Created Slot ", Slot.Name)
			task.wait(0.1)
			print("CreateSlot: Status:", 
				"Slot:", Slot.Name,
				"NumberValue:", Slot:FindFirstChild("NumberValue"),
				"Parent:", Slot.Parent
			)
		end
	end

	local slot_1 = GuiMain:WaitForChild("Handler_Body"):WaitForChild("Slot_1", 10) :: Frame
	local slot_2 = GuiMain:WaitForChild("Handler_Body"):WaitForChild("Slot_2", 10) :: Frame
	local slot_3 = GuiMain:WaitForChild("Handler_Body"):WaitForChild("Slot_3", 10) :: Frame
	local slot_4 = GuiMain:WaitForChild("Handler_Body"):WaitForChild("Slot_4", 10) :: Frame

	AjustSlotPosition(slot_2)
	AjustSlotPosition(slot_3)
	AjustSlotPosition(slot_4)

	task.wait(ConfigModule.TimeShowdelay)

	ShowSlot(slot_1)
	ShowSlot(slot_2)
	ShowSlot(slot_3)
	ShowSlot(slot_4)
	
	GuiMain:FindFirstChild("Handler_Body").Visible = true
end

CreateSlots()

local Players: Players = (cloneref and cloneref(game:GetService("Players"))) or game:GetService("Players")

local LocalPlayer = Players.LocalPlayer

local CharacterModule = {}
CharacterModule.__index = CharacterModule

local DataTypes = {
    Stunned = Instance.new("BoolValue");
}

local AttributeTypes = {
    Melee = 0
}

type self = {
    char: Model & {
        HumanoidRootPart: Part;
        Humanoid: Humanoid;
    },
    combat: typeof(DataTypes)
}

function CharacterModule.new(character: Model?)
    if not character or character:FindFirstChild("Combat") then
        return nil
    end

    local DataFolder = Instance.new("Folder")
    DataFolder.Name = "Combat"

    for DataName, DataValue in pairs(DataTypes) do
        local ClonedDataValue = DataValue:Clone()
        ClonedDataValue.Name = DataName
        ClonedDataValue.Parent = DataFolder
    end

    for AttrName, AttrValue in pairs(AttributeTypes) do
        character:SetAttribute(AttrName, AttrValue)
    end

    DataFolder.Parent = character

    return setmetatable({
        char = character,
        combat = DataFolder
    }, {});
end

function CharacterModule.Stun(self: self, decay: number, status: boolean?)
    self.combat.Stunned.Value = true
end

CharacterModule.StunChanged = 

return CharacterModule
-- Based on octopath2.apworld (v0.5)

local item_id_to_code = {
    --REGIONS
    [2290649991] = "totohaha_unlock",
    [2290649992] = "brightlands_unlock",
    [2290649993] = "crestlands_unlock",
    [2290649994] = "winterlands_unlock",
    [2290649995] = "harborlands_unlock",
    [2290649996] = "hinoeuma_unlock",
    [2290649997] = "wildlands_unlock",
    [2290649998] = "leaflands_unlock",
    --CHARACTERS
    [2290649999] = "ochette_unlock",
    [2290650000] = "throne_unlock",
    [2290650001] = "temenos_unlock",
    [2290650002] = "osvald_unlock",
    [2290650003] = "castti_unlock",
    [2290650004] = "hikari_unlock",
    [2290650005] = "partitio_unlock",
    [2290650006] = "agnea_unlock",
    --OTHERS
    [2290650057] = "boat_unlock",
    [2290650059] = "grand_terry_unlock",
    [2290650058] = "time_change_unlock",
    --CHAPTERS
    --Ochette
    [2290650007] = "ochette_ch1",
    [2290650008] = "ochette_ch2A",
    [2290650009] = "ochette_ch2T",
    [2290650010] = "ochette_ch2G",
    [2290650011] = "ochette_ch3",
    --Throne
    [2290650012] = "throne_ch1",
    [2290650013] = "throne_ch2M",
    [2290650014] = "throne_ch2F",
    [2290650015] = "throne_ch3M",
    [2290650016] = "throne_ch3F",
    [2290650017] = "throne_ch4",
    --Temenos
    [2290650018] = "temenos_ch1",
    [2290650019] = "temenos_ch2",
    [2290650020] = "temenos_ch3C",
    [2290650021] = "temenos_ch3S",
    [2290650022] = "temenos_ch4",
    --Osvald
    [2290650023] = "osvald_ch1",
    --[2290650023] = "osvald_ch2",
    [2290650024] = "osvald_ch3",
    [2290650025] = "osvald_ch4",
    [2290650026] = "osvald_ch5",
    --Castti
    [2290650027] = "castti_ch1",
    [2290650028] = "castti_ch2S",
    [2290650029] = "castti_ch2W",
    [2290650030] = "castti_ch3",
    [2290650031] = "castti_ch4",
    --Hikari
    [2290650032] = "hikari_ch1",
    [2290650033] = "hikari_ch2",
    [2290650034] = "hikari_ch3",
    [2290650035] = "hikari_ch4",
    [2290650036] = "hikari_ch5",
    --Partitio
    [2290650037] = "partitio_ch1",
    [2290650038] = "partitio_ch2",
    [2290650039] = "partitio_ch3",
    [2290650040] = "partitio_ch4",
    [2290650041] = "partitio_scT",
    [2290650042] = "partitio_scW",
    [2290650043] = "partitio_scS",
    --Agnea
    [2290650044] = "agnea_ch1",
    [2290650045] = "agnea_ch2",
    [2290650046] = "agnea_ch3",
    [2290650047] = "agnea_ch4",
    [2290650048] = "agnea_ch5",
    --Temenos and Throne
    [2290650049] = "temenos_throne_ch1",
    [2290650050] = "temenos_throne_ch2",
    --Hikari and Agnea
    [2290650051] = "hikari_agnea_ch1",
    [2290650052] = "hikari_agnea_ch2",
    --Castti and Ochette
    [2290650053] = "castti_ochette_ch1",
    [2290650054] = "castti_ochette_ch2",
    --Osvald and Partitio
    [2290650055] = "osvald_partitio_ch1",
    [2290650056] = "osvald_partitio_ch2",
    --Jobs
    [2290649932] = "merchant_license",
    [2290649933] = "thief_license",
    [2290649934] = "warrior_license",
    [2290649935] = "hunter_license",
    [2290649936] = "cleric_license",
    [2290649937] = "dancer_license",
    [2290649938] = "scholar_license",
    [2290649939] = "apothecary_license",
    [2290649940] = "proof_of_armsmaster",
    [2290649941] = "proof_of_arcanist",
    [2290649942] = "proof_of_conjurer",
    [2290649943] = "proof_of_inventor",
}

local function set_all_active(value)
    for _, code in pairs(item_id_to_code) do
        local item = Tracker:FindObjectForCode(code)
        if item ~= nil then
            item.Active = value
        end
    end
end

local function set_code_active(code)
    local item = Tracker:FindObjectForCode(code)
    if item ~= nil then
        item.Active = true
    end
    --Active Osvald chapter 2 at the same time as his chapter 1
    if code == "osvald_ch1" then
        local ch2 = Tracker:FindObjectForCode("osvald_ch2")
        if ch2 ~= nil then
            ch2.Active = true
        end
    end
end

-- Check starting character selected in seed options
local starting_character = {
    [1] = {"osvald_unlock", "winterlands_unlock"},
    [2] = {"castti_unlock", "harborlands_unlock"},
    [3] = {"temenos_unlock", "crestlands_unlock"},
    [4] = {"ochette_unlock", "totohaha_unlock"},
    [5] = {"partitio_unlock", "wildlands_unlock"},
    [6] = {"agnea_unlock", "leaflands_unlock"},
    [7] = {"throne_unlock", "brightlands_unlock"},
    [8] = {"hikari_unlock", "hinoeuma_unlock"},
}
starting_character_id = nil
local difficulty = 1 -- normal by default

--Remaping Locations
local location_mapping = {
    --Roque Island
    ["Roque Island: Anchorage: 22000 L"] = "@Roque Island Anchorage/22000 L",
    ["Roque Island: Anchorage: Enlightening Necklace"] = "@Roque Island Anchorage/Enlightening Necklace",
    ["Roque Island: Anchorage: Healing Grape Bunch"] = "@Roque Island Anchorage/Healing Grape Bunch",
    --Ku Castle
    ["Castle Ku: Entrance: 1600 L"] = "@Castle Ku Entrance/1600 L",
    ["Castle Ku: Entrance: Critical Ring"] = "@Castle Ku Entrance/Critical Ring",
    --Flamechurch
    ["Flamechurch: Cathedral: Entrance: Shadow Soulstone"] = "@Flamechurch/Cathedral Entrance: Shadow Soulstone", --Need to find something to fix this (not the good location atm)
    ["Flamechurch: Cathedral: Olive of Life"] = "@Flamechurch Cathedral/Olive of Life",
    ["Flamechurch: Cathedral: Light Soulstone"] = "@Flamechurch Cathedral/Light Soulstone",
    ["Flamechurch: Cathedral: Angel's Ring"] = "@Flamechurch Cathedral/Angel's Ring",
    --Frigit
    ["Frigit Isle: Entrance: Healing Grape"] = "@Frigit Isle Entrance/Healing Grape",
    ["Frigit Isle: Anchorage: Magic Nut"] = "@Frigit Isle Anchorage/Magic Nut",
    ["Frigit Isle: Anchorage: Inspiriting Plum"] = "@Frigit Isle Anchorage/Inspiriting Plum",
    ["Frigit Isle: Anchorage: Ice Soulstone"] = "@Frigit Isle Anchorage/Ice Soulstone",
    --Canalbrine
    ["Canalbrine: Path to the Water Source: Darkdelion"] = "@Canalbrine Path to the Water Source/Darkdelion",
    ["Canalbrine: Path to the Water Source: Empowering Ring"] = "@Canalbrine Path to the Water Source/Empowering Ring",
    ["Canalbrine: Path to the Water Source: Plum Leaf"] = "@Canalbrine Path to the Water Source/Plum Leaf",
    ["Canalbrine: Path to the Water Source: Grape Leaf"] = "@Canalbrine Path to the Water Source/Grape Leaf",
    ["Canalbrine: Path to the Water Source: Guard's Helm"] = "@Canalbrine Path to the Water Source/Guard's Helm",
    ["Canalbrine: Path to the Water Source: Herb of Healing"] = "@Canalbrine Path to the Water Source/Herb of Healing",
    ["Canalbrine: Water Source: Diffusing Serum"] = "@Canalbrine Water Source/Diffusing Serum",
    ["Canalbrine: Water Source: Cleansing Leaf"] = "@Canalbrine Water Source/Cleansing Leaf",
    ["Canalbrine: Water Source: Old Armor"] = "@Canalbrine Water Source/Old Armor",
    ["Canalbrine: Water Source: Herb of Healing"] = "@Canalbrine Water Source/Herb of Healing",
    --Timberain
    ["Timberain Castle: Town Square: Wind Soulstone (L)"] = "@Timberain Castle Town Square/Wind Soulstone (L)",
    ["Timberain Castle: Town Square: Rusty Polearm"] = "@Timberain Castle Town Square/Rusty Polearm",
    --Sundering Sea
    --On the Water
    ["Sundering Sea: On the Water: Diffusing Serum"] = "@Sundering Sea On the Water/Diffusing Serum",
    ["Sundering Sea: On the Water: Gimmick Goggles"] = "@Sundering Sea On the Water/Gimmick Goggles",
    ["Sundering Sea: On the Water: Double Tomahawk"] = "@Sundering Sea On the Water/Double Tomahawk",
    ["Sundering Sea: On the Water: Fortune Wand"] = "@Sundering Sea On the Water/Fortune Wand",
    ["Sundering Sea: On the Water: Reinforcing Jam"] = "@Sundering Sea On the Water/Reinforcing Jam",
    ["Sundering Sea: On the Water: Leviathan Greatbow"] = "@Sundering Sea On the Water/Leviathan Greatbow",
    ["Sundering Sea: On the Water: Dual Flower"] = "@Sundering Sea On the Water/Dual Flower",
    ["Sundering Sea: On the Water: Sublime Ornamental Armor"] = "@Sundering Sea On the Water/Sublime Ornamental Armor",
    ["Sundering Sea: On the Water: Inspiriting Plum Basket"] = "@Sundering Sea On the Water/Inspiriting Plum Basket",
    ["Sundering Sea: On the Water: 20000 L"] = "@Sundering Sea On the Water/20000 L",
    ["Sundering Sea: On the Water: Beastly Scarf"] = "@Sundering Sea On the Water/Beastly Scarf",
    ["Sundering Sea: On the Water: Sunken Gold Statue"] = "@Sundering Sea On the Water/Sunken Gold Statue",
    ["Sundering Sea: On the Water: Olive of Life (L)"] = "@Sundering Sea On the Water/Olive of Life (L)",
    ["Sundering Sea: On the Water: Strengthening Serum"] = "@Sundering Sea On the Water/Strengthening Serum",
    ["Sundering Sea: On the Water: Dual Leaf"] = "@Sundering Sea On the Water/Dual Leaf",
    ["Sundering Sea: On the Water: Platinum Shield"] = "@Sundering Sea On the Water/Platinum Shield",
    ["Sundering Sea: On the Water: Invigorating Nut (L)"] = "@Sundering Sea On the Water/Invigorating Nut (L)",
    ["Sundering Sea: On the Water: Gold Nugget"] = "@Sundering Sea On the Water/Gold Nugget",
    ["Sundering Sea: On the Water: EXP Augmentor"] = "@Sundering Sea On the Water/EXP Augmentor",
    ["Sundering Sea: On the Water: Herb of Serenity"] = "@Sundering Sea On the Water/Herb of Serenity",
    --??? / Gate of Finis
    ["Sundering Sea: ???: Skystone"] = "@Sundering Sea ???/Skystone",
    ["Sundering Sea: ???: Dragon's Scarf"] = "@Sundering Sea ???/Dragon's Scarf",
    ["Sundering Sea: ???: Herb-of-Grace Bud 1"] = "@Sundering Sea ???/Herb-of-Grace Bud 1",
    ["Sundering Sea: ???: Herb-of-Grace Bud 2"] = "@Sundering Sea ???/Herb-of-Grace Bud 2",
    ["Sundering Sea: ???: Herb-of-Grace Bud 3"] = "@Sundering Sea ???/Herb-of-Grace Bud 3",
    --Lighthouse Island
    ["Sundering Sea: Lighthouse Island: Octopuff Pot"] = "@Sundering Sea Lighthouse Island/Octopuff Pot",
    ["Sundering Sea: Lighthouse Island: 12000 L"] = "@Sundering Sea Lighthouse Island/12000 L",
    --Nameless Island
    ["Sundering Sea: Nameless Isle: Conscious Stone"] = "@Sundering Sea Nameless Isle/Conscious Stone",
    ["Sundering Sea: Nameless Isle: Healing Grape Bunch"] = "@Sundering Sea Nameless Isle/Healing Grape Bunch",
    ["Sundering Sea: Nameless Isle: Quartz Axe"] = "@Sundering Sea Nameless Isle/Quartz Axe",
    ["Sundering Sea: Nameless Isle: Finisher's Claws"] = "@Sundering Sea Nameless Isle/Finisher's Claws",
    --The Lost Isle
    ["Sundering Sea: Nameless Isle: Ancient Cursed Talisman 1"] = "@Sundering Sea Nameless Isle/Ancient Cursed Talisman 1",
    ["Sundering Sea: Nameless Isle: Ancient Cursed Talisman 2"] = "@Sundering Sea Nameless Isle/Ancient Cursed Talisman 2",
    ["Sundering Sea: Nameless Isle: Ancient Cursed Talisman 3"] = "@Sundering Sea Nameless Isle/Ancient Cursed Talisman 3",
    ["Sundering Sea: Nameless Isle: Ancient Cursed Talisman 4"] = "@Sundering Sea Nameless Isle/Ancient Cursed Talisman 4",
    ["Sundering Sea: Nameless Isle: Blessing in Disguise"] = "@Sundering Sea Nameless Isle/Blessing in Disguise",
    ["Sundering Sea: Nameless Isle: Great Sage's Staff"] = "@Sundering Sea Nameless Isle/Great Sage's Staff",
    ["Sundering Sea: Nameless Isle: Lost Tribe's Dagger"] = "@Sundering Sea Nameless Isle/Lost Tribe's Dagger",
    --Shipwreck of the Empress
    ["Sundering Sea: Shipwreck of the Empress: Inspiriting Plum Basket"] = "@Sundering Sea Shipwreck of the Empress/Inspiriting Plum Basket",
    ["Sundering Sea: Shipwreck of the Empress: Thunder Soulstone (L)"] = "@Sundering Sea Shipwreck of the Empress/Thunder Soulstone (L)",
    ["Sundering Sea: Shipwreck of the Empress: Lost Tribe's Spear"] = "@Sundering Sea Shipwreck of the Empress/Lost Tribe's Spear",
    ["Sundering Sea: Shipwreck of the Empress: Cursed Shield"] = "@Sundering Sea Shipwreck of the Empress/Cursed Shield",
    ["Sundering Sea: Shipwreck of the Empress: Master Thief's Sapphire Stone"] = "@Sundering Sea Shipwreck of the Empress/Master Thief's Sapphire Stone",
    ["Sundering Sea: Shipwreck of the Empress: Rusty Dagger"] = "@Sundering Sea Shipwreck of the Empress/Rusty Dagger",
    --Curious Nest
    ["Sundering Sea: Curious Nest: Herb of Serenity"] = "@Sundering Sea Curious Nest/Herb of Serenity",
    ["Sundering Sea: Curious Nest: Lost Tribe's Bow"] = "@Sundering Sea Curious Nest/Lost Tribe's Bow",
    ["Sundering Sea: Curious Nest: Decaying Dragon's Essence 1"] = "@Sundering Sea Curious Nest/Decaying Dragon's Essence 1",
    ["Sundering Sea: Curious Nest: Fang of Ferocity"] = "@Sundering Sea Curious Nest/Fang of Ferocity",
    ["Sundering Sea: Curious Nest: Tornado Glaive"] = "@Sundering Sea Curious Nest/Tornado Glaive",
    ["Sundering Sea: Curious Nest: Decaying Dragon's Essence 2"] = "@Sundering Sea Curious Nest/Decaying Dragon's Essence 2",

}

--Have to split jobs ID in two cause 8 are numbers items in tracker and 4 are toggle items
local job_license_ids = {
    [2290649932] = true, -- Merchant
    [2290649933] = true, -- Thief
    [2290649934] = true, -- Warrior
    [2290649935] = true, -- Hunter
    [2290649936] = true, -- Cleric
    [2290649937] = true, -- Dancer
    [2290649938] = true, -- Scholar
    [2290649939] = true, -- Apothecary
}

local proof_ids = {
    [2290649940] = true, -- Armsmaster
    [2290649941] = true, -- Arcanist
    [2290649942] = true, -- Conjurer
    [2290649943] = true, -- Inventor
}

--Set starting info
Archipelago:AddClearHandler("OT2_Clear", function(slot_data)
    set_all_active(false)

    --Get difficulty
    difficulty = tonumber(slot_data["Difficulty"]) or 1

    local sc = tonumber(slot_data["StartingCharacter"])
    starting_character_id = sc
    if sc ~= nil and starting_character[sc] ~= nil then
        for _, code in ipairs(starting_character[sc]) do
            set_code_active(code)
        end
    end
end)

Archipelago:AddItemHandler("OT2_Items", function(index, item_id, item_name, player_number)
    --If the ID AP Item is among the 8 basic jobs, do +1 on tracker
    if job_license_ids[item_id] then
        local code = item_id_to_code[item_id]
        local item = Tracker:FindObjectForCode(code)
    
        if item ~= nil then
            item.AcquiredCount = math.min(item.AcquiredCount + 1, item.MaxCount)
        end
        return
    end
    --If the ID AP Item is among the 4 advanced jobs, put Active state on tracker
    if proof_ids[item_id] then
        local code = item_id_to_code[item_id]
        local item = Tracker:FindObjectForCode(code)
    
        if item ~= nil then
            item.Active = true
        end
        return
    end
    --If the ID AP Item is among the item id to code list, put Active state on tracker
    local code = item_id_to_code[item_id]
    if code ~= nil then
        set_code_active(code)
    end
end)

--Get check ID and verify which location it is and update check on poptracker
Archipelago:AddLocationHandler("OT2_Locations", function(location_id, location_name)

    local code = location_mapping[location_name]

    if code == nil then
        code = "@" .. location_name:gsub(": ", "/", 1)
    end

    local section = Tracker:FindObjectForCode(code)

    if section then
        section.AvailableChestCount = 0
        print("OT2: TROUVE -> " .. code)
    else
        print("OT2: INTROUVABLE -> " .. code)
    end
end)

--Check if Player has one of the characters that can KO NPCs
--Need to verify if Time Change Unlock is needed to unlock can_ko logic
function can_ko()
    return Tracker:FindObjectForCode("ochette_unlock").Active
        or Tracker:FindObjectForCode("throne_unlock").Active
        or Tracker:FindObjectForCode("hikari_unlock").Active
        or Tracker:FindObjectForCode("castti_unlock").Active
end

function can_getItem()
    return Tracker:FindObjectForCode("partitio_unlock").Active
        or Tracker:FindObjectForCode("throne_unlock").Active
        or Tracker:FindObjectForCode("agnea_unlock").Active
end

--Check if player can Ambush for some checks
function can_ambush()
    return Tracker:FindObjectForCode("throne_unlock").Active
        and Tracker:FindObjectForCode("time_change_unlock").Active
end

--Check if Player has access to towns
--Toto'haha Towns
--Beasting Village
function can_access_beasting()
    return Tracker:FindObjectForCode("ochette_unlock").Active
        and (Tracker:FindObjectForCode("totohaha_unlock").Active and Tracker:FindObjectForCode("ochette_ch1").Active)
        or (Tracker:FindObjectForCode("totohaha_unlock").Active and Tracker:FindObjectForCode("ochette_ch3").Active)
end
--Tropu'hopu
function can_access_tropuhopu()
    return Tracker:FindObjectForCode("totohaha_unlock").Active
        and((Tracker:FindObjectForCode("agnea_unlock").Active and Tracker:FindObjectForCode("agnea_ch3").Active)
            or (Tracker:FindObjectForCode("partitio_unlock").Active and Tracker:FindObjectForCode("partitio_scT").Active))
end
--Nameless Village
function can_access_nameless()
    return Tracker:FindObjectForCode("totohaha_unlock").Active
        and (Tracker:FindObjectForCode("boat_unlock").Active)
            and((Tracker:FindObjectForCode("temenos_unlock").Active and Tracker:FindObjectForCode("temenos_ch4").Active))
end

--Brightlands Towns
--New Delsta
function  can_access_newdelsta()
    return Tracker:FindObjectForCode("throne_unlock").Active
        and (Tracker:FindObjectForCode("brightlands_unlock").Active and Tracker:FindObjectForCode("throne_ch1").Active)
        or (Tracker:FindObjectForCode("brightlands_unlock").Active and Tracker:FindObjectForCode("throne_ch4").Active)
    or (Tracker:FindObjectForCode("agnea_unlock").Active and Tracker:FindObjectForCode("agnea_ch2").Active and Tracker:FindObjectForCode("brightlands_unlock").Active)
    or (Tracker:FindObjectForCode("osvald_unlock").Active
        and Tracker:FindObjectForCode("partitio_unlock").Active
        and Tracker:FindObjectForCode("osvald_partitio_ch1").Active
        and Tracker:FindObjectForCode("brightlands_unlock").Active)
end
--Abandonned Village
function can_access_abandonedvillage()
    return Tracker:FindObjectForCode("castti_unlock").Active
        and (Tracker:FindObjectForCode("castti_ch3").Active and Tracker:FindObjectForCode("brightlands_unlock").Active)
end
--Clockbank
function can_access_clockbank()
    return Tracker:FindObjectForCode("partitio_unlock").Active
        and (Tracker:FindObjectForCode("partitio_ch2").Active and Tracker:FindObjectForCode("brightlands_unlock").Active)
end
--Lostseed
function can_access_lostseed()
    return Tracker:FindObjectForCode("throne_unlock").Active
        and (Tracker:FindObjectForCode("throne_ch4").Active and Tracker:FindObjectForCode("brightlands_unlock").Active)
end

--Crestlands Towns
--Flamechurch
function can_access_flamechurch()
    return Tracker:FindObjectForCode("crestlands_unlock").Active
        and Tracker:FindObjectForCode("temenos_unlock").Active
        and Tracker:FindObjectForCode("temenos_ch1").Active
    or (Tracker:FindObjectForCode("temenos_unlock").Active
        and Tracker:FindObjectForCode("throne_unlock").Active
        and Tracker:FindObjectForCode("temenos_throne_ch1").Active
        and Tracker:FindObjectForCode("crestlands_unlock").Active)
end
--Montwise
function can_access_montwise()
    return Tracker:FindObjectForCode("throne_unlock").Active
        and (Tracker:FindObjectForCode("throne_ch3F").Active and Tracker:FindObjectForCode("crestlands_unlock").Active)
    or Tracker:FindObjectForCode("hikari_unlock").Active
        and (Tracker:FindObjectForCode("hikari_ch2").Active and Tracker:FindObjectForCode("crestlands_unlock").Active)
    or Tracker:FindObjectForCode("osvald_unlock").Active
        and (Tracker:FindObjectForCode("osvald_ch4").Active and Tracker:FindObjectForCode("crestlands_unlock").Active)
    or Tracker:FindObjectForCode("osvald_unlock").Active
        and (Tracker:FindObjectForCode("partitio_unlock").Active and Tracker:FindObjectForCode("osvald_partitio_ch2").Active and Tracker:FindObjectForCode("crestlands_unlock").Active)
end
--Merry Hills
function can_access_merryhills()
    return Tracker:FindObjectForCode("agnea_unlock").Active
        and (Tracker:FindObjectForCode("agnea_ch5").Active and Tracker:FindObjectForCode("crestlands_unlock").Active)
end

--Winterlands Towns
--Access Winterlands 2
function can_access_winterlands2()
    return Tracker:FindObjectForCode("winterlands_unlock").Active
        and Tracker:FindObjectForCode("crestlands_unlock").Active
        and (Tracker:FindObjectForCode("ochette_unlock").Active
            or Tracker:FindObjectForCode("throne_unlock").Active
            or Tracker:FindObjectForCode("hikari_unlock").Active
            or Tracker:FindObjectForCode("castti_unlock").Active)
end
--Frigit Isle
--Not sure about how Frigit is supposed to be
function can_access_frigit() 
    if starting_character_id == 1 then
        return true
    end

    return Tracker:FindObjectForCode("winterlands_unlock").Active
        and Tracker:FindObjectForCode("grand_terry_unlock").Active
        and Tracker:FindObjectForCode("osvald_unlock").Active
        and (Tracker:FindObjectForCode("osvald_ch1").Active and Tracker:FindObjectForCode("osvald_ch2").Active)
end
--Cape Cold
function can_access_capecold()
    return Tracker:FindObjectForCode("osvald_unlock").Active
        and Tracker:FindObjectForCode("osvald_ch1").Active
        and Tracker:FindObjectForCode("winterlands_unlock").Active
end
--Winterbloom
function can_access_winterbloom()
    return Tracker:FindObjectForCode("throne_unlock").Active
        and (Tracker:FindObjectForCode("throne_ch2F").Active and Tracker:FindObjectForCode("winterlands_unlock").Active)
    or Tracker:FindObjectForCode("castti_unlock").Active
        and (Tracker:FindObjectForCode("castti_ch2").Active and Tracker:FindObjectForCode("winterlands_unlock").Active)
    or Tracker:FindObjectForCode("partitio_unlock").Active
        and (Tracker:FindObjectForCode("partitio_scW").Active and Tracker:FindObjectForCode("winterlands_unlock").Active) 
end
--Stormhail
function can_access_stormhail()
    return Tracker:FindObjectForCode("ochette_unlock").Active
        and (Tracker:FindObjectForCode("ochette_ch2G").Active and Tracker:FindObjectForCode("winterlands_unlock").Active and can_access_winterlands2())
    or Tracker:FindObjectForCode("hikari_unlock").Active
        and (Tracker:FindObjectForCode("hikari_ch4").Active and Tracker:FindObjectForCode("winterlands_unlock").Active and can_access_winterlands2())
    or Tracker:FindObjectForCode("temenos_unlock").Active
        and (Tracker:FindObjectForCode("temenos_ch3S").Active and Tracker:FindObjectForCode("winterlands_unlock").Active and can_access_winterlands2())
end
--Infernal Castle access
function can_access_infernalcastle()
    return Tracker:FindObjectForCode("ochette_unlock").Active
        and (Tracker:FindObjectForCode("partitio_unlock").Active
        and Tracker:FindObjectForCode("temenos_unlock").Active
        and Tracker:FindObjectForCode("agnea_unlock").Active
        and can_access_winterlands2())
end

--Harborlands Towns
--Canalbrine
function can_access_canalbrine()
    return Tracker:FindObjectForCode("harborlands_unlock").Active
        and (Tracker:FindObjectForCode("castti_unlock").Active and Tracker:FindObjectForCode("castti_ch1").Active)
    or (Tracker:FindObjectForCode("temenos_unlock").Active and Tracker:FindObjectForCode("temenos_ch2").Active and Tracker:FindObjectForCode("harborlands_unlock").Active)
end
--Conning Creek
function can_access_conningcreek()
    return Tracker:FindObjectForCode("ochette_unlock").Active
        and (Tracker:FindObjectForCode("ochette_ch2A").Active and Tracker:FindObjectForCode("harborlands_unlock").Active)
    or Tracker:FindObjectForCode("osvald_unlock").Active
        and (Tracker:FindObjectForCode("osvald_ch3").Active and Tracker:FindObjectForCode("harborlands_unlock").Active)
    or Tracker:FindObjectForCode("throne_unlock").Active
        and (Tracker:FindObjectForCode("temenos_unlock").Active and Tracker:FindObjectForCode("temenos_throne_ch2").Active and Tracker:FindObjectForCode("harborlands_unlock").Active)
end
--Roque Island
--Supposed to have The Grand Terry to access but in the current .apworld (v0.5) it's in logic if you have Partitio and his chapter 4 even without The Grand Terry
function can_access_roqueisland()
    return Tracker:FindObjectForCode("partitio_unlock").Active
        and Tracker:FindObjectForCode("partitio_ch4").Active
end

--Hinoeuma Towns
--Ryu
function can_access_ryu()
    return (Tracker:FindObjectForCode("hikari_unlock").Active and Tracker:FindObjectForCode("hikari_ch1").Active and Tracker:FindObjectForCode("hinoeuma_unlock").Active)
    or Tracker:FindObjectForCode("hikari_unlock").Active
        and (Tracker:FindObjectForCode("agnea_unlock").Active and Tracker:FindObjectForCode("hikari_agnea_ch1").Active and Tracker:FindObjectForCode("hinoeuma_unlock").Active)
end
--Sai
function can_access_sai()
    return Tracker:FindObjectForCode("castti_unlock").Active
        and (Tracker:FindObjectForCode("castti_ch2S").Active and Tracker:FindObjectForCode("hinoeuma_unlock").Active)
    or Tracker:FindObjectForCode("agnea_unlock").Active
        and (Tracker:FindObjectForCode("agnea_ch4").Active and Tracker:FindObjectForCode("hinoeuma_unlock").Active)
    or Tracker:FindObjectForCode("partitio_unlock").Active
        and (Tracker:FindObjectForCode("partitio_scS").Active and Tracker:FindObjectForCode("hinoeuma_unlock").Active)
end
--Ku
function can_access_ku()
    return Tracker:FindObjectForCode("hikari_unlock").Active
        and (Tracker:FindObjectForCode("hikari_ch5").Active and Tracker:FindObjectForCode("hinoeuma_unlock").Active)
    or Tracker:FindObjectForCode("hikari_unlock").Active
        and (Tracker:FindObjectForCode("agnea_unlock").Active and Tracker:FindObjectForCode("hikari_agnea_ch2").Active and Tracker:FindObjectForCode("hinoeuma_unlock").Active)
end

--Wildlands Towns
--Oresrush
function can_access_oresrush()
    return (Tracker:FindObjectForCode("wildlands_unlock").Active and Tracker:FindObjectForCode("partitio_unlock").Active and Tracker:FindObjectForCode("partitio_ch1").Active)
    or (Tracker:FindObjectForCode("throne_unlock").Active and Tracker:FindObjectForCode("throne_ch2M").Active and Tracker:FindObjectForCode("wildlands_unlock").Active)
end
--Crackridge
function can_access_crackridge()
    return Tracker:FindObjectForCode("ochette_unlock").Active
        and (Tracker:FindObjectForCode("ochette_ch2T").Active and Tracker:FindObjectForCode("wildlands_unlock").Active)
    or Tracker:FindObjectForCode("temenos_unlock").Active
        and (Tracker:FindObjectForCode("temenos_ch3C").Active and Tracker:FindObjectForCode("wildlands_unlock").Active)
end
--Gravell
function can_access_gravell()
    return Tracker:FindObjectForCode("osvald_unlock").Active
        and (Tracker:FindObjectForCode("osvald_ch5").Active and Tracker:FindObjectForCode("wildlands_unlock").Active)
end

--Leaflands Towns
--Cropdale
function can_access_cropdale()
    return (Tracker:FindObjectForCode("agnea_unlock").Active and Tracker:FindObjectForCode("agnea_ch1").Active and Tracker:FindObjectForCode("leaflands_unlock").Active)
        or (Tracker:FindObjectForCode("ochette_unlock").Active and Tracker:FindObjectForCode("leaflands_unlock").Active and Tracker:FindObjectForCode("castti_unlock").Active and Tracker:FindObjectForCode("castti_ochette_ch1").Active)
        or (Tracker:FindObjectForCode("ochette_unlock").Active and Tracker:FindObjectForCode("leaflands_unlock").Active and Tracker:FindObjectForCode("castti_unlock").Active and Tracker:FindObjectForCode("castti_ochette_ch2").Active)
end
--Wellgrove
function can_access_wellgrove()
    return (Tracker:FindObjectForCode("throne_unlock").Active and Tracker:FindObjectForCode("throne_ch3M").Active and Tracker:FindObjectForCode("leaflands_unlock").Active)
        or (Tracker:FindObjectForCode("hikari_unlock").Active and Tracker:FindObjectForCode("hikari_ch3").Active and Tracker:FindObjectForCode("leaflands_unlock").Active)
        or (Tracker:FindObjectForCode("partitio_unlock").Active and Tracker:FindObjectForCode("partitio_ch3").Active and Tracker:FindObjectForCode("leaflands_unlock").Active)
end
--Timberain
function can_access_timberain()
    return Tracker:FindObjectForCode("leaflands_unlock").Active
        and (Tracker:FindObjectForCode("castti_unlock").Active and Tracker:FindObjectForCode("castti_ch4").Active)
end

--Difficulty access rules
local difficulty_requirements = {
    [0] = { -- Easy
        lvl20 = { characters = 8, regions = 6, jobs = 6 },
        lvl40 = { characters = 8, regions = 8, jobs = 12 }
    },

    [1] = { -- Normal
        lvl20 = { characters = 4, regions = 4, jobs = 4 },
        lvl40 = { characters = 4, regions = 4, jobs = 4 }
    },

    [2] = { -- Hard
        lvl20 = { characters = 2, regions = 2, jobs = 2 },
        lvl40 = { characters = 4, regions = 4, jobs = 4 }
    },

    [3] = { -- No Logic
        lvl20 = { characters = 1, regions = 1, jobs = 0 },
        lvl40 = { characters = 1, regions = 1, jobs = 0 }
    }
}

--List of characters for count unlocked function
local character_codes = {
    "agnea_unlock",
    "castti_unlock",
    "hikari_unlock",
    "osvald_unlock",
    "partitio_unlock",
    "temenos_unlock",
    "throne_unlock",
    "ochette_unlock"
}

function count_characters()
    local count = 0

    for _, code in ipairs(character_codes) do
        local item = Tracker:FindObjectForCode(code)

        if item ~= nil and item.Active then
            count = count + 1
        end
    end

    return count
end

--List of regions for count unlocked function
local region_codes = {
    "totohaha_unlock",
    "brightlands_unlock",
    "crestlands_unlock",
    "winterlands_unlock",
    "harborlands_unlock",
    "hinoeuma_unlock",
    "wildlands_unlock",
    "leaflands_unlock"
}

function count_regions()
    local count = 0

    for _, code in ipairs(region_codes) do
        local item = Tracker:FindObjectForCode(code)

        if item ~= nil and item.Active then
            count = count + 1
        end
    end

    return count
end

--Lists of jobs licenses and proof for count unlocked functions
local license_codes = {
    "merchant_license",
    "thief_license",
    "warrior_license",
    "hunter_license",
    "cleric_license",
    "dancer_license",
    "scholar_license",
    "apothecary_license"
}

local proof_codes = {
    "proof_of_armsmaster",
    "proof_of_arcanist",
    "proof_of_conjurer",
    "proof_of_inventor"
}

function count_jobs()
    local count = 0

    --Licenses count
    for _, code in ipairs(license_codes) do
        local item = Tracker:FindObjectForCode(code)

        if item ~= nil then
            count = count + item.AcquiredCount
        end
    end

    --Proofs count
    for _, code in ipairs(proof_codes) do
        local item = Tracker:FindObjectForCode(code)

        if item ~= nil and item.Active then
            count = count + 1
        end
    end

    return count
end

--Level 20+ access rule
function can_access_lvl20()
    local req = difficulty_requirements[difficulty].lvl20

    return count_characters() >= req.characters
        and count_regions() >= req.regions
        and count_jobs() >= req.jobs
end

--Lvl 40+ access rule
function can_access_lvl40()
    local req = difficulty_requirements[difficulty].lvl40

    return count_characters() >= req.characters
        and count_regions() >= req.regions
        and count_jobs() >= req.jobs
end
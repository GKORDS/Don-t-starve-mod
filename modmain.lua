local GLOBAL = GLOBAL

local INFINITE_VALUE = 999999

local function SetInfiniteFiniteUses(inst)
    local finiteuses = inst.components.finiteuses
    if finiteuses ~= nil then
        finiteuses:SetMaxUses(INFINITE_VALUE)
        finiteuses:SetUses(INFINITE_VALUE)
        finiteuses:SetOnFinished(nil)
    end
end

local function SetInfiniteFueled(inst)
    local fueled = inst.components.fueled
    if fueled ~= nil then
        fueled:InitializeFuelLevel(INFINITE_VALUE)
        fueled:DoDelta(INFINITE_VALUE)
        fueled.rate = 0
    end
end

local function SetInfiniteWorkable(inst)
    local workable = inst.components.workable
    if workable ~= nil and workable.workleft ~= nil then
        workable:SetWorkLeft(INFINITE_VALUE)
    end
end

local function SetInfiniteHealth(inst)
    local health = inst.components.health
    if health ~= nil then
        health:SetMaxHealth(INFINITE_VALUE)
        health:SetPercent(1)
    end
end

local function BuffRemote(inst)
    if not GLOBAL.TheWorld.ismastersim then
        return inst
    end

    SetInfiniteFiniteUses(inst)
    SetInfiniteFueled(inst)
    SetInfiniteWorkable(inst)
    SetInfiniteHealth(inst)

    return inst
end

local function BuffCatapult(inst)
    if not GLOBAL.TheWorld.ismastersim then
        return inst
    end

    SetInfiniteFiniteUses(inst)
    SetInfiniteFueled(inst)
    SetInfiniteWorkable(inst)
    SetInfiniteHealth(inst)

    return inst
end

AddPrefabPostInit("winona_remote", BuffRemote)
AddPrefabPostInit("winona_catapult", BuffCatapult)

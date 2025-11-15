local GLOBAL = GLOBAL

local INFINITE_VALUE = 999999
local INFINITE_RANGE = 999999

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

local function BuffRemote(inst)
    local aoetargeting = inst.components.aoetargeting
    if aoetargeting ~= nil then
        if aoetargeting.SetRange ~= nil then
            aoetargeting:SetRange(INFINITE_RANGE)
        else
            aoetargeting.range = INFINITE_RANGE
        end

        if aoetargeting.reticule ~= nil then
            aoetargeting.reticule.range = INFINITE_RANGE
            aoetargeting.reticule.radius = INFINITE_RANGE
        end
    end

    local reticule = inst.components.reticule
    if reticule ~= nil then
        reticule.range = INFINITE_RANGE
        reticule.radius = INFINITE_RANGE
    end

    if inst.replica ~= nil then
        local replica_aoe = inst.replica.aoetargeting
        if replica_aoe ~= nil then
            if replica_aoe.SetRange ~= nil then
                replica_aoe:SetRange(INFINITE_RANGE)
            else
                replica_aoe.range = INFINITE_RANGE
            end
        end

        local replica_reticule = inst.replica.reticule
        if replica_reticule ~= nil then
            if replica_reticule.SetRange ~= nil then
                replica_reticule:SetRange(INFINITE_RANGE)
            else
                replica_reticule.range = INFINITE_RANGE
            end
        end
    end

    if not GLOBAL.TheWorld.ismastersim then
        return inst
    end

    SetInfiniteFiniteUses(inst)
    SetInfiniteFueled(inst)
    SetInfiniteWorkable(inst)

    return inst
end

local function BuffCatapult(inst)
    if not GLOBAL.TheWorld.ismastersim then
        return inst
    end

    SetInfiniteFiniteUses(inst)
    SetInfiniteFueled(inst)
    SetInfiniteWorkable(inst)

    local combat = inst.components.combat
    if combat ~= nil then
        if combat.SetRange ~= nil then
            combat:SetRange(INFINITE_RANGE)
        else
            combat.attackrange = INFINITE_RANGE
        end
    end

    local weapon = inst.components.weapon
    if weapon ~= nil then
        if weapon.SetRange ~= nil then
            weapon:SetRange(INFINITE_RANGE)
        else
            weapon.attackrange = INFINITE_RANGE
            weapon.hitrange = INFINITE_RANGE
        end
    end

    local turret = inst.components.turret
    if turret ~= nil then
        if turret.SetRange ~= nil then
            turret:SetRange(INFINITE_RANGE)
        end
        turret.attackrange = INFINITE_RANGE
        turret.projectile_range = INFINITE_RANGE
    end

    return inst
end

AddPrefabPostInit("winona_remote", BuffRemote)
AddPrefabPostInit("winona_catapult", BuffCatapult)

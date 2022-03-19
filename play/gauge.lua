local src = {}

local img_pos = {
    w = 7, h = 28,
    x = {r = 0, b = 7, y = 14},
    y = {on = 0, off = 28},
}

local gauge_colors = {"r", "b", "y"}
local gauge_states = {"on", "off"} 
for _, c in ipairs(gauge_colors) do
    for _, s in ipairs(gauge_states) do
        table.insert(src,{
            id = "gauge-"..c.."-"..s,
            src = "gauge",
            x = img_pos.x[c],
            y = img_pos.y[s],
            w = img_pos.w,
            h = img_pos.h
        })
    end
end

local gauge_types = {"assist", "easy", "normal", "hard", "exh", "hazard"}
local color_sets = { -- {clear_color, fail_color}
    assist = {"y", "b"},
    easy = {"y", "b"},
    normal = {"r", "b"},
    hard = {"r", "b"}, -- ハード以上はfail_color関係なし
    exh = {"y", "b"},
    hazard = {"y", "b"}
}
local state_sets = {"on", "off", "on"}
local nodes = {}
for _, t in ipairs(gauge_types) do
    for _, s in ipairs(state_sets) do
        for _, c in ipairs(color_sets[t]) do
            table.insert(nodes, "gauge-"..c.."-"..s)
        end
    end
end

return {
    src = src,
    set = {id = "gauge", nodes = nodes},
    dst = {id = "gauge", dst = {{time = 0, x = geometry.gauge_x, y = 96, w = geometry.gauge_w, h = 51}}}
}


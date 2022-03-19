local num_src={
    n = {
        x = 0, w = 12, h = 18,
        y = {b = 43, w = 62, r = 81}
    },

    b = {
        x = 0, w = 34, h = 20,
        y = {b = 0, w = 22}
    },

    p = {
        x = 0, w = 28, h = 19,
        y = {w = 0}
    },
    j = {
        x = 153, w = 37, h = 56,
        y = {pg = 0, y = 168}
    }
}
local function value_resource(id, src_name, col, divx, digit, ref, padding, divy, cycle)
    padding = padding or 0
    divy = divy or 1
    cycle = cycle or 0
    local src = "ec_num"
    if src_name == "p" then
        src = "ec_num_p"
    elseif src_name == "j" then
        src = "ec_obj"
    end
    local pos = num_src[src_name]
    return {
        id = id,
        src = src,
        x = pos.x,
        y = pos.y[col],
        w = pos.w * divx,
        h = pos.h * divy,
        divx = divx,
        digit = digit,
        ref = ref,
        padding = padding,
        divy = divy,
        cycle = cycle
    }
end

local values = {
	-- value_resource(id, src_name, color, divx, digit, ref, padding=0, divy=1, cycle=0)
	-- bpm indicator
	value_resource("minbpm", "p", "w", 11, 4, 91),
	value_resource("nowbpm", "p", "w", 11, 4, 160),
	value_resource("maxbpm", "p", "w", 11, 4, 90),
	-- time left
	value_resource("timeleft-m", "n", "w", 10, 2, 163),
	value_resource("timeleft-s", "n", "w", 10, 2, 164, 1),
	-- hi-speed
	value_resource("hispeed", "n", "w", 10, 2, 310),
	value_resource("hispeed-d", "n", "w", 10, 2, 311, 1),
	-- ?
	value_resource("duration", "n", "w", 10, 4, 312),
	-- gauge
	value_resource("gaugevalue", "p", "w", 10, 3, 107),
	value_resource("gaugevalue-d", "p", "w", 10, 1, 407),
	-- score rate
	value_resource("scorerate", "n", "w", 10, 3, 102),
	value_resource("scorerate-d", "n", "w", 10, 2, 103, 1),
    -- score value
	value_resource("currentscore", "p", "w", 10, 5, 71),
	value_resource("bestscore", "p", "w", 10, 5, 150),
	value_resource("targetscore", "p", "w", 10, 5, 121),
	-- notes
	value_resource("totalnotes", "n", "w", 10, 5, 106),
	-- lanecover
	value_resource("lanecover-value", "n", "w", 10, 3, 14),
	value_resource("lanecover-duration", "n", "w", 10, 4, 312),
	--lift
	value_resource("liftcover-value", "n", "w", 10, 3, 314),
	--value_resource("liftcover-duration", "n", "w", 10, 4, 312),
	-- combo
	value_resource("combo-pg", "j", "pg", 10, 6, 75, 0, 3, 100),
	value_resource("combo-gr", "j", "y", 10, 6, 75),
    value_resource("combo-gd", "j", "y", 10, 6, 75),
}

-- judge counts(total/early/late)
local timings = { "", "-e", "-l" }

local function value_jc(j, t)
    if j <= 5 then
        if t == 1 then
            return 109 + j
        else
            return 410 + (j - 1)*2 + (t - 2)
        end
    else -- empty-poor
        return 420 + (t - 1)
    end
end

local function judge_count_sources()
    local jc_src = {}
    local color = {"w", "b", "r"}
    for i, judge in ipairs(judges) do
        for k, timing in ipairs(timings) do
            table.insert(jc_src, value_resource("judge-count-"..judge..timing, "n", color[k], 10, 4, value_jc(i, k)))
        end
    end
    return jc_src
end 
append_all(values, judge_count_sources())

local function dst(id, x, y, src_type, scale, aspect, ops, offset)
    scale = scale or 1
    aspect = aspect or 1
    local dst_obj = {
        id = id,
        dst = {
            {
                x = x,
                y = y,
                w = num_src[src_type].w * scale,
               h = num_src[src_type].h * scale * aspect
            }
        }
    }
    if ops then
        dst_obj.op = ops
    end
    if offset then
        dst_obj.offset = offset
    end
    return dst_obj
end

local function judge_count_destinations(pos_x, pos_y, ops, offset)
    local jc_dst = {}
    for y, j in ipairs(judges) do
        for x, t in ipairs(timings) do
            table.insert(
                jc_dst,
                dst(
                    "judge-count-"..j..t, 
                    pos_x + (x - 1) * 60,
                    pos_y + 90 - (y - 1) * 18,
                    "n",
                    1, 1,
                    ops,
                    offset
                )
            )
        end
    end
    return jc_dst
end

local destination = {
    dst("minbpm", 345, 10, "p"),
    dst("nowbpm", 480, 10, "p"),
    dst("maxbpm", 614, 10, "p"),
    dst("timeleft-m", 300, 160, "n", 1.5),
    dst("timeleft-s", 350, 160, "n", 1.5),
    dst("hispeed", 625, 60, "n", 1.5),
    dst("hispeed-d", 670, 60, "n", 1.5),
    dst("currentscore", 1000, 1000, "p", 1),
    dst("targetscore", 1000, 965, "p", 1),
    dst("totalnotes", 980, 120, "n", 1.5),
    dst("gaugevalue", geometry.gaugevalue_x, 180, "p", 1.6, 1.5),
    dst("scorerate", 180, 206, "n", 1.5),
    dst("scorerate-d", 244, 206, "n", 1.5),
    dst("lanecover-value", geometry.lanes_x + geometry.lanes_w / 3, geometry.resolution.y - 27, "n", 1.5, 1, {270}, 4),
    dst("liftcover-value", geometry.lanes_x + geometry.lanes_w / 3, geometry.judge_line_y + 6, "n", 1.5, 1, {270}, 3),
    dst("lanecover-duration", geometry.lanes_x + geometry.lanes_w * 2 / 3, geometry.resolution.y - 27, "n", 1.5, 1, {270}, 4),
    dst("lanecover-duration", geometry.lanes_x + geometry.lanes_w * 2 / 3, geometry.judge_line_y + 6, "n", 1.5, 1, {270}, 3),
}
append_all(destination, judge_count_destinations(geometry.judgecount_x, geometry.judgecount_y, {906}, 42))

return {
    src = values,
    dst = destination
}
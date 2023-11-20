local function main(play_type)

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
    },
    l = {
        x = 144, w = 18, h = 27,
        y = {w = 43}
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
    value_resource("timeleft-m", "l", "w", 10, 2, 163),
    value_resource("timeleft-s", "l", "w", 10, 2, 164, 1),
    -- hi-speed
    value_resource("hispeed", "l", "w", 10, 2, 310),
    value_resource("hispeed-d", "l", "w", 10, 2, 311, 1),
    -- ?
    value_resource("duration", "l", "w", 10, 4, 312),
    -- gauge
    value_resource("gaugevalue", "p", "w", 10, 3, 107),
    value_resource("gaugevalue-d", "p", "w", 10, 1, 407),
    -- score rate
    value_resource("scorerate", "l", "w", 10, 3, 102),
    value_resource("scorerate-d", "l", "w", 10, 2, 103, 1),
    -- score value
    value_resource("currentscore", "p", "w", 10, 5, 71),
    value_resource("bestscore", "p", "w", 10, 5, 150),
    value_resource("targetscore", "p", "w", 10, 5, 121),
    -- notes
    value_resource("totalnotes", "l", "w", 10, 5, 106),
    -- judge timing
    value_resource("judgetiming", "l", "w", 12, 4, 12, 0, 2),
    -- lanecover
    value_resource("lanecover-value", "l", "w", 10, 3, 14),
    value_resource("lanecover-duration", "l", "w", 10, 4, 312),
    --lift
    value_resource("liftcover-value", "l", "w", 10, 3, 314),
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
    dst("minbpm", geometry.minbpm_x, geometry.bpm_y, "p"),
    dst("nowbpm", geometry.nowbpm_x, geometry.bpm_y, "p"),
    dst("maxbpm", geometry.maxbpm_x, geometry.bpm_y, "p"),
    dst("timeleft-m", geometry.timeleft_m_x, geometry.timeleft_y, "l"),
    dst("timeleft-s", geometry.timeleft_s_x, geometry.timeleft_y, "l"),
    dst("hispeed",  geometry.hispeed_x, geometry.hispeed_y, "l"),
    dst("hispeed-d", geometry.hispeed_d_x, geometry.hispeed_y, "l"),
    dst("currentscore", geometry.currentscore_x, geometry.currentscore_y, "p", 1),
    dst("targetscore", geometry.targetscore_x, geometry.targetscore_y, "p", 1),
    dst("totalnotes", geometry.totalnotes_x, geometry.totalnotes_y, "l"),
    dst("judgetiming", geometry.judgetiming_x, geometry.judgetiming_y, "l"),
    dst("gaugevalue", geometry.gaugevalue_x, geometry.gaugevalue_y, "p", 1.6, 1.5),
    dst("scorerate", geometry.scorerate_x, geometry.scorerate_y, "l"),
    dst("scorerate-d", geometry.scorerate_d_x, geometry.scorerate_y, "l"),
}

local function set_lanecover_dst(x)
    append_all(destination, {
        dst("lanecover-value", x + geometry.lanes_w / 3, geometry.resolution.y - 27, "l", 1, 1, {270}, 4),
        dst("liftcover-value", x + geometry.lanes_w / 3, geometry.judge_line_y + 6, "l", 1, 1, {270}, 3),
        dst("lanecover-duration", x + geometry.lanes_w * 2 / 3, geometry.resolution.y - 27, "l", 1, 1, {270}, 4),
        dst("lanecover-duration", x + geometry.lanes_w * 2 / 3, geometry.judge_line_y + 6, "l", 1, 1, {270}, 3),
    })
end

if play_type == "single" then
    set_lanecover_dst(geometry.lanes_x)
else
    set_lanecover_dst(geometry.lanes_x.left)
    set_lanecover_dst(geometry.lanes_x.right)
end

append_all(destination, judge_count_destinations(geometry.judgecount_x, geometry.judgecount_y, {906}, 42))

return {
    src = values,
    dst = destination
}
end

return main
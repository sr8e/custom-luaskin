-- general table manipulation
function append_all(list, list1)
    for i, v in ipairs(list1) do
        table.insert(list, v)
    end
end

-- play options
function is_left_side()
    return skin_config.option["Play Side"] == 920
end

function is_right_side()
    return skin_config.option["Play Side"] == 921
end

function is_left_scratch()
    return skin_config.option["Scratch Side"] == 922
end

function is_right_scratch()
    return skin_config.option["Scratch Side"] == 923
end

function is_score_graph_enabled()
    return skin_config.option["Score Graph"] == 901
end

function is_judge_count_enabled()
    return skin_config.option["Judge Count"] == 906
end

function is_judge_detail_early_late()
    return skin_config.option["Judge Detail"] == 911
end


-- timers
function timer_key_bomb(index)
    if index < 8 then
        return 50 + index
    elseif index == 8 then
        return 50
    elseif index < 16 then
        return 60 + index - 8
    elseif index == 16 then
        return 60
    end
end

function timer_key_hold(index)
    if index < 8 then
        return 70 + index
    elseif index == 8 then
        return 70
    elseif index < 16 then
        return 80 + index - 8
    elseif index == 16 then
        return 80
    end
end

function timer_key_on(index)
    if index < 8 then
        return 100 + index
    elseif index == 8 then
        return 100
    elseif index < 16 then
        return 110 + index - 8
    elseif index == 16 then
        return 110
    end
end

function timer_key_off(index)
    if index < 8 then
        return 120 + index
    elseif index == 8 then
        return 120
    elseif index < 16 then
        return 130 + index - 8
    elseif index == 16 then
        return 130
    end
end

function value_judge(index)
    if index < 8 then
        return 500 + index
    elseif index == 8 then
        return 500
    elseif index < 16 then
        return 510 + index - 8
    elseif index == 16 then
        return 510
    end
end

local property = {
    {name = "Play Side", item = {
        {name = "1P", op = 920},
        {name = "2P", op = 921}
    }},
    {name = "Scratch Side", item = {
        {name = "Left", op = 922},
        {name = "Right", op = 923}
    }},
    {name = "Score Graph", item = {
        {name = "Off", op = 900},
        {name = "On", op = 901}
    }},
    {name = "Judge Count", item = {
        {name = "Off", op = 905},
        {name = "On", op = 906}
    }},
    {name = "Judge Detail", item = {
        {name = "Off", op = 910},
        {name = "EARLY/LATE", op = 911}
    }}
}

local filepath = {
    {name = "Background", path = "background/*.png"},
    {name = "Note", path = "notes/*.png"},
    {name = "Bomb", path = "bomb/*.png"},
    {name = "Laser", path = "laser/*.png"},
    {name = "Lanecover", path = "lanecover/*.png"},
}

local offset = {
    {name = "Laser Offset", id = 40, x = false, y = false, w = false, h = true, r = false, a = true},
    {name = "Bomb Offset", id = 41, x = true, y = true, w = true, h = true, r = false, a = true},
    {name = "Judge Count Offset", id = 42, x = true, y = true, w = false, h = false, r = false, a = true},
    {name = "BGA Offset", id = 43, x = true, y = true, w = true, h = true, r = false, a = true},
    {name = "Lane Background Offset", id = 44, x = false, y = false, w = false, h = false, r = false, a = true},
}

local header = {
    type = 0,
    name = "sr/custom",
    w = 1920,
    h = 1080,
    playstart = 1000,
    scene = 3600000,
    input = 500,
    close = 1500,
    fadeout = 1000,
    property = property,
    filepath = filepath,
    offset = offset
}


note_colors = {"w", "b", "s"}
key_wbs = { 0, 1, 0, 1, 0, 1, 0, 2 }
function get_key_wbs(i)
    return key_wbs[(i - 1) % 8 + 1]
end

judges = {"pg", "gr", "gd", "bd", "pr", "ms"}

local function main()

    local skin = {}
    for k, v in pairs(header) do
        skin[k] = v
    end

    geometry = require("play7geometry")

    skin.source = {
        {id = 0, path = "../system.png"},
        {id = "bg", path = "resource_ec/MANIAC.png"},
        {id = 2, path = "../playbg.png"},
        {id = "gauge", path = "resource_ec/gauge.png"},
        {id = 5, path = "../number.png"},
        {id = "keybeam", path = "laser/*.png"},
        {id = "notes", path = "notes/*.png"},
        {id = 8, path = "../close.png"},
        {id = 9, path = "../scoregraph.png"},
        {id = "bomb", path = "bomb/*.png"},
        {id = 11, path = "../ready.png"},
        {id = 12, path = "lanecover/*.png"},
        {id = 13, path = "../judgedetail.png"},
        {id = "ec_obj", path = "resource_ec/DEFAULT.png"},
        {id = "lanebg", path = "resource_ec/lanebg.png"},
        {id = "ec_num", path = "resource_ec/num.png"},
        {id = "ec_num_p", path = "resource_ec/P.png"},
        {id = "judgeline", path = "resource_custom/judgeline.png"},
        {id = "ec_graph", path = "resource_ec/Graph.png"},
        {id = "autoplay", path = "resource_custom/autoplay.png"},
    }
    skin.font = {
        {id = 0, path = "../VL-Gothic-Regular.ttf"}
    }


    skin.image = {
        {id = "background", src = "bg", x = 0, y = 0, w = 1280, h = 720},
        {id = 1, src = 2, x = 0, y = 0, w = 1280, h = 720},
        {id = "ready", src = 11, x = 0, y = 0, w = 216, h = 40},
        {id = 7, src = 0, x = 0, y = 0, w = 8, h = 8},
        {id = "close1", src = 8, x = 0, y = 500, w = 640, h = 240},
        {id = "close2", src = 8, x = 0, y = 740, w = 640, h = 240},
        {id = "lane-bg", src = "lanebg", x = 0, y = 0, w = 639, h = 100},
        {id = 13, src = 0, x = 10, y = 10, w = 10, h = 251},
        {id = 15, src = "judgeline", x = 0, y = 0, w = 6, h = 6},
        {id = "autoplay", src = "autoplay", x = 0, y = 0, w = 300, h = 56},
        {id = "replay", src = "autoplay", x = 0, y = 56, w = 300, h = 56},

        {id = "judge-early", src = 13, x = 0, y = 0, w = 50, h = 20},
        {id = "judge-late", src = 13, x = 50, y = 0, w = 50, h = 20}
    }

    local notes_main = require("notes")
    local notes = notes_main("single")
    append_all(skin.image, notes.src)

    skin.note = notes.dst


    local bb_main = require("bomb_beam")
    local bb = bb_main("single")
    append_all(skin.image, bb.src)
    skin.imageset = bb.set


    -- values
    local values_main = require("values")
    local values = values_main("single")
    skin.value = values.src

    -- judge
    local judge_main = require("judge")
    local judge = judge_main("single")
    append_all(skin.image, judge.src)

    skin.judge = judge.dst


    --gauge
    local gauge = require("gauge")
    append_all(skin.image, gauge.src)
    skin.gauge = gauge.set


    skin.text = {
        {id = "song-title", font = 0, size = 24, align = geometry.title_align, ref = 12}
    }
    skin.slider = {
        {id = "musicprogress", src = 0, x = 0, y = 289, w = 14, h = 20, angle = 2, range = geometry.progress_h - 20,type = 6},
        {id = "musicprogress-fin", src = 0, x = 15, y = 289, w = 14, h = 20, angle = 2, range = geometry.progress_h - 20,type = 6},
        {id = "lanecover", src = 12, x = 0, y = 0, w = 390, h = 580, angle = 2, range = geometry.notes_area_h, type = 4}
    }
    skin.hiddenCover = {
        {id = "hidden-cover", src = 12, x = 0, y = 0, w = 390, h = 580, disapearLine = geometry.judge_line_y, isDisapearLineLinkLift = true}
    }
    skin.liftCover = {
        {id = "lift-cover", src = 12, x = 0, y = 0, w = 390, h = 655, disapearLine = geometry.judge_line_y}
    }
    skin.graph = {
        {id = "graph-now", src = "ec_graph", x = 0, y = 0, w = 896, h = 449, divx=896, cycle=10000, type = 110},
        {id = "graph-best", src = "ec_graph", x = 0, y = 449, w = 896, h = 449, divx=896, cycle=10000,  type = 112},
        {id = "graph-target", src = "ec_graph", x = 0, y = 998, w = 896, h = 449, divx=896, cycle=10000,  type = 114},
        {id = "load-progress", src = 0, x = 0, y = 0, w = 8, h = 8, angle = 0, type = 102}
    }


    skin.bga = {
        id = "bga"
    }
    skin.judgegraph = {
        {id = "judgegraph", type = 1, backTexOff = 1}
    }
    skin.bpmgraph = {
        {id = "bpmgraph"}
    }
    skin.timingvisualizer = {
        {id = "timing"}
    }
    skin.destination = {
        {id = "background", dst = {
            {x = 0, y = 0, w = geometry.resolution.x, h = geometry.resolution.y}
        }},--[[
        {id = 1, dst = {
            {x = 0, y = 0, w = 1280, h = 720}
        }},
        ]]

        {id = 13, dst = {
            {x = geometry.progress_x + 2, y = geometry.progress_y, w = geometry.progress_w - 4, h = geometry.progress_h}
        }},

        {id = "lane-bg", loop = 1000, offset = 44, dst = {
            {time = 0, x = geometry.lanebg_x, y = 251, w = geometry.lanebg_w, h = 0, a = 0},
            {time = 1000, h = 828, a = 255}
        }},
    }
    append_all(skin.destination, values.dst)

    table.insert(skin.destination, {id = 15, offset = 3, dst = { {x = geometry.lanes_x, y = geometry.judge_line_y, w = geometry.lanes_w, h = 6} }}) --判定線
    table.insert(skin.destination, {id = "notes", offset=30})

    append_all(skin.destination, judge.ids)

    append_all(skin.destination, {
        {id = "judge-early", loop = -1, timer = 46 ,op = {911,1242},offsets = {3, 33}, dst = {
            {time = 0, x = geometry.judgedetail_x, y = geometry.judgedetail_y, w = 50, h = 20},
            {time = 500}
        }},
        {id = "judge-late", loop = -1, timer = 46 ,op = {911,1243},offsets = {3, 33}, dst = {
            {time = 0, x = geometry.judgedetail_x, y = geometry.judgedetail_y, w = 50, h = 20},
            {time = 500}
        }},
        {id = "hidden-cover", dst = {
            {x = geometry.lanes_x, y = -440, w = geometry.lanes_w, h = 580}
        }},
        {id = "lanecover", dst = {
            {x = geometry.lanes_x, y = 1080, w = geometry.lanes_w, h = notes_area_h}
        }},
        {
            id = "lift-cover", dst = {
                {x = geometry.lanes_x, y = geometry.judge_line_y - 1073, w = geometry.lanes_w, h = 1073}
            }
        },
        {
            id = "autoplay",
            op = {33}, -- OPTION_AUTOPLAYON
            offset = 3, -- lift ofs
            dst = {
                {
                    x = geometry.lanes_x + geometry.lanes_w / 2 - 150,
                    y = geometry.autoplay_y,
                    w = 300,
                    h = 56,
                }
            },
        },
        {
            id = "replay",
            op = {84}, -- OPTION_REPLAY_PLAYING
            offset = 3, -- lift ofs
            dst = {
                {
                    x = geometry.lanes_x + geometry.lanes_w / 2 - 150,
                    y = geometry.autoplay_y,
                    w = 300,
                    h = 56,
                }
            },
        },
    })
    append_all(skin.destination, bb.dst)
    table.insert(skin.destination, gauge.dst)

    append_all(skin.destination, {
        {id = "bga", offset = 43, dst = {
            {time = 0, x = geometry.bga_x, y = geometry.bga_y, w = geometry.bga_w, h = geometry.bga_h}
        }},
        {id = "judgegraph", dst = {
            {time = 0, x = geometry.judgegraph_x, y = geometry.judgegraph_y, w = geometry.judgegraph_w, h = geometry.judgegraph_h}
        }},
        {id = "bpmgraph", dst = {
            {time = 0, x = geometry.judgegraph_x, y = geometry.judgegraph_y, w = geometry.judgegraph_w, h = geometry.judgegraph_h}
        }},
        {id = "timing", dst = {
            {time = 0, x = geometry.timing_x, y = geometry.timing_y, w = geometry.timing_w, h = geometry.timing_h}
        }},
        {id = "song-title", dst = {
            {time = 0, x = geometry.title_x, y = geometry.title_y, w = 24, h = 24},
            {time = 1000, a = 0},
            {time = 2000, a = 255}
        }},
        --{id = 11, op = {901},dst = {
        --    {x = geometry.graph_x, y = geometry.graph_y, w = geometry.graph_w, h = geometry.graph_h}
        --}},
        {id = "graph-now", op = {901},dst = {
            {x = geometry.graph_x + 1, y = geometry.graph_y, w = geometry.graph_w / 3 - 2, h = geometry.graph_h}
        }},
        {id = "graph-best", op = {901},dst = {
            {x = geometry.graph_x + geometry.graph_w / 3 + 1, y = geometry.graph_y, w = geometry.graph_w / 3 - 2, h = geometry.graph_h}
        }},
        {id = "graph-target", op = {901},dst = {
            {x = geometry.graph_x + geometry.graph_w * 2 / 3 + 1, y = geometry.graph_y, w = geometry.graph_w / 3 - 2, h = geometry.graph_h}
        }},
        --{id = 12, op = {901},dst = {
        --    {x = geometry.graph_x, y = geometry.graph_y, w = geometry.graph_w, h = geometry.graph_h}
        --}},

        {id = 422, op = {901},dst = {
            {x = 1012, y = 995, w = 28, h = 19}
        }},
        --{id = 423, op = {901},dst = {
        --    {x = geometry.graph_x + 10, y = 160, w = 12, h = 18}
        --}},
        {id = 424, op = {901},dst = {
            {x = 1012, y = 964, w = 28, h = 19}
        }},
        {id = "musicprogress", blend = 2, dst = {
            {x = geometry.progress_x, y = geometry.progress_y + geometry.progress_h - 20, w = geometry.progress_w, h = 20}
        }},
        {id = "musicprogress-fin", blend = 2, timer = 143,dst = {
            {x = geometry.progress_x, y = geometry.progress_y + geometry.progress_h - 20, w = geometry.progress_w, h = 20}
        }},
    })

    append_all(skin.destination, {
        {id = "load-progress", loop = 0, op = {80}, dst = {
            {time = 0, x = geometry.lanes_x, y = 440, w = geometry.lanes_w, h = 4},
            {time = 500, a = 192, r = 0},
            {time = 1000, a = 128, r = 255, g = 0},
            {time = 1500, a = 192, g = 255, b = 0},
            {time = 2000, a = 255, b = 255}
        }},

        {id = "ready", loop = -1, timer = 40, dst = {
            {time = 0, x = geometry.ready_x, y = 400, w = 350, h = 60, a = 0},
            {time = 750, y = 450, a = 255},
            {time = 1000}
        }},

        {id = "close2", loop = 700, timer = 3, dst = {
            {time = 0, x = 0, y = - geometry.resolution.y / 2, w = geometry.resolution.x, h = geometry.resolution.y / 2},
            {time = 500, y = 0},
            {time = 600, y = -40},
            {time = 700, y = 0}
        }},
        {id = "close1", loop = 700, timer = 3, dst = { -- ハード落ちタイマー
            {time = 0, x = 0, y = geometry.resolution.y, w = geometry.resolution.x, h = geometry.resolution.y / 2},
            {time = 500, y = geometry.resolution.y / 2},
            {time = 600, y = geometry.resolution.y / 2 + 40},
            {time = 700, y = geometry.resolution.y / 2}
        }},

        {id = 7, loop = 500, timer = 2, dst = { -- 曲終了タイマー
            {time = 0, x = 0, y = 0, w = geometry.resolution.x, h = geometry.resolution.y, a = 0},
            {time = 500, a = 255}
        }}
    })
    return skin
end

return {
    header = header,
    main = main
}

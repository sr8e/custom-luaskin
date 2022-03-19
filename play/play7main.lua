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

function is_judge_detail_ms()
	return skin_config.option["Judge Detail"] == 912
end

-- timers
function timer_key_bomb(index)
	if index == 8 then
		return 50
	else
		return 50 + index
	end
end

function timer_key_hold(index)
	if index == 8 then
		return 70
	else
		return 70 + index
	end
end

function timer_key_on(index)
	if index == 8 then
		return 100
	else
		return 100 + index
	end
end

function timer_key_off(index)
	if index == 8 then
		return 120
	else
		return 120 + index
	end
end

function value_judge(index)
	if index == 8 then
		return 500
	else
		return 500 + index
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
		{name = "EARLY/LATE", op = 911},
		{name = "+-ms", op = 912}
	}}
}

local filepath = {
	{name = "Background", path = "background/*.png"},
	{name = "Note", path = "notes/*.png"},
	{name = "Bomb", path = "bomb/*.png"},
	{name = "Gauge", path = "gauge/*.png"},
	{name = "Judge", path = "judge/*.png"},
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

keybeam_order = {1, 2, 3, 4, 5, 6, 7, 8}

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
		{id = 3, path = "gauge/*.png"},
		{id = 4, path = "judge/*.png"},
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

		{id = "keybeam-w", src = "keybeam", x = 48, y = 0, w = 27, h = 255},
		{id = "keybeam-b", src = "keybeam", x = 76, y = 0, w = 20, h = 255},
		{id = "keybeam-s", src = "keybeam", x = 0, y = 0, w = 47, h = 255},
		
		{id = "gauge-r1", src = 3, x = 0, y = 0, w = 5, h = 17},
		{id = "gauge-b1", src = 3, x = 5, y = 0, w = 5, h = 17},
		{id = "gauge-r2", src = 3, x = 10, y = 0, w = 5, h = 17},
		{id = "gauge-b2", src = 3, x = 15, y = 0, w = 5, h = 17},
		{id = "gauge-r3", src = 3, x = 0, y = 34, w = 5, h = 17},
		{id = "gauge-b3", src = 3, x = 5, y = 34, w = 5, h = 17},
		{id = "gauge-y1", src = 3, x = 0, y = 17, w = 5, h = 17},
		{id = "gauge-p1", src = 3, x = 5, y = 17, w = 5, h = 17},
		{id = "gauge-y2", src = 3, x = 10, y = 17, w = 5, h = 17},
		{id = "gauge-p2", src = 3, x = 15, y = 17, w = 5, h = 17},
		{id = "gauge-y3", src = 3, x = 10, y = 34, w = 5, h = 17},
		{id = "gauge-p3", src = 3, x = 15, y = 34, w = 5, h = 17},

		{id = "judge-early", src = 13, x = 0, y = 0, w = 50, h = 20},
		{id = "judge-late", src = 13, x = 50, y = 0, w = 50, h = 20}
	}

	local notes_main = require("notes")
	local notes = notes_main("single")
	append_all(skin.image, notes.src)

	skin.note = notes.dst

	local function bomb_image(index, prefix, timer_func)
		local name = index
		if index == 25 then
			name = "su"
		elseif index == 26 then
			name = "sd"
		end
		return {id = prefix..name, src = "bomb", x = 0, y = 0, w = 181 * 16, h = 192, divx = 16, timer = timer_func(index), cycle = 160}
	end

	for i = 1, 8 do
		table.insert(skin.image, bomb_image(i, "bomb-", timer_key_bomb))
	end

	skin.imageset = {}
	do
		for i = 1, 8 do
			local name = i
			if i == 25 then
				name = "su"
			elseif i == 26 then
				name = "sd"
			end
			local img_suffix = note_colors[get_key_wbs(i) + 1]
			table.insert(skin.imageset, {
				id = "keybeam"..name,
				-- ref = value_judge(i),
				images = { "keybeam-"..img_suffix }
			})
		end
	end
	for i = 1, 8 do
		local name = i
		if i == 25 then
			name = "su"
		elseif i == 26 then
			name = "sd"
		end
		table.insert(skin.imageset, {
			id = i + 109,
			-- ref = value_judge(i),
			images = { "bomb-"..name } 
		})
	end

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

	skin.value = {
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
		value_resource("graphvalue-rate", "n", "w", 10, 3, 102),
		value_resource("graphvalue-rate-d", "n", "w", 10, 2, 103, 1),
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
		value_resource("liftcover-duration", "n", "w", 10, 4, 312),
		-- combo
		value_resource("combo-pg", "j", "pg", 10, 6, 75, 0, 3, 100),
		value_resource("combo-gr", "j", "y", 10, 6, 75),
		value_resource("combo-gd", "j", "y", 10, 6, 75),

		{id = "judgems-1pp", src = 13, x = 0, y = 20, w = 120, h = 40, divx = 12, divy = 2, digit = 4, ref = 525},
		{id = "judgems-1pg", src = 13, x = 0, y = 60, w = 120, h = 40, divx = 12, divy = 2, digit = 4, ref = 525}
	}

	local timings = { "", "-e", "-l" }
	local timings_early_late = { "-e", "-l" }

	local function value_jc(j, t)
		if j <= 5 then
			if t == 1 then
				return 109 + j
			else
				return 410 + (j - 1)*2 + (t - 2)
			end
		else
			return 420 + (t - 1)
		end
	end
	local function judge_count_sources(prefix, number_image_id)
		local jc_src = {}
		local colour = {"w","b","r"}
		for ij, j in ipairs(judges) do
			for it, t in ipairs(timings) do
				table.insert(jc_src, {
					id = prefix..j..t,
					src = number_image_id,
					x = num_src.n.x, y = num_src.n.y[colour[it]], w = num_src.n.w*10, h = num_src.n.h,
					divx = 10,
					digit = 4,
					ref = value_jc(ij, it),
				})
			end
		end
		return jc_src
	end 
	append_all(skin.value, judge_count_sources("judge-count-", "ec_num"))

	-- judge
	local judge_main = require("judge")
	local judge = judge_main("single")
	append_all(skin.image, judge.src)

	skin.judge = judge.dst

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

	skin.note.dst = {}
	for i = 1, 8 do
		skin.note.dst[i] = {
			x = geometry.notes_x[i],
			y = geometry.judge_line_y,  --判定位置
			w = geometry.notes_w[i],
			h = geometry.notes_area_h  --ノーツ出現領域高さ
		}
	end
	skin.gauge = {
		id = "gauge",
		nodes = {"gauge-r1","gauge-p1","gauge-r2","gauge-p2","gauge-r3","gauge-p3"
			,"gauge-r1","gauge-p1","gauge-r2","gauge-p2","gauge-r3","gauge-p3"
			,"gauge-r1","gauge-b1","gauge-r2","gauge-b2","gauge-r3","gauge-b3"
			,"gauge-r1","gauge-p1","gauge-r2","gauge-p2","gauge-r3","gauge-p3"
			,"gauge-y1","gauge-p1","gauge-y2","gauge-p2","gauge-y3","gauge-p3"
			,"gauge-p1","gauge-p1","gauge-p2","gauge-p2","gauge-p3","gauge-p3"}
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
		{id = "minbpm", dst = {
			{x = 345, y = 10, w = 28, h = 21}
		}},
		{id = "nowbpm", dst = {
			{x = 480, y = 10, w = 28, h = 21}
		}},
		{id = "maxbpm", dst = {
			{x = 614, y = 10, w = 28, h = 21}
		}},
		{id = "timeleft-m", dst = {
			{x = 305, y = 164, w = 16, h = 24}
		}},
		{id = "timeleft-s", dst = {
			{x = 350, y = 164, w = 16, h = 24}
		}},
		{id = "hispeed", dst = {
			{x = 116, y = 2, w = 12, h = 24}
		}},
		{id = "hispeed-d", dst = {
			{x = 154, y = 2, w = 10, h = 20}
		}},
		
		{
			id="currentscore",
			dst={
				{x=1000, y=1000, w = 28, h = 19}
			}
		},
		{
			id="targetscore",
			dst={
				{x=1000, y=965, w = 28, h = 19}
			}
		},
		{
			id = "totalnotes", dst={
				{x=980, y=120, w=16, h=24}
			}	
		},
		{id = 13, dst = {
			{x = geometry.progress_x + 2, y = geometry.progress_y, w = geometry.progress_w - 4, h = geometry.progress_h}
		}},

		{id = "lane-bg", loop = 1000, offset = 44, dst = {
			{time = 0, x = geometry.lanebg_x, y = 251, w = geometry.lanebg_w, h = 0, a = 0},
			{time = 1000, h = 828, a = 255}
		}},
		{id = "keys", dst = {
			{x = geometry.lanes_x, y = 550, w = geometry.lanes_w, h = 80}
		}}
	}
	for _, i in ipairs(keybeam_order) do
		name = i
		if i == 25 then
			name = "s"
		elseif i == 26 then
			name = "sd"
		end
		table.insert(skin.destination, {
			id = "keybeam"..name,
			timer = timer_key_on(i),
			loop = 100,
			offsets = {3, 40},
			dst = {
				{ time = 0, x = geometry.notes_x[i] + geometry.notes_w[i] / 4, y = geometry.judge_line_y, w = geometry.notes_w[i] / 2, h = geometry.notes_area_h },
				{ time = 100, x = geometry.notes_x[i], w = geometry.notes_w[i] }
			}
		})
	end
	table.insert(skin.destination, {id = 15, offset = 3, dst = { {x = geometry.lanes_x, y = geometry.judge_line_y, w = geometry.lanes_w, h = 6} }}) --判定線
	table.insert(skin.destination, {id = "notes", offset=30})
	for i = 1, 8 do
		table.insert(skin.destination, {
			id = 109 + i,
			timer = timer_key_bomb(i),
			blend = 2,
			loop = -1,
			offsets = {3, 41},
			dst = {
				{ time = 0, x = geometry.lanes_center_x[i] - 125, y = judge_line_y - 144, w = 270, h = 288 },
				{ time = 160 }
			}
		})
	end
	for i = 1, 8 do
		name = i
		if i == 25 then
			name = "su"
		elseif i == 26 then
			name = "sd"
		end
		table.insert(skin.destination, {
			id = "hold-"..name,
			timer = timer_key_hold(i),
			blend = 2,
			offset = 3,
			dst = {
				{ time = 0, x = geometry.lanes_center_x[i] - 80, y = 28, w = 180, h = 192 }
			}
		})
	end
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
		{id = "judgems-1pp", loop = -1, timer = 46 ,op = {912,241},offsets = {3, 33}, dst = {
			{time = 0, x = geometry.judgedetail_x, y = geometry.judgedetail_y, w = 10, h = 20},
			{time = 500}
		}},
		{id = "judgems-1pg", loop = -1, timer = 46 ,op = {912,-241},offsets = {3, 33}, dst = {
			{time = 0, x = geometry.judgedetail_x, y = geometry.judgedetail_y, w = 10, h = 20},
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
		{id = "gauge", dst = {
			{time = 0, x = geometry.gauge_x, y = 96, w = geometry.gauge_w, h = 51}
		}},
		{id = "gaugevalue", dst = {
			{time = 0, x = geometry.gaugevalue_x, y = 180, w = 45, h = 45}
		}},
		--[[
		{id = "gaugevalue-d", dst = {
			{time = 0, x = geometry.gaugevalue_x + 72, y = 180, w = 18, h = 18}
		}}
		]]
	})
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
			{time = 0, x = geometry.title_x, y = 1034, w = 24, h = 24},
			{time = 1000, a = 0},
			{time = 2000, a = 255}
		}},
		--{id = 11, op = {901},dst = {
		--	{x = geometry.graph_x, y = geometry.graph_y, w = geometry.graph_w, h = geometry.graph_h}
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
		--	{x = geometry.graph_x, y = geometry.graph_y, w = geometry.graph_w, h = geometry.graph_h}
		--}},
		{
			id = "graphvalue-rate",
			dst = {
				{x = 180, y = 206, w = 16, h = 24}
			}
		},
		{
			id = "graphvalue-rate-d",
			dst = {
				{x = 244, y = 206, w = 16, h = 24}
			}
		},
		{id = 422, op = {901},dst = {
			{x = 1012, y = 995, w = 28, h = 19}
		}},
		--{id = 423, op = {901},dst = {
		--	{x = geometry.graph_x + 10, y = 160, w = 12, h = 18}
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
	local function judge_count_destinations(prefix, pos_x, pos_y, ops, offset)
		local destinations = {}
		for y, j in ipairs(judges) do
			for x, t in ipairs(timings) do
				table.insert(destinations, {
					id = prefix..j..t,
					op = ops,
					dst = {
						{x = pos_x + (x - 1) * 60, y = pos_y + 90 - (y - 1) * 18, w = 12, h = 18}
					}
				})
			end
		end
		if offset >= 0 then
			for _, dst in ipairs(destinations) do
				dst.offset = offset
			end
		end
		return destinations
	end
	append_all(skin.destination, judge_count_destinations("judge-count-", geometry.judgecount_x, geometry.judgecount_y, {906}, 42))
	append_all(skin.destination, {
		{id = "lanecover-value", offset = 4, op = {270},dst = {
			{time = 0, x = geometry.lanes_x + geometry.lanes_w / 3 - 24, y = geometry.resolution.y - 27, w = 18, h = 27}
		}},
		{id = "lanecover-duration", offset = 4, op = {270},dst = {
			{time = 0, x = geometry.lanes_x + geometry.lanes_w * 2 / 3 - 24, y = geometry.resolution.y - 27, w = 18, h = 27}
		}},
		{id = "liftcover-value", offset = 3, op = {270},dst = {
			{time = 0, x = geometry.lanes_x + geometry.lanes_w / 3 - 24, y = geometry.judge_line_y + 6 , w = 18, h = 27}
		}},
		{id = "liftcover-duration", offset = 3, op = {270},dst = {
			{time = 0, x = geometry.lanes_x + geometry.lanes_w * 2 / 3 - 24, y = geometry.judge_line_y + 6, w = 18 , h = 27}
		}},
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

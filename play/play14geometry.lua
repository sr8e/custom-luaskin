local geometry = {}

geometry.resolution = {x = 1920, y = 1080}

geometry.judge_line_y = 251
geometry.judge_y = 450
geometry.notes_area_h = 830

geometry.lanes_w = 639
geometry.lane_w_width = 81
geometry.lane_b_width = 61
geometry.lane_s_width = 134
geometry.note_w_width = 75
geometry.note_b_width = 57
geometry.note_s_width = 132


geometry.lanes_x = { left = 224, right = 1058 }
geometry.title_align = 0
geometry.judge_x = { left = 460, right = 1228 }
-- fa/sl
geometry.judgedetail_x = { left = 520, right = 1308 }
geometry.judgedetail_y = 540
-- judge count
geometry.judgecount_x = 1735
geometry.judgecount_y = 100

geometry.ready_x = { left = 395, right = 1200 }
geometry.title_x = 230
geometry.title_y = 171
-- gauge
geometry.gauge_x = 611
geometry.gauge_y = 74
geometry.gauge_w = 677
geometry.gauge_h = 51
geometry.gaugevalue_x = 888
geometry.gaugevalue_y = 180
--bga
geometry.bga_x = 5
geometry.bga_y = 5
if is_bga_enabled() then
	geometry.bga_w = 200
	geometry.bga_h = 200
else
	geometry.bga_w = 0
	geometry.bga_h = 0
end

-- note graph
geometry.judgegraph_x = 270
geometry.judgegraph_y = 5
geometry.judgegraph_w = 450
geometry.judgegraph_h = 75
-- timing indicator
geometry.timing_x = 1200
geometry.timing_y = 5
geometry.timing_w = 450
geometry.timing_h = 50
-- progress bar
geometry.progress_x = 183
geometry.progress_y = 275
geometry.progress_w = 14
geometry.progress_h = 787

geometry.bpm_y = 10
geometry.minbpm_x = 770
geometry.nowbpm_x = 905
geometry.maxbpm_x = 1040

geometry.timeleft_y = 99
geometry.timeleft_m_x = 502
geometry.timeleft_s_x = 552

geometry.scorerate_y = 135
geometry.scorerate_x = 485
geometry.scorerate_d_x = 550

geometry.hispeed_y = -100
geometry.hispeed_x = 0
geometry.hispeed_d_x = 0

geometry.currentscore_x = 1770
geometry.currentscore_y = 1000
geometry.targetscore_x = 1770
geometry.targetscore_y = 965

geometry.totalnotes_x = 1770
geometry.totalnotes_y = 16

if is_score_graph_enabled() then
    geometry.graph_x = 1765
	geometry.graph_y = 264
	geometry.graph_w = 150
	geometry.graph_h = 665
else
	geometry.graph_x = 0
	geometry.graph_y = 0
	geometry.graph_w = 0
	geometry.graph_h = 0
end


geometry.notes_w = {}
geometry.lanebg_x = {}

for i = 1, 16 do
	if get_key_wbs(i) == 0 then
		geometry.notes_w[i] = geometry.note_w_width
	elseif get_key_wbs(i) == 1 then
		geometry.notes_w[i] = geometry.note_b_width
	else
		geometry.notes_w[i] = geometry.note_s_width
	end
end
geometry.lanebg_w = geometry.lanes_w

local function calc_lane_pos(side)
	local x = geometry.lanes_x[side]
	local pos = {}

	if side == "left" then
		geometry.lanebg_x[side] = geometry.lanes_x[side]
		pos[8] = x
		x = x + geometry.lane_s_width;
	end	

	local adjust_w = (geometry.lane_w_width - geometry.note_w_width) / 2
	local adjust_b = (geometry.lane_b_width - geometry.note_b_width) / 2
	for i = 1, 7 do
		if get_key_wbs(i) == 0 then
			pos[i] = x + adjust_w
			x = x + geometry.lane_w_width
		else
			pos[i] = x + adjust_b
			x = x + geometry.lane_b_width
		end
	end

	if side == "right" then
		geometry.lanebg_x[side] = geometry.lanes_x[side] + geometry.lanes_w
		pos[8] = x
	end

	local center = {}
	for i = 1, 8 do
		center[i] = pos[i] + geometry.notes_w[i] / 2
	end
	return {
		pos = pos,
		center = center
	}
end

local pos_l = calc_lane_pos("left")
local pos_r = calc_lane_pos("right")
geometry.notes_x = pos_l.pos
geometry.lanes_center_x = pos_l.center
for _, v in ipairs(pos_r.pos) do
	table.insert(geometry.notes_x, v)
end

for _, v in ipairs(pos_r.center) do
	table.insert(geometry.lanes_center_x, v)
end


return geometry
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

if is_left_side() then
	geometry.lanes_x = 80 -- 画面左端からの位置,
	geometry.title_align = 0
	geometry.judge_x = 290 --判定表示位置
	-- fa/sl
	geometry.judgedetail_x = 350 -- fast/slow 位置
	geometry.judgedetail_y = 540
	-- judge count
	geometry.judgecount_x = 756
	geometry.judgecount_y = 100

	geometry.ready_x = 225
	geometry.title_x = 1200
	geometry.title_y = 1034
	-- gauge
	geometry.gauge_x = 57
	geometry.gauge_y = 96
	geometry.gauge_w = 677
	geometry.gaugevalue_x = 570
	geometry.gaugevalue_y = 180
	--bga
	geometry.bga_x = 1170
	geometry.bga_y = 250
	geometry.bga_w = 750
	geometry.bga_h = 563
	-- note graph
	geometry.judgegraph_x = 1200
	geometry.judgegraph_y = 100
	geometry.judgegraph_w = 450
	geometry.judgegraph_h = 100
	-- timing indicator
	geometry.timing_x = 1200
	geometry.timing_y = 50
	geometry.timing_w = 450
	geometry.timing_h = 50
	-- progress bar
	geometry.progress_x = 36
	geometry.progress_y = 275
	geometry.progress_w = 14
	geometry.progress_h = 787

	geometry.bpm_y = 10
	geometry.minbpm_x = 345
	geometry.nowbpm_x = 480
	geometry.maxbpm_x = 615

	geometry.timeleft_y = 160
	geometry.timeleft_m_x = 300
	geometry.timeleft_s_x = 350

	geometry.scorerate_y = 206
	geometry.scorerate_x = 180
	geometry.scorerate_d_x = 244

	geometry.hispeed_y = 60
	geometry.hispeed_x = 625
	geometry.hispeed_d_x = 670

	geometry.currentscore_x = 1000
	geometry.currentscore_y = 1000
	geometry.targetscore_x = 1000
	geometry.targetscore_y = 965

	geometry.totalnotes_x = 980
	geometry.totalnotes_y = 120

elseif is_right_side() then
	-- TODO right side geometry
	geometry.lanes_x = 870
	geometry.title_align = 2 -- 左揃え
	geometry.judge_x = 965
	geometry.judgedetail_x = 1050
	geometry.judgedetail_y = 290
	geometry.judgecount_x = 756
	geometry.judgecount_y = 100
	geometry.ready_x = 890
	geometry.title_x = 840
	geometry.gauge_x = 1260
	geometry.gauge_w = -390
	geometry.gaugevalue_x = 870
	geometry.bga_x = 40
	geometry.bga_y = 50
	geometry.bga_w = 800
	geometry.bga_h = 650
	geometry.judgegraph_x = 90
	geometry.judgegraph_y = 100
	geometry.judgegraph_w = 450
	geometry.judgegraph_h = 100
	geometry.timing_x = 90
	geometry.timing_y = 50
	geometry.timing_w = 450
	geometry.timing_h = 50
	geometry.progress_x = 1262
	geometry.progress_y = 140
	geometry.progress_w = 16
	geometry.progress_h = 540
end

if is_score_graph_enabled() then
	if is_left_side() then
    	geometry.graph_x = 810 --geometry.lanes_x + geometry.lanes_w
    	--geometry.title_x = geometry.title_x + 90
    	geometry.bga_x = geometry.bga_x + 90
    	geometry.bga_w = geometry.bga_w - 90
    		--geometry.judgecount_x = geometry.judgecount_x + 90
    else
    	geometry.graph_x = geometry.lanes_x - 90
    	geometry.title_x = geometry.title_x - 90
    	geometry.bga_w = geometry.bga_w - 90
    	geometry.judgecount_x = geometry.judgecount_x - 90
    end
	geometry.graph_y = 264
	geometry.graph_w = 350
	geometry.graph_h = 665
else
	geometry.graph_x = 0
	geometry.graph_y = 0
	geometry.graph_w = 0
	geometry.graph_h = 0
end


geometry.notes_x = {}
geometry.notes_w = {}
geometry.lanes_center_x = {}

local x = geometry.lanes_x
if is_left_scratch() then
	geometry.lanebg_x = geometry.lanes_x
	geometry.lanebg_w = geometry.lanes_w
	x = x + geometry.lane_s_width;
	geometry.notes_x[8] = geometry.lanes_x
	geometry.notes_w[8] = geometry.note_s_width
end
local adjust_w = (geometry.lane_w_width - geometry.note_w_width) / 2
local adjust_b = (geometry.lane_b_width - geometry.note_b_width) / 2
for i = 1, 7 do
	if get_key_wbs(i) == 0 then
		geometry.notes_x[i] = x + adjust_w
		geometry.notes_w[i] = geometry.note_w_width
		x = x + geometry.lane_w_width
	else
		geometry.notes_x[i] = x + adjust_b
		geometry.notes_w[i] = geometry.note_b_width
		x = x + geometry.lane_b_width
	end
end

if is_right_scratch() then
	geometry.lanebg_x = geometry.lanes_x + geometry.lanes_w
	geometry.lanebg_w = -geometry.lanes_w
	geometry.notes_x[8] = x
	geometry.notes_w[8] = geometry.lane_s_width
end
for i = 1, 8 do
	geometry.lanes_center_x[i] = geometry.notes_x[i] + geometry.notes_w[i] / 2
end

return geometry
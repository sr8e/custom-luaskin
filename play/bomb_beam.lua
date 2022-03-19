local function main(play_type)
    local keys = (play_type == "single") and 8 or 16

    local src = {}
    local set = {}
    local dst = {}

    --keybeams
    local beam_pos = {
        x = {
            w = 48, b = 76, s = 0
        },
        y = 0,
        w = {
            w = 27, b = 20, s = 47
        },
        h = 255
    }

    for _, color in ipairs(note_colors) do
        table.insert(src, {
            id = "keybeam-"..color,
            src = "keybeam",
            x = beam_pos.x[color],
            y = beam_pos.y,
            w = beam_pos.w[color],
            h = beam_pos.h
        })
    end

    for i = 1, keys do
        local img_suffix = note_colors[get_key_wbs(i) + 1]
        table.insert(set, {
            id = "keybeam"..i,
            -- ref = value_judge(i),
            images = { "keybeam-"..img_suffix }
        })
    end
    
    for i = 1, keys do
		table.insert(dst, {
			id = "keybeam"..i,
			timer = timer_key_on(i),
			loop = 100,
			offsets = {3, 40},
			dst = {
				{ time = 0, x = geometry.notes_x[i] + geometry.notes_w[i] / 4, y = geometry.judge_line_y, w = geometry.notes_w[i] / 2, h = geometry.notes_area_h },
				{ time = 100, x = geometry.notes_x[i], w = geometry.notes_w[i] }
			}
		})
    end

    --bombs
    for i = 1, keys do
        table.insert(src, {
            id = "bomb-"..i,
            src = "bomb",
            x = 0,
            y = 0,
            w = 181 * 16,
            h = 192,
            divx = 16,
            timer = timer_key_bomb(i),
            cycle = 160
        })
    end

    for i = 1, keys do
		table.insert(set, {
			id = "bombset-"..i,
			-- ref = value_judge(i),
			images = { "bomb-"..i } 
		})
    end

	for i = 1, keys do
		table.insert(dst, {
			id = "bombset-"..i,
			timer = timer_key_bomb(i),
			blend = 2,
			loop = -1,
			offsets = {3, 41},
			dst = {
				{ time = 0, x = geometry.lanes_center_x[i] - 125, y = geometry.judge_line_y - 144, w = 270, h = 288 },
				{ time = 160 }
			}
		})
    end
    
    return {
        src = src,
        set = set,
        dst = dst
    }
end

return main
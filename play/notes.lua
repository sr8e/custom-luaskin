local function main(play_type)
    local keys = (play_type == "single") and 8 or 16 -- type == "single" ? 8 : 16
    local src = {}

    -- insert note image resource
    -- source position/size info
    local nx = {b = 96, w = 61, s = 0}
    local ny = {
        note = 4, mine = 33,
        lns = 76, lne = 59, lnb = 112, lna = 101,
        hcs = 76, hce = 59, hcb = 112, hca = 101, hcd = 113, hcr = 102
    }
    local nw = {b = 26, w = 34, s = 60}
    local nh = {
        note = 16, mine = 8,
        lns = 16, lne = 16, lnb = 2, lna = 1,
        hcs = 16, hce = 16, hcb = 2, hca = 1, hcd = 1, hcr = 1
    }

    -- generate resource object
    local function note_resource(type, color)
        ln_animate = type:sub(3, 3) == "b"
        return {
            id=type.."-"..color,
            src="notes",
            x=nx[color],
            y=ny[type],
            w=nw[color],
            h=nh[type],
            divy = ln_animate and 2 or 1,
            cycle = ln_animate and 300 or 0,
        }
    end

    local note_types = {"note", "lns", "lne", "lnb", "lna", "hcs", "hce", "hcb", "hca", "hcd", "hcr", "mine"}

    -- insert reseource of every types and colors
    for i = 1, 12 do
        for j = 1, 3 do
            table.insert(src, note_resource(note_types[i], note_colors[j]))
        end
    end

    -- section line
    table.insert(src, {id = "section-line", src = 0, x = 0, y = 0, w = 1, h = 1})

    -- generate 8 lane note list
    local function notes_list(type)

        local list = {}
        for i = 1, keys do
            list[i] = type.."-"..note_colors[get_key_wbs(i) + 1]
        end
        return list
    end

    local function sect_obj(height, x, r, g, b)
        return {
            id = "section-line",
            offset = 3,
            dst = {
                {
                    x = x,
                    y = geometry.judge_line_y,
                    w = geometry.lanes_w,
                    h = 1,
                    r = r, g = g, b = b
                }
            }
        }
    end

    local function sections(height, r, g, b)
        if play_type == "single" then
            return {sect_obj(height, geometry.lanes_x, r, g, b)}
        else
            return {
                sect_obj(height, geometry.lanes_x.left, r, g, b),
                sect_obj(height, geometry.lanes_x.right, r, g, b)
            }
        end
    end

    dst = {
        id = "notes",
        note = notes_list("note"),
        lnend = notes_list("lne"),
        lnstart = notes_list("lns"),
        lnbody = notes_list("lnb"),
        lnactive = notes_list("lna"),
        hcnend = notes_list("hce"),
        hcnstart = notes_list("hcs"),
        hcnbody = notes_list("hcb"),
        hcnactive = notes_list("hca"),
        hcndamage = notes_list("hcd"),
        hcnreactive = notes_list("hcr"),
        mine = notes_list("mine"),
        hidden = {},
        processed = {},
        group = sections(1, 128, 128, 128),
        time = sections(2, 64, 192, 192),
        bpm = sections(2, 0, 192, 0),
        stop = sections(2, 192, 192, 0)
    }

    dst.dst = {}
    for i = 1, keys do
        dst.dst[i] = {
            x = geometry.notes_x[i],
            y = geometry.judge_line_y,  --判定位置
            w = geometry.notes_w[i],
            h = geometry.notes_area_h  --ノーツ出現領域高さ
        }
    end

    return {
        src = src,
        dst = dst
    }
end

return main
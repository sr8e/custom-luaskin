local function main(play_type)

    local src = {}
    local size = {
        src = {h = 56, w = 153},
        dst = {h = 84, w = 230},
    }
    local pos = {0, 3, 4, 5, 6, 6}

    local num_w = 56

    local function judge_image(i)
        divy = (i == 1) and 3 or 1
        return {
            id = "judgef-"..judges[i],
            src = "ec_obj",
            x = 0,
            y = size.src.h * pos[i],
            w = size.src.w,
            h = size.src.h * divy,
            divy = divy,
            cycle = (i == 1) and 100 or 0
        }
    end

    for i = 1, 6 do
        local obj = judge_image(i)
        table.insert(src, obj)
    end

    local function get_timer(side)
        if play_type == "single" or side == "left" then
            return 46
        else
            return 47
        end
    end

    local function judgef_dst(i, side)
        dst_x = (play_type == "single") and geometry.judge_x or geometry.judge_x[side]
        if i > 4 then
            dst_x = dst_x + num_w / 2
        end
        return {
            id = "judgef-"..judges[i],
            loop = -1,
            timer = get_timer(side),
            offsets = {3, 32},
            dst = {
                {
                    time = 0,
                    x = dst_x,
                    y = geometry.judge_y,
                    w = size.dst.w,
                    h = size.dst.h
                },
                {
                    time = 500
                }
            }
        }
    end

    local function judgen_dst(i, side)
        if i < 4 then
            return {
                id = "combo-"..judges[i],
                loop = -1,
                timer = get_timer(side),
                offsets = {3, 32},
                dst = {
                    {
                        time = 0,
                        x = size.dst.w + 10,
                        y = 0,
                        w = num_w,
                        h = size.dst.h
                    },
                    {
                        time = 500
                    }
                }
            }
        else
            return {id = "n/a"}
        end
    end

    local dst_left = {id = "judge-l", index = 0, images = {}, numbers = {}, shift = true}
    local dst_right = {id = "judge-r", index = 1, images = {}, numbers = {}, shift = true}

    for i = 1, 6 do
        table.insert(dst_left.images, judgef_dst(i, "left"))
        table.insert(dst_left.numbers, judgen_dst(i, "left"))

        if play_type == "double" then
            table.insert(dst_right.images, judgef_dst(i, "right"))
            table.insert(dst_right.numbers, judgen_dst(i, "right"))
        end
    end

    if play_type == "single" then
        return {
            src = src,
            dst = {dst_left},
            ids = {{id = "judge-l"}}
        }
    else
        return {
            src = src,
            dst = {dst_left, dst_right},
            ids = {{id = "judge-l"}, {id = "judge-r"}}
        }
    end
end

return main

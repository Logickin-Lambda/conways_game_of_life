const std = @import("std");
const rl = @import("raylib");
const gui = @import("raygui");

const Theme = struct {
    cell: rl.Color,
    back: rl.Color,
};

const colour_template = [_]Theme{
    .{ .cell = rl.Color.init(255, 255, 255, 255), .back = rl.Color.init(0, 0, 0, 255) },
    .{ .cell = rl.Color.init(0, 255, 16, 255), .back = rl.Color.init(0, 34, 0, 255) },
    .{ .cell = rl.Color.init(161, 161, 239, 255), .back = rl.Color.init(33, 33, 183, 255) },
    .{ .cell = rl.Color.init(247, 165, 0, 255), .back = rl.Color.init(124, 0, 0, 255) },
    .{ .cell = rl.Color.init(255, 211, 0, 255), .back = rl.Color.init(0, 37, 95, 255) },
    .{ .cell = rl.Color.init(255, 0, 207, 255), .back = rl.Color.init(59, 0, 79, 255) },
};

fn randomColourTemplate() Theme {
    const rand_num: u8 = std.crypto.random.uintLessThan(u8, colour_template.len);
    return colour_template[rand_num];
}

pub const AppProperties = struct {
    const Self = @This();

    speed_value: f32 = 0.25,
    cells_color: rl.Color = rl.Color.init(0, 0, 0, 255),
    cells_color_inverted: bool = true,
    background_color: rl.Color = rl.Color.init(0, 0, 0, 0),
    background_color_inverted: bool = false,
    play_toggle_active: bool = false,
    game_tick: f32 = 0,
    active_dropdown: bool = false,
    pattern_mode: i32 = 5,
    require_redraw: bool = false,

    pub fn initialize_colour(self: *Self) void {
        const color_theme = randomColourTemplate();
        self.cells_color = color_theme.cell;
        self.background_color = color_theme.back;
    }
};

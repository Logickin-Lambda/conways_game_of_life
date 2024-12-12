const std = @import("std");
const rl = @import("raylib");
const gui = @import("raygui");

pub const AppProperties = struct {
    speed_value: f32 = 0.25,
    cells_color: rl.Color = rl.Color.init(0, 0, 0, 255),
    cells_color_inverted: bool = true,
    background_color: rl.Color = rl.Color.init(0, 0, 0, 0),
    background_color_inverted: bool = false,
    play_toggle_active: bool = false,
    game_tick: f32 = 0,
};

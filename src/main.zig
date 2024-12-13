const std = @import("std");
const rl = @import("raylib");
const gui = @import("raygui");
const gui_render = @import("gui_components.zig");
const grd = @import("grid.zig");
const app = @import("app_properties.zig");
const builtin = @import("builtin");

pub fn main() !void {
    // Initialization
    //--------------------------------------------------------------------------------------
    const screenWidth = 792;
    const screenHeight = 456;

    const rand_num: u8 = std.crypto.random.uintLessThan(u8, 9);
    _ = rand_num;

    var app_properties = app.AppProperties{};
    app_properties.initialize_colour();

    const allocator = std.heap.c_allocator;
    var grid = try grd.GameOfLifeGrid().init(allocator, 46, 34);
    grid.generatePattern(&app_properties);
    defer grid.deinit();

    rl.initWindow(screenWidth, screenHeight, "Conways Game Of Life");
    defer rl.closeWindow(); // Close window and OpenGL context

    rl.setTargetFPS(60); // Set our game to run at 60 frames-per-second
    gui.guiLoadStyleDefault();
    //--------------------------------------------------------------------------------------

    // Main game loop
    while (!rl.windowShouldClose()) { // Detect window close button or ESC key
        // Update
        //----------------------------------------------------------------------------------
        // TODO: Update your variables here
        //----------------------------------------------------------------------------------

        // Draw
        //----------------------------------------------------------------------------------
        rl.beginDrawing();

        // raygui: controls drawing
        //----------------------------------------------------------------------------------
        // Draw controls
        gui_render.renderBackground(&app_properties);
        gui_render.renderComponents(&app_properties);
        gui_render.renderGrid(&grid, &app_properties);
        rl.endDrawing();
        //----------------------------------------------------------------------------------

        // Postprocess after the graphical contents are plotted
        //----------------------------------------------------------------------------------
        if (app_properties.play_toggle_active) {
            grid.update(&app_properties);
        }

        if (app_properties.require_redraw) {
            grid.generatePattern(&app_properties);
        }
    }
}

test "int cast test" {
    const original_unsign: u32 = 0xFFFFFFFF;
    const original_val: i32 = @bitCast(original_unsign);
    std.debug.print("\nOriginal Enum Vals {d}\n", .{original_val});
    std.debug.print("Casted value {d}\n", .{@as(u32, @bitCast(original_val))});

    try std.testing.expectEqual(original_unsign, @as(u32, @bitCast(original_val)));
}

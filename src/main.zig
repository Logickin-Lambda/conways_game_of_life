const std = @import("std");
const rl = @import("raylib");
const gui = @import("raygui");
const gui_render = @import("gui_components.zig");
const grd = @import("grid.zig");
const app = @import("app_properties.zig");

pub fn main() !void {
    // Initialization
    //--------------------------------------------------------------------------------------
    const screenWidth = 792;
    const screenHeight = 456;

    var app_properties = app.AppProperties{};

    const allocator = std.heap.page_allocator;
    var grid = try grd.GameOfLifeGrid().init(allocator, 46, 34);
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
        defer rl.endDrawing();

        // raygui: controls drawing
        //----------------------------------------------------------------------------------
        // Draw controls
        gui_render.renderBackground(&app_properties);
        gui_render.renderComponents(&app_properties);
        gui_render.renderGrid(&grid, &app_properties);
        //----------------------------------------------------------------------------------
    }
}

test "int cast test" {
    const original_unsign: u32 = 0xFFFFFFFF;
    const original_val: i32 = @bitCast(original_unsign);
    std.debug.print("\nOriginal Enum Vals {d}\n", .{original_val});
    std.debug.print("Casted value {d}\n", .{@as(u32, @bitCast(original_val))});

    try std.testing.expectEqual(original_unsign, @as(u32, @bitCast(original_val)));
}

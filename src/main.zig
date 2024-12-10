const std = @import("std");
const rl = @import("raylib");
const gui = @import("raygui");

pub fn main() !void {
    // Initialization
    //--------------------------------------------------------------------------------------
    const screenWidth = 800;
    const screenHeight = 450;

    rl.initWindow(screenWidth, screenHeight, "Conways Game Of Life");
    defer rl.closeWindow(); // Close window and OpenGL context

    // Define controls variables
    // var size_x_editMode: bool = false;
    // var size_x_value: i32 = 0;
    // var size_y_editMode: bool = false;
    // var size_y_value: i32 = 0;

    var speed_value: f32 = 0.0;
    var cells_color_value: rl.Color = rl.Color.init(0, 0, 0, 0);
    var background_color_value: rl.Color = rl.Color.init(0, 0, 0, 0);

    var play_toggle_active: i32 = 0;

    // preload frequently used enum:
    const component = gui.GuiControl;
    const default_prop = gui.GuiDefaultProperty;

    // defined rectangle bounds:
    const side_panel_rec: rl.Rectangle = rl.Rectangle.init(0, 0, 792, 456);
    const full_panel_rec: rl.Rectangle = rl.Rectangle.init(0, 0, 192, 456);
    const dimension_label_rec: rl.Rectangle = rl.Rectangle.init(16, 128, 120, 24);
    const header_label_rec: rl.Rectangle = rl.Rectangle.init(16, 16, 144, 24);
    const random_btn_rec: rl.Rectangle = rl.Rectangle.init(16, 152, 160, 24);
    const speed_slider_rec: rl.Rectangle = rl.Rectangle.init(16, 104, 160, 24);
    const speed_label_rec: rl.Rectangle = rl.Rectangle.init(16, 80, 120, 24);
    const cell_c_picker_rec: rl.Rectangle = rl.Rectangle.init(16, 208, 136, 96);
    const back_c_picker_rec: rl.Rectangle = rl.Rectangle.init(16, 336, 136, 96);
    const cell_c_label_rec: rl.Rectangle = rl.Rectangle.init(16, 184, 120, 24);
    const back_c_label_rec: rl.Rectangle = rl.Rectangle.init(16, 312, 120, 24);
    const play_toggle_btn_rec: rl.Rectangle = rl.Rectangle.init(16, 56, 80, 24);
    const life_drawable_area: rl.Rectangle = rl.Rectangle.init(216, 24, 552, 408);

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

        rl.clearBackground(rl.getColor(@as(u32, @bitCast(gui.guiGetStyle(component.default, @intFromEnum(default_prop.background_color))))));
        // rl.clearBackground(rl.getColor(0xffffffff));

        // raygui: controls drawing
        //----------------------------------------------------------------------------------
        // Draw controls
        _ = gui.guiPanel(side_panel_rec, null);
        _ = gui.guiPanel(full_panel_rec, null);
        _ = gui.guiLabel(dimension_label_rec, "Random Patterns");
        _ = gui.guiLabel(header_label_rec, "Consway's Game of Life");

        // if (gui.guiValueBox(random_btn_rec, "x:  ", &size_x_value, 5, 96, size_x_editMode) > 0) size_x_editMode = !size_x_editMode;
        _ = gui.guiButton(random_btn_rec, "Generate!");

        _ = gui.guiSliderBar(speed_slider_rec, "", "", &speed_value, 1, 60);
        _ = gui.guiLabel(speed_label_rec, "Speed");

        _ = gui.guiColorPicker(cell_c_picker_rec, "", &cells_color_value);
        _ = gui.guiColorPicker(back_c_picker_rec, "", &background_color_value);

        _ = gui.guiLabel(cell_c_label_rec, "Cells Color");
        _ = gui.guiLabel(back_c_label_rec, "Backgound Color");

        _ = gui.guiToggleGroup(play_toggle_btn_rec, "Stop; Play", &play_toggle_active);
        _ = gui.guiPanel(life_drawable_area, null);
        //----------------------------------------------------------------------------------
    }
}

test "int cast test" {
    const original_unsign: u32 = 0xFFFFFFFF;
    const original_val: i32 = @bitCast(original_unsign);
    std.debug.print("\nOriginal Enum Vals {d}\n", .{original_val});
    std.debug.print("Casted value {d}\n", .{@as(u32, @bitCast(original_val))});
}

const std = @import("std");
const rl = @import("raylib");
const gui = @import("raygui");
const app = @import("app_properties.zig");
const grd = @import("grid.zig");

// load all the constants outside the function
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
const play_toggle_btn_rec: rl.Rectangle = rl.Rectangle.init(16, 56, 160, 24);
const life_drawable_area: rl.Rectangle = rl.Rectangle.init(216, 24, 552, 408);

pub fn renderComponents(app_properties: *app.AppProperties) void {
    _ = gui.guiPanel(side_panel_rec, null);
    _ = gui.guiPanel(full_panel_rec, null);
    _ = gui.guiLabel(dimension_label_rec, "Random Patterns");
    _ = gui.guiLabel(header_label_rec, "Consway's Game of Life");

    // if (gui.guiValueBox(random_btn_rec, "x:  ", &size_x_value, 5, 96, size_x_editMode) > 0) size_x_editMode = !size_x_editMode;
    _ = gui.guiButton(random_btn_rec, "Generate!");

    _ = gui.guiSliderBar(speed_slider_rec, "", "", &app_properties.*.speed_value, 1, 60);
    _ = gui.guiLabel(speed_label_rec, "Speed");

    _ = gui.guiColorPicker(cell_c_picker_rec, "", &app_properties.*.cells_color);
    _ = gui.guiColorPicker(back_c_picker_rec, "", &app_properties.*.background_color);

    _ = gui.guiLabel(cell_c_label_rec, "Cells Color");
    _ = gui.guiLabel(back_c_label_rec, "Backgound Color");

    const toggle_btn_text: [*c]const u8 = if (app_properties.*.play_toggle_active) @as([*c]const u8, @ptrCast("Playing")) else @as([*c]const u8, @ptrCast("Stopped"));

    _ = gui.guiToggle(play_toggle_btn_rec, toggle_btn_text, &app_properties.*.play_toggle_active);
    // _ = gui.guiPanel(life_drawable_area, null);
}

pub fn renderBackground(app_properties: *app.AppProperties) void {
    const background_color = app_properties.*.background_color;
    rl.clearBackground(background_color);

    // TODO: There will be a checking to handle text and component color,
    // if the color is dark, the color of the component will be inverted.
}

pub fn renderGrid(grid: *grd.GameOfLifeGrid(), app_properties: *app.AppProperties) void {
    const base_x = life_drawable_area.x;
    const base_y = life_drawable_area.y;

    const space_x = life_drawable_area.width / @as(f32, @floatFromInt(grid.grid[0].len));
    const space_y = life_drawable_area.height / @as(f32, @floatFromInt(grid.grid.len));

    var y: usize = 0;
    while (y < grid.grid.len) : (y += 1) {
        var x: usize = 0;
        while (x < grid.grid[0].len) : (x += 1) {
            _ = guiCell(10, base_x + space_x * @as(f32, @floatFromInt(x)), base_y + space_y * @as(f32, @floatFromInt(y)), &grid.grid[y][x], app_properties);
        }
    }

    // const active = &grid.grid[0][0];
    // _ = guiCell(10, life_drawable_area.x, life_drawable_area.y, active, app_properties);
}

fn guiCell(size: f32, pos_x: f32, pos_y: f32, active: *bool, app_properties: *app.AppProperties) bool {
    var state = gui.GuiState.state_normal;

    const mouse_location = rl.getMousePosition();
    const rect = rl.Rectangle.init(pos_x, pos_y, size, size);
    const rect_shadow = rl.Rectangle.init(pos_x + 2, pos_y + 2, size, size);
    const rect_clickable = rl.Rectangle.init(pos_x, pos_y, size + 2, size + 2);

    if (rl.checkCollisionPointRec(mouse_location, rect_clickable)) {
        if (rl.isMouseButtonDown(rl.MouseButton.mouse_button_left)) {
            state = gui.GuiState.state_pressed;
        } else if (rl.isMouseButtonReleased(rl.MouseButton.mouse_button_left)) {
            state = gui.GuiState.state_normal;
            active.* = !active.*;
        } else {
            state = gui.GuiState.state_focused;
        }
    }

    if (state == gui.GuiState.state_normal) {
        const color_pressed = if (active.*) app_properties.cells_color else rl.Color.init(0, 0, 0, 0);
        const shadow_pressed = shadow_color(color_pressed, active, app_properties);

        rl.drawRectangleRec(rect_shadow, shadow_pressed);
        rl.drawRectangleRec(rect, color_pressed);
        std.debug.print("print rect normal\n", .{});
    } else {
        var color_focused = app_properties.cells_color;
        color_focused.a = color_focused.a >> 1;

        const color_pressed = if (active.*) color_focused else color_focused;
        const shadow_pressed = shadow_color(color_pressed, active, app_properties);

        rl.drawRectangleRec(rect_shadow, shadow_pressed);
        rl.drawRectangleRec(rect, color_pressed);

        std.debug.print("print rect other\n", .{});
    }

    return active.*;
}

fn shadow_color(color: rl.Color, active: *bool, app_properties: *app.AppProperties) rl.Color {
    _ = app_properties; // app properties is not used yet, but it will be used for handling dark theme.

    if (active.*) {
        const red: u8 = color.r >> 1;
        const green: u8 = color.g >> 1;
        const blue: u8 = color.b >> 1;
        const alpha: u8 = color.a >> 1;

        return rl.Color.init(red, green, blue, alpha);
    } else {
        return rl.Color.init(0, 0, 0, 0);
    }
}

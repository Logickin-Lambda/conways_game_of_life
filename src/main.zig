const std = @import("std");
const rl = @import("raylib");
const gui = @import("raygui");

pub fn main() !void {
    // Initialization
    //--------------------------------------------------------------------------------------
    const screenWidth = 800;
    const screenHeight = 450;

    rl.initWindow(screenWidth, screenHeight, "raylib-zig [core] example - basic window");
    defer rl.closeWindow(); // Close window and OpenGL context

    rl.setTargetFPS(60); // Set our game to run at 60 frames-per-second
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

        rl.clearBackground(rl.Color.white);

        rl.drawText("<!--Skri-A Kaark--> ///Accipiter Nova Zor Se", 150, 200, 20, rl.Color.light_gray);

        const button_bound = rl.Rectangle.init(150, 240, 240, 60);
        gui.guiSetStyle(gui.GuiControl.default, @intFromEnum(gui.GuiDefaultProperty.text_size), 40);
        _ = gui.guiButton(button_bound, "TEST");
        //----------------------------------------------------------------------------------
    }
}

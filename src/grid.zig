const std = @import("std");
const app = @import("app_properties.zig");

pub fn GameOfLifeGrid() type {
    return struct {
        const Self = @This();

        size_x: usize,
        size_y: usize,
        grid: [][]bool,
        allocator: std.mem.Allocator,

        pub fn init(allocator: std.mem.Allocator, size_x: usize, size_y: usize) !Self {
            const rows = try allocator.alloc([]bool, size_y);

            var i: usize = 0;
            while (i < size_y) : (i += 1) {
                const cols = try allocator.alloc(bool, size_x);

                var j: usize = 0;

                while (j < size_x) : (j += 1) {
                    cols[j] = false;
                }

                rows[i] = cols;
            }

            return .{ .size_x = size_x, .size_y = size_y, .grid = rows, .allocator = allocator };
        }

        pub fn deinit(self: *Self) void {

            // deinit the columns in every rows:
            for (self.grid) |row| {
                self.allocator.free(row);
            }

            self.allocator.free(self.grid);
        }

        pub fn step(self: *Self, app_properties: *app.AppProperties) void {
            defer app_properties.*.game_tick += 1;
            if (app_properties.game_tick % (61 - app_properties.*.speed_value) != 60 - app_properties.*.speed_value) {
                return;
            }

            _ = self;
        }
    };
}

test "grid test init" {
    const allocator = std.testing.allocator;

    var grid_5x5 = try GameOfLifeGrid().init(allocator, 3, 3);
    defer grid_5x5.deinit();

    for (grid_5x5.grid) |rows| {
        for (rows) |element| {
            try std.testing.expectEqual(false, element);
        }
    }
}

// This test ensure the the dimension and the assignment is correct.
// if the test is correct, the grid should be in this form:
//
// T F F F
// F T F F
// F F T F
test "grid assignment test" {
    const allocator = std.testing.allocator;
    var grid_5x5 = try GameOfLifeGrid().init(allocator, 4, 3);
    defer grid_5x5.deinit();

    try std.testing.expectEqual(.{ 4, 3 }, .{ grid_5x5.grid[0].len, grid_5x5.grid.len });

    grid_5x5.grid[0][0] = true;
    grid_5x5.grid[1][1] = true;
    grid_5x5.grid[2][2] = true;

    const control_test = [3][4]bool{
        .{ true, false, false, false },
        .{ false, true, false, false },
        .{ false, false, true, false },
    };

    comptime var i = 0;
    inline while (i < control_test.len) : (i += 1) {
        comptime var j = 0;
        inline while (j < control_test[0].len) : (j += 1) {
            try std.testing.expectEqual(control_test[i][j], grid_5x5.grid[i][j]);
        }
    }
}

const std = @import("std");
const app = @import("app_properties.zig");
const builtin = @import("builtin");

const Axis = enum { X, Y };

pub fn GameOfLifeGrid() type {
    return struct {
        const Self = @This();

        size_x: usize,
        size_y: usize,
        grid: [][]bool,
        temp: [][]bool,
        allocator: std.mem.Allocator,

        // Here are all the neighbours next to the cell.
        neighbor_lkup: [8][2]i32 = .{
            .{ -1, -1 },
            .{ -1, 0 },
            .{ -1, 1 },
            .{ 0, -1 },
            .{ 0, 1 },
            .{ 1, -1 },
            .{ 1, 0 },
            .{ 1, 1 },
        },

        pub fn init(allocator: std.mem.Allocator, size_x: usize, size_y: usize) !Self {
            const rows = try allocator.alloc([]bool, size_y);
            const rows_temp = try allocator.alloc([]bool, size_y);

            var i: usize = 0;
            while (i < size_y) : (i += 1) {
                const cols = try allocator.alloc(bool, size_x);
                const cols_temp = try allocator.alloc(bool, size_x);

                var j: usize = 0;

                while (j < size_x) : (j += 1) {
                    cols[j] = false;
                    cols_temp[j] = false;
                }

                rows[i] = cols;
                rows_temp[i] = cols_temp;
            }

            return .{ .size_x = size_x, .size_y = size_y, .grid = rows, .temp = rows_temp, .allocator = allocator };
        }

        pub fn deinit(self: *Self) void {

            // deinit the columns in every rows:
            for (self.grid) |row| {
                self.allocator.free(row);
            }

            for (self.temp) |row| {
                self.allocator.free(row);
            }

            self.allocator.free(self.grid);
            self.allocator.free(self.temp);
        }

        pub fn update(self: *Self, app_properties: *app.AppProperties) void {

            // Handles game tick updates
            const speed_slider = app_properties.speed_value - 1;
            const speed = -(speed_slider * speed_slider) + 1;

            std.debug.print("game tick: {d}\n", .{app_properties.game_tick});

            app_properties.game_tick += speed;

            while (app_properties.game_tick > 1) {
                self.step();
                app_properties.game_tick -= 1;
            }
        }

        fn step(self: *Self) void {
            for (0..self.size_y) |y| {
                for (0..self.size_x) |x| {
                    self.temp[y][x] = self.is_alive(x, y, self.grid[y][x]);
                }
            }

            for (0..self.size_y) |y| {
                for (0..self.size_x) |x| {
                    self.grid[y][x] = self.temp[y][x];
                }
            }
        }

        fn is_alive(self: *Self, pos_x: usize, pos_y: usize, cell_status: bool) bool {
            const neighbours = self.get_neighbor_cells(pos_x, pos_y);

            var live_count: i32 = 0;
            for (neighbours) |neighbour| {
                live_count += if (neighbour) 1 else 0;
            }

            if (cell_status and (live_count == 2 or live_count == 3)) { // if it is alive
                return true;
            } else if (live_count == 3) { // if it is dead
                return true;
            } else {
                return false;
            }
        }

        fn get_neighbor_cells(self: *Self, pos_x: usize, pos_y: usize) [8]bool {
            var neighbours: [8]bool = undefined;

            // extract the neighbors from top left to bottom right
            inline for (0..8) |i| {
                const offset_y = self.neighbor_lkup[i][0];
                const offset_x = self.neighbor_lkup[i][1];
                neighbours[i] = self.grid[self.wrap(pos_y, offset_y, Axis.Y)][self.wrap(pos_x, offset_x, Axis.X)];
            }

            return neighbours;
        }

        fn wrap(self: *Self, pos: usize, offset: i32, axis: Axis) usize {
            const size: usize = if (axis == Axis.X) self.size_x else self.size_y;

            // used for supporting between 32 and 64 bit systems
            const usize_type = if (@bitSizeOf(@TypeOf(pos)) == 64) i64 else i32;

            const pos_int = @as(usize_type, @bitCast(pos)) + offset;

            var result: usize = undefined;

            if (pos_int == size) {
                result = 0;
            } else if (pos_int < 0) {
                result = size - 1;
            } else {
                result = @as(usize, @bitCast(pos_int));
            }

            return result;
        }
    };
}

//_____________________________________________________________
//                                                            /
// UNIT TESTS:                                               /
//__________________________________________________________/

// The most basic operation of the grid, construct and destroy the object,
// and this test ensures no memory leak occur when the object is used.
//
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
// T . . .
// . T . .
// . . T .
//
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

// The test generates a 3x3 grid with a glider on it:
//
// . T .
// T T .
// T . T
//
// With this pattern, I will attempting to get the neighbours
// from the three distinctive cells where they are the diagonals
// of the grid.
//
test "grid neighbour test" {
    const allocator = std.testing.allocator;
    var grid_glider = try GameOfLifeGrid().init(allocator, 3, 3);
    defer grid_glider.deinit();

    // generate glider pattern
    grid_glider.grid[0][1] = true;
    grid_glider.grid[1][0] = true;
    grid_glider.grid[1][1] = true;
    grid_glider.grid[2][0] = true;
    grid_glider.grid[2][2] = true;

    // to ensure the pattern is correct
    const glider_test = [3][3]bool{
        .{ false, true, false },
        .{ true, true, false },
        .{ true, false, true },
    };

    comptime var i = 0;
    inline while (i < glider_test.len) : (i += 1) {
        comptime var j = 0;
        inline while (j < glider_test[0].len) : (j += 1) {
            try std.testing.expectEqual(glider_test[i][j], grid_glider.grid[i][j]);
        }
    }

    // get the neighbour for the middle cell, the result should be boolean from top left left to bottom right
    const middle_neighbour_control = [8]bool{ false, true, false, true, false, true, false, true };
    const middle_neighbour = grid_glider.get_neighbor_cells(1, 1);

    inline for (0..8) |j| {
        try std.testing.expectEqual(middle_neighbour_control[j], middle_neighbour[j]);
    }

    // get the neighbour for top left cell, to test the negative wrapping behavior
    const top_left_neighbour_control = [8]bool{ true, true, false, false, true, false, true, true };
    const top_left_neighbour = grid_glider.get_neighbor_cells(0, 0);

    inline for (0..8) |j| {
        try std.testing.expectEqual(top_left_neighbour_control[j], top_left_neighbour[j]);
    }

    // get the neighbour for bottom right cell, to test the positive wrapping behavior
    const bottom_right_neighbour_control = [8]bool{ true, false, true, false, true, true, false, false };
    const bottom_right_neighbour = grid_glider.get_neighbor_cells(2, 2);

    inline for (0..8) |j| {
        try std.testing.expectEqual(bottom_right_neighbour_control[j], bottom_right_neighbour[j]);
    }
}

// Extend the previous test into a 5x5 grid, and attempt to process the next generation as shown:
//
// . . . . .      . . . . .      . . . . .      . . . . .      . . . . .      . . . . .      . . . . .
// . T . T .      . T . . .      . . T . .      . T . . .      . . . . .      . . . . .      . . . . .
// . T T . .  >>  . T . T .  >>  T T . . .  >>  T . . . .  >>  T . T . .  >>  T . . . .  >>  . T . . . >> ...
// . . T . .      . T T . .      . T T . .      T T T . .      T T . . .      T . T . .      T . . . T
// . . . . .      . . . . .      . . . . .      . . . . .      . T . . .      T T . . .      T T . . .
//
test "grid glider step" {
    const allocator = std.testing.allocator;
    var grid_glider_5x5 = try GameOfLifeGrid().init(allocator, 5, 5);
    defer grid_glider_5x5.deinit();

    // generate glider pattern
    grid_glider_5x5.grid[1][1] = true;
    grid_glider_5x5.grid[1][3] = true;
    grid_glider_5x5.grid[2][1] = true;
    grid_glider_5x5.grid[2][2] = true;
    grid_glider_5x5.grid[3][2] = true;

    // to ensure the pattern is correct
    const grid_glider_5x5_test = [5][5]bool{
        .{ false, false, false, false, false },
        .{ false, true, false, true, false },
        .{ false, true, true, false, false },
        .{ false, false, true, false, false },
        .{ false, false, false, false, false },
    };

    comptime var i = 0;
    inline while (i < grid_glider_5x5_test.len) : (i += 1) {
        comptime var j = 0;
        inline while (j < grid_glider_5x5_test[0].len) : (j += 1) {
            try std.testing.expectEqual(grid_glider_5x5_test[i][j], grid_glider_5x5.grid[i][j]);
        }
    }

    // first step from the initial image
    const step1_test = [5][5]bool{
        .{ false, false, false, false, false },
        .{ false, true, false, false, false },
        .{ false, true, false, true, false },
        .{ false, true, true, false, false },
        .{ false, false, false, false, false },
    };

    grid_glider_5x5.step();

    i = 0;
    inline while (i < step1_test.len) : (i += 1) {
        comptime var j = 0;
        inline while (j < step1_test[0].len) : (j += 1) {
            try std.testing.expectEqual(step1_test[i][j], grid_glider_5x5.grid[i][j]);
        }
    }

    // second step
    const step2_test = [5][5]bool{
        .{ false, false, false, false, false },
        .{ false, false, true, false, false },
        .{ true, true, false, false, false },
        .{ false, true, true, false, false },
        .{ false, false, false, false, false },
    };

    grid_glider_5x5.step();

    i = 0;
    inline while (i < step2_test.len) : (i += 1) {
        comptime var j = 0;
        inline while (j < step2_test[0].len) : (j += 1) {
            try std.testing.expectEqual(step2_test[i][j], grid_glider_5x5.grid[i][j]);
        }
    }

    // after 4 steps, including a wrap around
    const step6_test = [5][5]bool{
        .{ false, false, false, false, false },
        .{ false, false, false, false, false },
        .{ false, true, false, false, false },
        .{ true, false, false, false, true },
        .{ true, true, false, false, false },
    };

    grid_glider_5x5.step();
    grid_glider_5x5.step();
    grid_glider_5x5.step();
    grid_glider_5x5.step();

    i = 0;
    inline while (i < step6_test.len) : (i += 1) {
        comptime var j = 0;
        inline while (j < step6_test[0].len) : (j += 1) {
            try std.testing.expectEqual(step6_test[i][j], grid_glider_5x5.grid[i][j]);
        }
    }
}

test "bit size test" {
    const num: i64 = 69;
    std.debug.print("bit size: {d}\n", .{@bitSizeOf(@TypeOf(num))});

    const num2: i32 = 69;
    std.debug.print("bit size: {d}\n", .{@bitSizeOf(@TypeOf(num2))});
}

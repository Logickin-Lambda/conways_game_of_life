const std = @import("std");
const builtin = @import("builtin");

const PROJECT_NAME = "Zig Raylib Web Assembly Template";
const PROJECT_SOURCE = "src/main.zig";

/// Here are the assets that required to be loaded, and
// fn addAssets(b: *std.Build, exe: *std.Build.Step.Compile) void {
//     const assets = [_]struct { []const u8, []const u8 }{
//         .{ "assets/movesuccess.qoa", "movesuccess" },
//         .{ "assets/movefailed.qoa", "movefailed" },
//         .{ "assets/winner.qoa", "winner" },
//         .{ "assets/barrierhit.qoa", "barrierhit" },
//         .{ "media/qrcode.png", "qrcode" },
//     };

//     for (assets) |asset| {
//         const path, const name = asset;
//         exe.root_module.addAnonymousImport(name, .{ .root_source_file = b.path(path) });
//     }
// }

const App = struct {
    name: []const u8,
    path: std.Build.LazyPath,
};

// wasm references used to create this:
// https://github.com/permutationlock/zig_emscripten_threads/blob/main/build.zig
// https://ziggit.dev/docs?topic=3531
// https://ziggit.dev/t/state-of-concurrency-support-on-wasm32-freestanding/1465/8
// https://ziggit.dev/t/why-suse-offset-converter-is-needed/4131/3
// https://github.com/raysan5/raylib/blob/master/src/build.zig
// https://github.com/silbinarywolf/3d-raylib-toy-project/blob/main/raylib-zig/build.zig
// https://github.com/ziglang/zig/issues/10836
// https://github.com/bluesillybeard/ZigAndRaylibSetup/blob/main/build.zig
// https://github.com/Not-Nik/raylib-zig/issues/24
// https://github.com/raysan5/raylib/wiki/Working-for-Web-%28HTML5%29

// To build the project by following the steps:
// - create directory zig-out\web
// - run command for web assembly:
//     zig build -Dtarget=wasm32-emscripten --sysroot <emsdk installation path>\upstream\emscripten
//   otherwise, use "zig build" to compile the defaults.
pub fn build(b: *std.Build) void {

    // define the basic target information
    //
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const wasm_target = b.resolveTargetQuery(.{
        .cpu_arch = .wasm32,
        .cpu_model = .{ .explicit = &std.Target.wasm.cpu.mvp },
        .cpu_features_add = std.Target.wasm.featureSet(&.{
            .atomics,
            .bulk_memory,
        }),
        .os_tag = .emscripten,
    });
    const is_wasm = target.result.cpu.arch == .wasm32;
    const actual_target = if (is_wasm) wasm_target else target;

    // Dependencies might also requires sysroot, so it might be a better idea to check
    //
    if (b.sysroot == null and is_wasm) {
        @panic("Pass '--sysroot \"[path to emsdk installation]/upstream/emscripten\"'");
    }

    // define all the optimization mode for all dependencies
    //
    const raylib_optimize = b.option(
        std.builtin.OptimizeMode,
        "raylib-optimize",
        "Prioritize performance, safety, or binary size (-O flag), defaults to value of optimize option",
    ) orelse optimize;

    const strip = b.option(
        bool,
        "strip",
        "Strip debug info to reduce binary size, defaults to false",
    ) orelse false;

    // loading the dependencies of each libraries
    //
    const raylib_dep = b.dependency("raylib-zig", .{
        .target = actual_target,
        .optimize = raylib_optimize,
        .rmodels = false,
    });

    const raylib = raylib_dep.module("raylib"); // main raylib module
    const raygui = raylib_dep.module("raygui"); // raygui module
    const raylib_artifact = raylib_dep.artifact("raylib");

    // define the name and the source of the project
    //
    const app = App{
        .name = PROJECT_NAME,
        .path = b.path(PROJECT_SOURCE),
    };

    // define the build procedure in different platforms
    //
    if (is_wasm) {
        // Define the executables used for web assembly
        //
        const exe_lib = b.addStaticLibrary(.{
            .name = app.name,
            .root_source_file = app.path,
            .target = wasm_target,
            .optimize = optimize,
            .link_libc = true,
        });
        // exe_lib.shared_memory = true;
        // TODO currently deactivated because it seems as if it doesn't work with local hosting debug workflow
        exe_lib.shared_memory = false;
        exe_lib.root_module.single_threaded = false;

        exe_lib.linkLibrary(raylib_artifact);
        exe_lib.root_module.addImport("raylib", raylib);
        exe_lib.root_module.addImport("raygui", raygui);
        // exe_lib.addIncludePath(raylib_dep.path("src"));

        const sysroot_include = b.pathJoin(&.{ b.sysroot.?, "cache", "sysroot", "include" });
        var dir = std.fs.openDirAbsolute(sysroot_include, std.fs.Dir.OpenDirOptions{ .access_sub_paths = true, .no_follow = true }) catch @panic("No emscripten cache. Generate it!");
        dir.close();

        exe_lib.addIncludePath(.{ .cwd_relative = sysroot_include });
        // addAssets(b, exe_lib);

        // Loading emsdk for building the webassembly executable, and running it using commands
        //
        const emcc_exe = switch (builtin.os.tag) { // TODO bundle emcc as a build dependency
            .windows => "emcc.bat",
            else => "emcc",
        };

        const emcc_exe_path = b.pathJoin(&.{ b.sysroot.?, emcc_exe });
        const emcc_command = b.addSystemCommand(&[_][]const u8{emcc_exe_path});

        // Here is the tricky part because it involve Emscripten Commands, and I decided to
        // study the meaning behind of these commands. The purpose of the commands are the following:
        // -o                           : output command
        // zig-out/web/index.html       : export path
        // -sFULL-ES3=1                 : OpenGL setting: using ES 3.0,
        // -sUSE_GLFW=3                 : Contrib Ports. using GLFW (Graphics Library Framework) with OpenGL
        //                                and the number stands for the version, which is version 3
        // -O3                          : Optimisation level, level 3 (O3) is common for Production Release
        // -sASYNCIFY                   : The methods used for bridging between synchronous and asynchronous
        //                                languages. There are two methods available: ASYNCIFY and JSPI
        // -sAUDIO_WORKLET              : Enable custom audio processor, extended from Web Audio API
        // -sWASM_WORKERS               : WASM workers api, supporting Multithreaded process by enabling
        //                                web workers and shared array buffer in the web assembly memory.
        // -pthread                     : compiler flag for enabling multithread, usually pair with
        // -sPTHREAD_POOL_SIZE          : for stating the number thread, or use all available using
        //                                navigator.hardwareConcurrency
        // -sINITIAL_MEMORY             : The initial memory allocation size, 160 mb in this example
        // -sEXPORTED_FUNCTIONS         : This is used for expose the mentioned function into public.
        //                              : This example expose the main and _builtin_return_address functions
        // -EXPORTED_RUNTIME_METHODS    : expose runtime functions ccall and cwrap
        // -sUSE_OFFSET_CONVERTER       : as the source code suggested, seems the zig allocator requires the
        //                                offset converter, but not sure why. I will take a research for that
        // --shell-file                 : This states that the build expects skeleton HTML file for the App,
        //                                and you have to provide the location of that HTML file
        //
        // For other command, we may search for the documentation:
        //
        //
        emcc_command.addArgs(&[_][]const u8{
            "-o",
            "zig-out/web/index.html",
            "-sFULL-ES3=1",
            "-sUSE_GLFW=3",
            "-O3",

            // "-sAUDIO_WORKLET=1",
            // "-sWASM_WORKERS=1",
            "-sASYNCIFY",
            // TODO currently deactivated because it seems as if it doesn't work with local hosting debug workflow
            // "-pthread",
            // "-sPTHREAD_POOL_SIZE=4",

            "-sINITIAL_MEMORY=167772160",
            //"-sEXPORTED_FUNCTIONS=_main,__builtin_return_address",

            // USE_OFFSET_CONVERTER required for @returnAddress used in
            // std.mem.Allocator interface
            "-sUSE_OFFSET_CONVERTER",
            "--shell-file",
            b.path("src/shell.html").getPath(b),
        });

        const link_items: []const *std.Build.Step.Compile = &.{
            raylib_artifact,
            exe_lib,
        };
        for (link_items) |item| {
            emcc_command.addFileArg(item.getEmittedBin());
            emcc_command.step.dependOn(&item.step);
        }

        const install = emcc_command;
        b.default_step.dependOn(&install.step);
    } else {
        // This handles the executables for the default device
        //
        const exe = b.addExecutable(.{
            .name = app.name,
            .root_source_file = app.path,
            .target = target,
            .optimize = optimize,
        });
        // addAssets(b, exe);
        exe.root_module.strip = strip;
        exe.linkLibrary(raylib_artifact);
        exe.root_module.addImport("raylib", raylib);
        exe.root_module.addImport("raygui", raygui);

        b.installArtifact(exe);

        const run_cmd = b.addRunArtifact(exe);
        run_cmd.step.dependOn(b.getInstallStep());
        if (b.args) |args| {
            run_cmd.addArgs(args);
        }

        const run_step = b.step("run", "Run the app");
        run_step.dependOn(&run_cmd.step);

        const unit_tests = b.addTest(.{
            .root_source_file = b.path("src/main.zig"),
            .target = target,
            .optimize = optimize,
        });
        // addAssets(b, unit_tests);

        const run_unit_tests = b.addRunArtifact(unit_tests);
        const test_step = b.step("test", "Run unit tests");
        test_step.dependOn(&run_unit_tests.step);
    }
}

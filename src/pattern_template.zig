const std = @import("std");

const o = true;
const x = false;

pub fn getGliderGunPattern() [34]i64 {
    return [34]i64{ 0, 33554432, 41943040, 103085531136, 103085576192, 6424582, 42371078, 33687552, 69632, 24576, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3298534883328, 1099511627776, 15393162788864, 8796093022208, 0, 0, 0 };
}

// pub fn getGliderGunPattern() [34][46]bool {
//     return [34][46]bool{
//         .{ x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x },
//         .{ x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, o, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x },
//         .{ x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, o, x, o, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x },
//         .{ x, x, x, x, x, x, x, x, x, x, x, x, x, o, o, x, x, x, x, x, x, o, o, x, x, x, x, x, x, x, x, x, x, x, x, o, o, x, x, x, x, x, x, x, x, x },
//         .{ x, x, x, x, x, x, x, x, x, x, x, x, o, x, x, x, o, x, x, x, x, o, o, x, x, x, x, x, x, x, x, x, x, x, x, o, o, x, x, x, x, x, x, x, x, x },
//         .{ x, o, o, x, x, x, x, x, x, x, x, o, x, x, x, x, x, o, x, x, x, o, o, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x },
//         .{ x, o, o, x, x, x, x, x, x, x, x, o, x, x, x, o, x, o, o, x, x, x, x, o, x, o, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x },
//         .{ x, x, x, x, x, x, x, x, x, x, x, o, x, x, x, x, x, o, x, x, x, x, x, x, x, o, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x },
//         .{ x, x, x, x, x, x, x, x, x, x, x, x, o, x, x, x, o, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x },
//         .{ x, x, x, x, x, x, x, x, x, x, x, x, x, o, o, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x },
//         .{ x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x },
//         .{ x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x },
//         .{ x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x },
//         .{ x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x },
//         .{ x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x },
//         .{ x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x },
//         .{ x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x },
//         .{ x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x },
//         .{ x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x },
//         .{ x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x },
//         .{ x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x },
//         .{ x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x },
//         .{ x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x },
//         .{ x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x },
//         .{ x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x },
//         .{ x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x },
//         .{ x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x },
//         .{ x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, o, o, x, x, x, x },
//         .{ x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, o, x, x, x, x, x },
//         .{ x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, o, o, o, x, x },
//         .{ x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, o, x, x },
//         .{ x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x },
//         .{ x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x },
//         .{ x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x },
//     };
// }

pub fn getSpaceShipsPattern() [34]i64 {
    return [34]i64{ 0, 0, 0, 112, 144, 16, 16, 160, 0, 268468224, 268468224, 671170560, 268468336, 268468368, 150011920, 15728912, 252641296, 160, 1752380473344, 412343599104, 412316860416, 2834678415360, 2216203124736, 112, 2216203124880, 1752346656784, 1030792151312, 272, 412316860432, 412316860576, 0, 0, 0, 0 };
}

// pub fn getSpaceShipsPattern() [34][46]bool {
//     return [34][46]bool{
//         .{ x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x },
//         .{ x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x },
//         .{ x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x },
//         .{ x, x, x, x, o, o, o, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x },
//         .{ x, x, x, x, o, x, x, o, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x },
//         .{ x, x, x, x, o, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x },
//         .{ x, x, x, x, o, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x },
//         .{ x, x, x, x, x, o, x, o, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x },
//         .{ x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x },
//         .{ x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, o, x, x, x, x, x, x, x, x, x, x, x, x, o, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x },
//         .{ x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, o, x, x, x, x, x, x, x, x, x, x, x, x, o, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x },
//         .{ x, x, x, x, x, x, x, x, x, x, x, x, x, x, o, x, o, x, x, x, x, x, x, x, x, x, x, o, x, o, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x },
//         .{ x, x, x, x, o, o, o, x, x, x, x, x, x, x, x, o, x, x, x, x, x, x, x, x, x, x, x, x, o, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x },
//         .{ x, x, x, x, o, x, x, o, x, x, x, x, x, x, x, o, x, x, x, x, x, x, x, x, x, x, x, x, o, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x },
//         .{ x, x, x, x, o, x, x, x, x, x, x, x, x, x, x, x, o, x, x, x, o, o, o, o, x, x, x, o, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x },
//         .{ x, x, x, x, o, x, x, x, o, x, x, x, x, x, x, x, x, x, x, x, o, o, o, o, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x },
//         .{ x, x, x, x, o, x, x, x, x, x, x, x, x, x, x, x, o, o, o, o, x, x, x, x, o, o, o, o, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x },
//         .{ x, x, x, x, x, o, x, o, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x },
//         .{ x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, o, x, x, x, x, x, x, o, x, x, x, x, x, x, x, x, x, o, o, x, x, o, o, x, x, x, x, x },
//         .{ x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, o, o, x, x, o, o, x, x, x, x, x, x, x, x, x, x, x, x, o, o, x, x, x, x, x, x, x },
//         .{ x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, o, o, x, x, x, x, x, x, x },
//         .{ x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, o, x, o, x, x, o, x, o, x, x, x, x },
//         .{ x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, o, x, x, x, x, x, x, o, x, x, x, x },
//         .{ x, x, x, x, o, o, o, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x },
//         .{ x, x, x, x, o, x, x, o, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, o, x, x, x, x, x, x, o, x, x, x, x },
//         .{ x, x, x, x, o, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, o, o, x, x, o, o, x, x, x, x, x },
//         .{ x, x, x, x, o, x, x, x, o, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, o, o, o, o, x, x, x, x, x, x },
//         .{ x, x, x, x, o, x, x, x, o, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x },
//         .{ x, x, x, x, o, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, o, o, x, x, x, x, x, x, x },
//         .{ x, x, x, x, x, o, x, o, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, o, o, x, x, x, x, x, x, x },
//         .{ x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x },
//         .{ x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x },
//         .{ x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x },
//         .{ x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x },
//     };
// }
pub fn getClocksPattern() [34]i64 {
    return [34]i64{ 0, 0, 131456, 549756731548, 552978088960, 1375464850944, 551097991168, 550575800320, 549808242688, 549795660160, 1374448255360, 549755813888, 549755814368, 393750, 328246, 201398928, 67213904, 939524576, 412853731328, 96, 584115552352, 1133871366144, 2886218022912, 5772436045824, 18141941858336, 18691706060960, 10485768, 6648614617856, 51544375308, 5292288, 10485840, 8388672, 0, 0 };
}

// pub fn getClocksPattern() [34][46]bool {
//     return [34][46]bool{
//         .{ x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x },
//         .{ x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x },
//         .{ x, x, x, x, x, x, x, o, o, x, x, x, x, x, x, x, x, o, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x },
//         .{ x, x, o, o, o, x, x, o, x, x, x, x, x, x, x, x, x, o, o, o, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, o, x, x, x, x, x, x },
//         .{ x, x, x, x, x, x, x, x, x, x, o, x, x, x, x, x, x, x, x, x, o, x, x, x, x, x, x, x, x, x, o, o, x, x, x, x, x, x, x, o, x, x, x, x, x, x },
//         .{ x, x, x, x, x, x, x, x, x, o, o, x, x, x, x, x, x, x, x, o, o, x, x, x, x, x, x, x, x, x, o, x, x, x, x, x, x, x, o, x, o, x, x, x, x, x },
//         .{ x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, o, x, o, x, x, x, x, x, x, x, x, o, x, x, x, x, x, x },
//         .{ x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, o, o, o, x, x, x, x, o, o, x, x, x, x, x, x, x, x, x, o, x, x, x, x, x, x },
//         .{ x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, o, x, x, o, o, x, x, x, x, x, x, x, x, x, x, x, x, x, o, x, x, x, x, x, x },
//         .{ x, x, x, x, x, x, x, o, o, x, x, x, x, x, x, x, x, x, x, x, x, o, o, x, x, o, x, x, x, x, x, x, x, x, x, x, x, x, x, o, x, x, x, x, x, x },
//         .{ x, x, x, x, x, x, x, o, o, x, x, x, x, x, x, x, x, x, x, x, x, x, x, o, o, o, x, x, x, x, x, x, x, x, x, x, x, x, o, x, o, x, x, x, x, x },
//         .{ x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, o, x, x, x, x, x, x },
//         .{ x, x, x, x, x, o, o, o, o, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, o, x, x, x, x, x, x },
//         .{ x, o, o, x, o, x, x, x, x, o, x, x, x, x, x, x, x, o, o, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x },
//         .{ x, o, o, x, o, o, x, x, x, o, x, x, x, x, x, x, o, x, o, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x },
//         .{ x, x, x, x, o, x, x, o, x, o, x, o, o, x, x, x, o, x, x, x, x, x, x, x, x, x, o, o, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x },
//         .{ x, x, x, x, o, x, o, x, x, o, x, o, o, x, x, o, o, x, x, x, x, x, x, x, x, x, o, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x },
//         .{ x, x, x, x, x, o, o, o, o, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, o, o, o, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x },
//         .{ x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, o, x, x, x, x, x, x, x, o, o, x, x, x, x, x, x, x },
//         .{ x, x, x, x, x, o, o, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x },
//         .{ x, x, x, x, x, o, o, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, o, x, x, x, o, x, x, x, x, x, x },
//         .{ x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, o, x, x, x, x, o, x, x, x, x, x },
//         .{ x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, o, x, o, x, o, x, x, x, x },
//         .{ x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, o, x, o, x, o, x, x, x },
//         .{ x, x, x, x, x, o, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, o, x, x, x, x, o, x },
//         .{ x, x, x, x, x, o, x, o, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, o, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, o, x, x, x, o, x },
//         .{ x, x, x, o, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, o, x, o, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x },
//         .{ x, x, x, x, x, x, x, x, o, o, x, x, x, x, x, x, x, x, x, x, o, x, o, x, x, x, x, x, x, x, x, x, x, x, o, o, x, x, x, x, x, o, o, x, x, x },
//         .{ x, x, o, o, x, x, x, x, x, x, x, x, x, x, o, o, x, x, x, o, x, x, o, x, x, x, x, x, x, x, x, x, x, x, o, o, x, x, x, x, x, x, x, x, x, x },
//         .{ x, x, x, x, x, x, x, x, o, x, x, x, x, x, o, o, x, x, x, x, o, x, o, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x },
//         .{ x, x, x, x, o, x, o, x, x, x, x, x, x, x, x, x, x, x, x, x, x, o, x, o, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x },
//         .{ x, x, x, x, x, x, o, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, o, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x },
//         .{ x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x },
//         .{ x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x },
//     };
// }

pub fn getAuthor() [34]i64 {
    return [34]i64{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 132, 65377300906124, 45240271765780, 45240271765792, 29844962018248, 45235976799108, 47435037804296, 1604, 1160, 3570140560, 5726565406, 5726595111, 7874076239, 5592357278, 5462299196, 52472, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
}

// pub fn getAbout() [34][46]bool {
//     return [34][46]bool{
//         .{ x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x },
//         .{ x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x },
//         .{ x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x },
//         .{ x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x },
//         .{ x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x },
//         .{ x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x },
//         .{ x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x },
//         .{ x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x },
//         .{ x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x },
//         .{ x, x, o, x, x, x, x, o, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x },
//         .{ x, x, o, o, x, x, x, o, x, x, x, x, x, x, x, x, x, x, o, o, x, x, o, o, x, o, o, x, o, x, o, o, o, x, o, x, o, o, o, x, o, o, x, o, o, o },
//         .{ x, x, o, x, o, x, x, x, o, x, x, x, x, x, x, x, x, x, o, x, o, x, o, x, x, o, x, x, o, x, o, x, o, x, o, x, x, o, x, x, o, x, x, o, x, o },
//         .{ x, x, x, x, x, o, x, x, o, x, x, x, x, x, x, x, x, x, o, x, o, x, o, x, x, o, x, x, o, x, o, x, o, x, o, x, x, o, x, x, o, x, x, o, x, o },
//         .{ x, x, x, o, x, x, o, o, o, o, x, x, x, x, x, x, x, x, o, o, o, x, o, x, x, o, x, x, o, x, o, o, x, x, o, x, x, o, x, x, o, o, x, o, o, x },
//         .{ x, x, o, x, x, x, x, o, o, o, x, x, x, x, x, x, x, x, o, x, o, x, o, x, x, o, x, x, o, x, o, x, x, x, o, x, x, o, x, x, o, x, x, o, x, o },
//         .{ x, x, x, o, x, x, x, x, o, o, o, x, x, x, x, x, x, x, o, x, o, x, x, o, x, x, o, x, o, x, o, x, x, x, o, x, x, o, x, x, o, o, x, o, x, o },
//         .{ x, x, o, x, x, x, o, x, x, o, o, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x },
//         .{ x, x, x, o, x, x, x, o, x, x, o, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x },
//         .{ x, x, x, x, o, x, x, o, o, x, o, x, x, x, x, x, x, x, o, o, x, x, o, o, x, x, o, x, o, x, o, o, x, x, x, x, x, x, x, x, x, x, x, x, x, x },
//         .{ x, o, o, o, o, x, x, x, x, x, o, x, o, o, o, x, x, x, o, x, o, x, o, x, o, x, o, x, o, x, o, x, o, x, x, x, x, x, x, x, x, x, x, x, x, x },
//         .{ o, o, o, x, x, o, x, x, x, x, x, o, x, o, o, o, x, x, o, x, o, x, o, x, o, x, o, x, o, x, o, x, o, x, x, x, x, x, x, x, x, x, x, x, x, x },
//         .{ o, o, o, o, x, x, o, x, x, o, o, o, o, x, o, o, x, x, o, x, o, x, o, x, o, x, o, x, o, x, o, o, o, x, x, x, x, x, x, x, x, x, x, x, x, x },
//         .{ x, o, o, o, o, x, x, o, o, x, x, o, o, x, x, o, x, x, o, x, o, x, o, x, o, x, o, o, x, x, o, x, o, x, x, x, x, x, x, x, x, x, x, x, x, x },
//         .{ x, x, o, o, o, o, x, x, x, o, x, x, o, x, x, x, x, x, o, x, o, x, x, o, o, x, o, x, x, x, o, x, o, x, x, x, x, x, x, x, x, x, x, x, x, x },
//         .{ x, x, x, o, o, o, o, o, x, x, o, o, x, x, o, o, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x },
//         .{ x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x },
//         .{ x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x },
//         .{ x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x },
//         .{ x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x },
//         .{ x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x },
//         .{ x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x },
//         .{ x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x },
//         .{ x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x },
//         .{ x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x },
//     };
// }

pub fn decode(row: i64) [46]bool {
    var result: [46]bool = undefined;
    var row_temp = row;

    for (0..46) |i| {
        result[i] = row_temp & 1 == 1;
        row_temp >>= 1;
    }

    return result;
}

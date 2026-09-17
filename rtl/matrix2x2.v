module matrix2x2 (
    input wire signed [7:0] a00,
    input wire signed [7:0] a01,
    input wire signed [7:0] a10,
    input wire signed [7:0] a11,

    input wire signed [7:0] b00,
    input wire signed [7:0] b01,
    input wire signed [7:0] b10,
    input wire signed [7:0] b11,

    output wire signed [31:0] c00,
    output wire signed [31:0] c01,
    output wire signed [31:0] c10,
    output wire signed [31:0] c11
);

dot2 dot_c00 (
    .x0(a00),
    .x1(a01),
    .y0(b00),
    .y1(b10),
    .product0(),
    .product1(),
    .result(c00)
);

dot2 dot_c01 (
    .x0(a00),
    .x1(a01),
    .y0(b01),
    .y1(b11),
    .product0(),
    .product1(),
    .result(c01)
);

dot2 dot_c10 (
    .x0(a10),
    .x1(a11),
    .y0(b00),
    .y1(b10),
    .product0(),
    .product1(),
    .result(c10)
);

dot2 dot_c11 (
    .x0(a10),
    .x1(a11),
    .y0(b01),
    .y1(b11),
    .product0(),
    .product1(),
    .result(c11)
);

endmodule
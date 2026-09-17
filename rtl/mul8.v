// Standalone signed multiplier used for introductory exercises.
module mul8 (
    input  wire signed [7:0]  a,
    input  wire signed [7:0]  b,
    output wire signed [15:0] product
);

assign product = a * b;

endmodule

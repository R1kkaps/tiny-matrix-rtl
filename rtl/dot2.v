module dot2 (
    input  wire signed [7:0]  x0,
    input  wire signed [7:0]  x1,
    input  wire signed [7:0]  y0,
    input  wire signed [7:0]  y1,

    output wire signed [15:0] product0,
    output wire signed [15:0] product1,
    output wire signed [31:0] result
);

assign product0 = x0 * y0;
assign product1 = x1 * y1;

// Two signed 16-bit products need 17 bits for their sum.
wire signed [16:0] sum;
assign sum = {product0[15], product0} + {product1[15], product1};
assign result = {{15{sum[16]}}, sum};

endmodule

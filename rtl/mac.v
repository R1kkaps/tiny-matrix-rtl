// Clocked multiply-accumulate exercise; separate from matrix2x2.
module mac(
    input  wire        clk,
    input  wire        rst,
    input  wire        en,
    input  wire signed [7:0]  a,
    input  wire signed [7:0]  b,
    output reg  signed [31:0] acc
);

wire signed [15:0] product;
assign product = a * b;

always @(posedge clk) begin
    if (rst)
        acc <= 0;
    else if (en)
        acc <= acc + product;
end

endmodule

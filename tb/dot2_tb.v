`timescale 1ns / 1ps

module dot2_tb;

reg signed [7:0] x0, x1, y0, y1;
wire signed [15:0] product0, product1;
wire signed [31:0] result;
integer errors;

dot2 dut (
    .x0(x0), .x1(x1), .y0(y0), .y1(y1),
    .product0(product0), .product1(product1), .result(result)
);

initial begin
    errors = 0;

    x0 = 3; x1 = -2; y0 = 4; y1 = 5;
    #10;
    if (product0 !== 16'sd12 || product1 !== -16'sd10 || result !== 32'sd2) begin
        $display("FAIL dot2 signed: products=%0d,%0d result=%0d", product0, product1, result);
        errors = errors + 1;
    end

    // 32768 needs the seventeenth bit of the sum.
    x0 = -128; x1 = -128; y0 = -128; y1 = -128;
    #10;
    if (result !== 32'sd32768) begin
        $display("FAIL dot2 width: result=%0d, expected 32768", result);
        errors = errors + 1;
    end

    if (errors == 0)
        $display("PASS dot2_tb");
    else
        $display("FAIL dot2_tb: %0d error(s)", errors);
    $finish;
end

endmodule

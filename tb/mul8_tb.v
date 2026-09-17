`timescale 1ns / 1ps

module mul8_tb;

reg  signed [7:0]  a;
reg  signed [7:0]  b;
wire signed [15:0] product;
integer errors;

mul8 dut (.a(a), .b(b), .product(product));

initial begin
    errors = 0;

    a = 3; b = 4;
    #10;
    if (product !== 16'sd12) begin
        $display("FAIL mul8: 3 * 4 = %0d, expected 12", product);
        errors = errors + 1;
    end

    a = -2; b = 5;
    #10;
    if (product !== -16'sd10) begin
        $display("FAIL mul8: -2 * 5 = %0d, expected -10", product);
        errors = errors + 1;
    end

    a = -128; b = -128;
    #10;
    if (product !== 16'sd16384) begin
        $display("FAIL mul8: -128 * -128 = %0d, expected 16384", product);
        errors = errors + 1;
    end

    if (errors == 0)
        $display("PASS mul8_tb");
    else
        $display("FAIL mul8_tb: %0d error(s)", errors);
    $finish;
end

endmodule

`timescale 1ns / 1ps

module matrix2x2_tb;

reg signed [7:0] a00, a01, a10, a11;
reg signed [7:0] b00, b01, b10, b11;
wire signed [31:0] c00, c01, c10, c11;
integer errors;

matrix2x2 dut (
    .a00(a00), .a01(a01), .a10(a10), .a11(a11),
    .b00(b00), .b01(b01), .b10(b10), .b11(b11),
    .c00(c00), .c01(c01), .c10(c10), .c11(c11)
);

initial begin
    errors = 0;

    a00 = 1; a01 = 2; a10 = 3; a11 = 4;
    b00 = 5; b01 = 6; b10 = 7; b11 = 8;
    #10;
    if (c00 !== 32'sd19 || c01 !== 32'sd22 ||
        c10 !== 32'sd43 || c11 !== 32'sd50) begin
        $display("FAIL matrix positive: got [%0d %0d; %0d %0d]", c00, c01, c10, c11);
        errors = errors + 1;
    end

    a00 = 1; a01 = -2; a10 = 3; a11 = -4;
    b00 = -5; b01 = 6; b10 = 7; b11 = -8;
    #10;
    if (c00 !== -32'sd19 || c01 !== 32'sd22 ||
        c10 !== -32'sd43 || c11 !== 32'sd50) begin
        $display("FAIL matrix signed: got [%0d %0d; %0d %0d]", c00, c01, c10, c11);
        errors = errors + 1;
    end

    // The first output reaches 32768, beyond a signed 16-bit result.
    a00 = -128; a01 = -128; a10 = 127; a11 = 127;
    b00 = -128; b01 = 127; b10 = -128; b11 = 127;
    #10;
    if (c00 !== 32'sd32768 || c01 !== -32'sd32512 ||
        c10 !== -32'sd32512 || c11 !== 32'sd32258) begin
        $display("FAIL matrix width: got [%0d %0d; %0d %0d]", c00, c01, c10, c11);
        errors = errors + 1;
    end

    if (errors == 0)
        $display("PASS matrix2x2_tb");
    else
        $display("FAIL matrix2x2_tb: %0d error(s)", errors);
    $finish;
end

endmodule

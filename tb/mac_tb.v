`timescale 1ns / 1ps

module mac_tb;

reg clk, rst, en;
reg signed [7:0] a, b;
wire signed [31:0] acc;
integer errors;

mac dut (.clk(clk), .rst(rst), .en(en), .a(a), .b(b), .acc(acc));

always #5 clk = ~clk;

initial begin
    errors = 0;
    clk = 0; rst = 1; en = 0; a = 0; b = 0;

    #6; // Check after the reset clock edge and nonblocking update.
    if (acc !== 32'sd0) begin
        $display("FAIL mac reset: acc=%0d", acc);
        errors = errors + 1;
    end

    #6; rst = 0; en = 1; a = 3; b = 4;
    #4; // Clock edge at 15 ns.
    if (acc !== 32'sd12) begin
        $display("FAIL mac first product: acc=%0d", acc);
        errors = errors + 1;
    end

    a = -2; b = 5;
    #10; // Clock edge at 25 ns.
    if (acc !== 32'sd2) begin
        $display("FAIL mac signed accumulation: acc=%0d", acc);
        errors = errors + 1;
    end

    en = 0;
    #10; // Clock edge at 35 ns; accumulator must hold.
    if (acc !== 32'sd2) begin
        $display("FAIL mac disabled hold: acc=%0d", acc);
        errors = errors + 1;
    end

    if (errors == 0)
        $display("PASS mac_tb");
    else
        $display("FAIL mac_tb: %0d error(s)", errors);
    $finish;
end

endmodule

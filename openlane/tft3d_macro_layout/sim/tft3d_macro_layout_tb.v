`timescale 1ns/1ps

module tft3d_macro_layout_tb;
    reg A;
    reg SEL;
    wire Y;

    tft3d_macro_layout dut (
        .A(A),
        .SEL(SEL),
        .Y(Y)
    );

    initial begin
        A = 0; SEL = 0;
        #1;
        if (Y !== 1'b1) $fatal(1, "expected deselected high output");
        A = 1; SEL = 1;
        #1;
        if (Y !== 1'b0) $fatal(1, "expected selected inverted chain output");
        A = 0; SEL = 1;
        #1;
        if (Y !== 1'b1) $fatal(1, "expected selected inverted chain output");
        $display("digital functional simulation passed");
        $finish;
    end
endmodule

`timescale 1ns / 1ps
module half_adder(input x, input y, output s, output c);
    assign s = x ^ y;
    assign c = x & y;
endmodule
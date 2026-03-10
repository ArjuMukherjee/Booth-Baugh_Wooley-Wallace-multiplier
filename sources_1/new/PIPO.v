`timescale 1ns / 1ps
module PIPO(
    input [15:0] X,
    input en,
    input rst_n,
    input clk,
    output reg [15:0] Y
);
    always@(posedge clk or negedge rst_n) begin
        if(~rst_n) Y <= 16'b0;
        else begin
            if(en) Y <= X;
        end
    end
endmodule

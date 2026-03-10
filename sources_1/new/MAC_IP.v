`timescale 1ns / 1ps
module MAC_IP(
    input clk,
    input [7:0] A,
    input [7:0] B,
    input E,
    input rst_n,
    output [15:0] OUT
);
    
    wire [29:0] PP;
    wire [15:0] acc_out, product;
    
    booth_encoder be(
        .A(A), .B(B), .PP(PP)
    );
        
    hybrid_wallace_tree_acc hwta(
        .PP(PP), .A(acc_out), .Z(product)
    );
    
    PIPO r(
        .en(E), .rst_n(rst_n), .clk(clk),
        .X(product),
        .Y(acc_out)
    );
    
    assign OUT = acc_out;
    
endmodule

`timescale 1ns / 1ps
module hybrid_wallace_tree_acc(
    input [29:0] PP,
    input [15:0] A,
    output [15:0] Z
);
    
    wire s1_1, s1_2, s1_3;
    wire c1_1, c1_2, c1_3;
    
    wire s2_1, s2_2, s2_3, s2_4, s2_5, s2_6, s2_7, s2_8, s2_9;
    wire c2_1, c2_2, c2_3, c2_4, c2_5, c2_6, c2_7, c2_8, c2_9;
    
    wire s3_1, s3_2, s3_3, s3_4, s3_5, s3_6, s3_7, s3_8, s3_9, s3_10, s3_11, s3_12, s3_13;
    wire c3_1, c3_2, c3_3, c3_4, c3_5, c3_6, c3_7, c3_8, c3_9, c3_10, c3_11, c3_12, c3_13;
    
    wire cout1, cout2;
    
    // STAGE 1
    half_adder h1(.x(A[9]),.y(1'b1),.s(s1_1),.c(c1_1));
    half_adder h2(.x(A[10]),.y(1'b1),.s(s1_2),.c(c1_2));
    half_adder h3(.x(A[11]),.y(1'b1),.s(s1_3),.c(c1_3));
    
    // STAGE 2
    half_adder h4(.x(A[6]),.y(PP[20]),.s(s2_1),.c(c2_1));
    
    full_adder f1(.x(PP[14]),.y(PP[21]),.z(A[7]),.s(s2_2),.c(c2_2));
    full_adder f2(.x(PP[15]),.y(PP[22]),.z(A[8]),.s(s2_3),.c(c2_3));
    full_adder f3(.x(PP[9]),.y(PP[16]),.z(s1_1),.s(s2_4),.c(c2_4));
    full_adder f4(.x(PP[17]),.y(c1_1),.z(s1_2),.s(s2_5),.c(c2_5));
    full_adder f5(.x(PP[18]),.y(c1_2),.z(s1_3),.s(s2_6),.c(c2_6));
    full_adder f6(.x(PP[19]),.y(A[12]),.z(c1_3),.s(s2_7),.c(c2_7));
    
    half_adder h5(.x(A[13]),.y(1'b1),.s(s2_8),.c(c2_8));
    half_adder h6(.x(A[14]),.y(1'b1),.s(s2_9),.c(c2_9));
    
    // STAGE 3
    half_adder h7(.x(A[3]),.y(PP[10]),.s(s3_1),.c(c3_1));
    
    full_adder f7(.x(PP[4]),.y(PP[11]),.z(A[4]),.s(s3_2),.c(c3_2));
    full_adder f8(.x(PP[5]),.y(PP[12]),.z(A[5]),.s(s3_3),.c(c3_3));
    full_adder f9(.x(PP[6]),.y(PP[13]),.z(s2_1),.s(s3_4),.c(c3_4));
    full_adder f10(.x(PP[7]),.y(c2_1),.z(s2_2),.s(s3_5),.c(c3_5));
    full_adder f11(.x(PP[8]),.y(c2_2),.z(s2_3),.s(s3_6),.c(c3_6));
    full_adder f12(.x(PP[23]),.y(c2_3),.z(s2_4),.s(s3_7),.c(c3_7));
    full_adder f13(.x(PP[24]),.y(c2_4),.z(s2_5),.s(s3_8),.c(c3_8));
    full_adder f14(.x(PP[25]),.y(c2_5),.z(s2_6),.s(s3_9),.c(c3_9));
    full_adder f15(.x(PP[26]),.y(c2_6),.z(s2_7),.s(s3_10),.c(c3_10));
    full_adder f16(.x(PP[27]),.y(c2_7),.z(s2_8),.s(s3_11),.c(c3_11));
    full_adder f17(.x(PP[28]),.y(c2_8),.z(s2_9),.s(s3_12),.c(c3_12));
    full_adder f18(.x(PP[29]),.y(A[15]),.z(c2_9),.s(s3_13),.c(cout1));
    
    // Ripple Carry ADDER
    ripple_carry_adder rca(
        .A({s3_13, s3_12, s3_11, s3_10, s3_9, s3_8, s3_7, s3_6, s3_5, s3_4, s3_3, s3_2, s3_1, A[2], A[1], A[0]}),
        .B({c3_12, c3_11, c3_10, c3_9, c3_8, c3_7, c3_6, c3_5, c3_4, c3_3, c3_2, c3_1, PP[3], PP[2], PP[1], PP[0]}),
        .C(Z),
        .cout(cout2)
    );
    
endmodule

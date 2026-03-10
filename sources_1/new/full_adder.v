`timescale 1ns / 1ps
module full_adder(input x, input y, input z, output s, output c);
    wire s1, c1, c2;
    half_adder h1(.x(x),.y(y),.s(s1),.c(c1));
    half_adder h2(.x(z),.y(s1),.s(s),.c(c2));
    assign c = c1 | c2;
endmodule
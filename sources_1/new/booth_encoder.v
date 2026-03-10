`timescale 1ns / 1ps
module booth_encoder(
    input [7:0] A,
    input [7:0] B,
    output [29:0] PP
);
    wire [3:0] seq [2:0];
    
    wire [9:0] a_ext = {{2{A[7]}}, A};
    wire [9:0] a_x2  = a_ext << 1;
    wire [9:0] a_x3  = a_x2 + a_ext;
    wire [9:0] a_x4  = a_ext << 2;
    
    reg [9:0] muxout [2:0];
    reg [2:0] negate;
    
    assign seq[0] = {B[2],B[1],B[0],1'b0};
    assign seq[1] = {B[5],B[4],B[3],B[2]};
    assign seq[2] = {B[7],B[7],B[6],B[5]};
    
    integer i;
    
    always@(*) begin
        for(i=0;i<3;i=i+1) begin: enc_inst
            negate[i] = 1'b0;
            case(seq[i])
                4'h0, 4'hf: muxout[i] = 10'b0;
                4'h1, 4'h2: muxout[i] = a_ext;
                4'h3, 4'h4: muxout[i] = a_x2;
                4'h5, 4'h6: muxout[i] = a_x3;
                4'h7:       muxout[i] = a_x4;
                4'h8:       begin muxout[i] = a_x4;  negate[i] = 1'b1; end
                4'h9, 4'ha: begin muxout[i] = a_x3;  negate[i] = 1'b1; end
                4'hb, 4'hc: begin muxout[i] = a_x2;  negate[i] = 1'b1; end
                4'hd, 4'he: begin muxout[i] = a_ext; negate[i] = 1'b1; end
                default:    muxout[i] = 10'b0;
            endcase
        end
    end
    
    assign PP = {
        (negate[2] ? (~muxout[2] + 1'b1) : muxout[2]) ^ 10'h200, // PP[29:20]
        (negate[1] ? (~muxout[1] + 1'b1) : muxout[1]) ^ 10'h200, // PP[19:10]
        (negate[0] ? (~muxout[0] + 1'b1) : muxout[0]) ^ 10'h200  // PP[9:0]
    };
    
endmodule
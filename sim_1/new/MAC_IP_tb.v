`timescale 1ns / 1ps

module MAC_IP_tb;

    // Testbench signals
    reg clk;
    reg rst_n;
    reg E;
    reg signed [7:0] A;
    reg signed [7:0] B;
    wire signed [15:0] OUT;

    // Instantiate DUT
    MAC_IP uut (
        .clk(clk),
        .A(A),
        .B(B),
        .E(E),
        .rst_n(rst_n),
        .OUT(OUT)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;   // 10ns clock period
    end

    initial begin
        $display("Time\tA\tB\tOUT");

        // Reset
        rst_n = 0;
        E = 0;
        A = 0;
        B = 0;
        #20;
        rst_n = 1;
        E = 1;

        // Test case 1
        A = -8'd2; B = 8'd3;
        #10;
        $display("%0t\t%d\t%d\t%d",$time,A,B,OUT);

        // Test case 2
        A = 8'd10; B = 8'd4;
        #10;
        $display("%0t\t%d\t%d\t%d",$time,A,B,OUT);

        // Test case 3
        A = 8'd15; B = 8'd2;
        #10;
        $display("%0t\t%d\t%d\t%d",$time,A,B,OUT);

        // Test case 4
        A = -8'd6; B = 8'd7; E = 1'b0;
        #10;
        $display("%0t\t%d\t%d\t%d",$time,A,B,OUT);

        // Test case 5
        A = -8'd8; B = -8'd3; E = 1'b1;
        #10;
        $display("%0t\t%d\t%d\t%d",$time,A,B,OUT);

        // Random tests
        repeat(10) begin
            A = ($random % 256) - 128;
            B = ($random % 256) - 128;
            #10;
            $display("%0t\t%d\t%d\t%d",$time,A,B,OUT);
        end

        $finish;
    end

endmodule
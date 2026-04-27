`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.02.2025 15:28:51
// Design Name: 
// Module Name: tb_cordic_mod
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_cordic_mod;
    reg clk, rst;
    reg signed [15:0] x, y;
    wire signed [15:0] arctan;
    wire valid;

    // Instantiate the cordic_mod module
    cordic_mod dut (
        .clk(clk),
        .rst(rst),
        .inp_x(x),
        .inp_y(y),
        .arctan(arctan),
        .valid(valid)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        // Initialize signals
        clk = 0;
        rst = 1;
        x = 0;
        y = 0;

        #10 rst = 0; x = 16'h4000; y = 16'h2000;  // Test case 1
        @(posedge valid);
        
        #10 rst = 1; #10 rst = 0; x = 16'h2000; y = 16'h4000;  // Test case 2
        @(posedge valid);
        
        #10 rst = 1; #10 rst = 0; x = -16'h4000; y = 16'h2000; // Test case 3
        @(posedge valid);
        
        #10 rst = 1; #10 rst = 0; x = 16'h4000; y = -16'h2000; // Test case 4
        @(posedge valid);
        
        #10 rst = 1; #10 rst = 0; x = -16'h4000; y = -16'h2000; // Test case 5
        @(posedge valid);
        
        #10 $finish;
    end

    initial begin
        $monitor("Time=%0t x=%h y=%h arctan=%h valid=%b", $time, x, y, arctan, valid);
    end
endmodule

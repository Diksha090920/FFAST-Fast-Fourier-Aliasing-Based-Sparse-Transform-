`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.04.2025 12:54:28
// Design Name: 
// Module Name: tb_ratio_test_true
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




module tb_ratio_test_true;

    // Inputs
    reg clk;
    reg rst;
    reg signed [15:0] inp_x;
    reg signed [15:0] inp_y;

    // inputs
    wire signed [31:0] mult_result;
    wire valid_out;

    // Instantiate the Unit Under Test (UUT)
    ratio_test_true uut (
        .clk(clk),
        .rst(rst),
        .inp_x(inp_x),
        .inp_y(inp_y),
        .mult_result(mult_result),
        .valid_out(valid_out)
    );

    // Clock generation
    initial clk = 0;
    always #5 clk = ~clk;  // 100 MHz clock

    // Stimulus
    initial begin
        // Monitor inputs
        $monitor("Time: %0t | X: %d | Y: %d | mult_result: %d | valid_out: %b",
                  $time, inp_x, inp_y, mult_result, valid_out);

        // Initialize inputs
        rst = 1;
        inp_x = 0;
        inp_y = 0;

        #20;
        rst = 0;

        // Example: Input vector (cos(45°), sin(45°)) = (0.7071, 0.7071)
        // Scaled by 2^15 => 0.7071 * 32768 = 23170
        #10;
        inp_x = 16'sd23170;
        inp_y = 16'sd23170;

        #100;

        // Example: Input vector (cos(30°), sin(30°)) = (0.8660, 0.5)
        // Scaled => 0.8660*32768 ? 28377, 0.5*32768 ? 16384
        inp_x = 16'sd28377;
        inp_y = 16'sd16384;

        #100;

        // Example: (cos(0°), sin(0°)) = (1.0, 0.0)
        inp_x = 16'sd32768;
        inp_y = 16'sd0;

        #100;

        $finish;
    end

endmodule

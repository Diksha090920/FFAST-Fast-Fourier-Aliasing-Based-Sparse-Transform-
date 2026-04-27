`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.02.2025 11:41:44
// Design Name: 
// Module Name: tb_fft_5point
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

module tb_fft_5point;

    // Inputs (16-bit signed fixed-point values)

    reg clk;

    reg rst;

    reg input_valid;

    reg signed [15:0] x0_real, x0_imag;

    reg signed [15:0] x1_real, x1_imag;

    reg signed [15:0] x2_real, x2_imag;

    reg signed [15:0] x3_real, x3_imag;

    reg signed [15:0] x4_real, x4_imag;

    

    // inputs

    wire signed [15:0] X0_real, X0_imag;

    wire signed [15:0] X1_real, X1_imag;

    wire signed [15:0] X2_real, X2_imag;

    wire signed [15:0] X3_real, X3_imag;

    wire signed [15:0] X4_real, X4_imag;

    

    // Instantiate FFT module

    fft_5point uut (

        .clk(clk),

        .rst(rst),

        .input_valid(input_valid),

        .x0_real(x0_real), .x0_imag(x0_imag),

        .x1_real(x1_real), .x1_imag(x1_imag),

        .x2_real(x2_real), .x2_imag(x2_imag),

        .x3_real(x3_real), .x3_imag(x3_imag),

        .x4_real(x4_real), .x4_imag(x4_imag),

        .X0_real(X0_real), .X0_imag(X0_imag),

        .X1_real(X1_real), .X1_imag(X1_imag),

        .X2_real(X2_real), .X2_imag(X2_imag),

        .X3_real(X3_real), .X3_imag(X3_imag),

        .X4_real(X4_real), .X4_imag(X4_imag)

    );

    

    // Clock Generation (100 MHz -> 10 ns period)

    always #5 clk = ~clk;



    initial begin

        // Initialize signals

        clk = 0;

        rst = 1;

        input_valid =0;

        x0_real = 16'bx;  x0_imag =16'bx;

        x1_real = 16'bx; x1_imag = 16'bx;

        x2_real = 16'bx; x2_imag = 16'bx;

        x3_real = 16'bx; x3_imag = 16'bx;

        x4_real = 16'bx; x4_imag =16'bx;



        // Apply Reset (Hold for 20ns)

        #20;

        rst = 0;



        // Apply test inputs on next clock cycle

        #20;

        x0_real = 16'sd122;  x0_imag = 16'sd91;

        x1_real = 16'sd9;   x1_imag = 16'sd45;

        x2_real = 16'sd47;   x2_imag = 16'sd418;

        x3_real = -16'sd87;   x3_imag = 16'sd164;

        x4_real = -16'sd94;   x4_imag = -16'sd107;

        

        input_valid =1;

        #10 input_valid =0;

        

        #20;

        x0_real = 16'sd1;      x0_imag = 16'sd1;

        x1_real = 16'sd578;   x1_imag = 16'sd59;

        x2_real = 16'sd951;   x2_imag = 16'sd102;

        x3_real = 16'sd511;   x3_imag = 16'sd0;

        x4_real = 16'sd5878;   x4_imag = 16'sd0;

        

        input_valid =1;

        #10 input_valid =0;



        // Wait for results (Allow pipeline delay if needed)

        #100;



        // Display results

        $display("X(0) = %d + %di", X0_real, X0_imag);

        $display("X(1) = %d + %di", X1_real, X1_imag);

        $display("X(2) = %d + %di", X2_real, X2_imag);

        $display("X(3) = %d + %di", X3_real, X3_imag);

        $display("X(4) = %d + %di", X4_real, X4_imag);



        // Finish simulation

        #20;

        $stop;

    end

endmodule

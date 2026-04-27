`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.04.2025 17:00:11
// Design Name: 
// Module Name: tb_fft_16point_new
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


module tb_fft_16point_new;
    
    reg clk;
    
    reg rst;
    // Inputs (16-bit signed fixed-point values)
    reg signed [15:0] x0_real, x0_imag;
    reg signed [15:0] x1_real, x1_imag;
    reg signed [15:0] x2_real, x2_imag;
    reg signed [15:0] x3_real, x3_imag;
    reg signed [15:0] x4_real, x4_imag;
    reg signed [15:0] x5_real, x5_imag;
    reg signed [15:0] x6_real, x6_imag;
    reg signed [15:0] x7_real, x7_imag;
    reg signed [15:0] x8_real, x8_imag;
    reg signed [15:0] x9_real, x9_imag;
    reg signed [15:0] x10_real, x10_imag;
    reg signed [15:0] x11_real, x11_imag;
    reg signed [15:0] x12_real, x12_imag;
    reg signed [15:0] x13_real, x13_imag;
    reg signed [15:0] x14_real, x14_imag;
    reg signed [15:0] x15_real, x15_imag;
    
    // inputs
    wire signed [15:0] X0_real, X0_imag;
    wire signed [15:0] X1_real, X1_imag;
    wire signed [15:0] X2_real, X2_imag;
    wire signed [15:0] X3_real, X3_imag;
    wire signed [15:0] X4_real, X4_imag;
    wire signed [15:0] X5_real, X5_imag;
    wire signed [15:0] X6_real, X6_imag;
    wire signed [15:0] X7_real, X7_imag;
    wire signed [15:0] X8_real, X8_imag;
    wire signed [15:0] X9_real, X9_imag;
    wire signed [15:0] X10_real, X10_imag;
    wire signed [15:0] X11_real, X11_imag;
    wire signed [15:0] X12_real, X12_imag;
    wire signed [15:0] X13_real, X13_imag;
    wire signed [15:0] X14_real, X14_imag;
    wire signed [15:0] X15_real, X15_imag;
    

    
    
    // Instantiate FFT module
   fft_16point uut (
        .clk(clk), .rst(rst),
        .x0_real(x0_real), .x0_imag(x0_imag),
        .x1_real(x1_real), .x1_imag(x1_imag),
        .x2_real(x2_real), .x2_imag(x2_imag),
        .x3_real(x3_real), .x3_imag(x3_imag),
        .x4_real(x4_real), .x4_imag(x4_imag),
        .x5_real(x5_real), .x5_imag(x5_imag),
        .x6_real(x6_real), .x6_imag(x6_imag),
        .x7_real(x7_real), .x7_imag(x7_imag),
        .x8_real(x8_real), .x8_imag(x8_imag),
        .x9_real(x9_real), .x9_imag(x9_imag),
        .x10_real(x10_real), .x10_imag(x10_imag),
        .x11_real(x11_real), .x11_imag(x11_imag),
        .x12_real(x12_real), .x12_imag(x12_imag),
        .x13_real(x13_real), .x13_imag(x13_imag),
        .x14_real(x14_real), .x14_imag(x14_imag),
        .x15_real(x15_real), .x15_imag(x15_imag),
        
        .X0_real(X0_real), .X0_imag(X0_imag),
        .X1_real(X1_real), .X1_imag(X1_imag),
        .X2_real(X2_real), .X2_imag(X2_imag),
        .X3_real(X3_real), .X3_imag(X3_imag),
        .X4_real(X4_real), .X4_imag(X4_imag),
        .X5_real(X5_real), .X5_imag(X5_imag),
        .X6_real(X6_real), .X6_imag(X6_imag),
        .X7_real(X7_real), .X7_imag(X7_imag),
        .X8_real(X8_real), .X8_imag(X8_imag),
        .X9_real(X9_real), .X9_imag(X9_imag),
        .X10_real(X10_real), .X10_imag(X10_imag),
        .X11_real(X11_real), .X11_imag(X11_imag),
        .X12_real(X12_real), .X12_imag(X12_imag),
        .X13_real(X13_real), .X13_imag(X13_imag),
        .X14_real(X14_real), .X14_imag(X14_imag),
        .X15_real(X15_real), .X15_imag(X15_imag)
        

    );
    
    always #5 clk=~clk;
    
    initial begin
       clk =0;
       rst=1;
       
        x0_real = 16'bx;   x0_imag = 16'bx;
        x1_real = 16'bx;   x1_imag = 16'bx;
        x2_real = 16'bx;   x2_imag = 16'bx;
        x3_real = 16'bx;   x3_imag = 16'bx;
        x4_real = 16'bx;   x4_imag = 16'bx;
        x5_real = 16'bx;   x5_imag = 16'bx;
        x6_real = 16'bx;   x6_imag = 16'bx;
        x7_real = 16'bx;   x7_imag = 16'bx;
        x8_real = 16'bx;   x8_imag = 16'bx;
        x9_real = 16'bx;   x9_imag =16'bx;
        x10_real = 16'bx;   x10_imag = 16'bx;
        x11_real = 16'bx;   x11_imag = 16'bx;
        x12_real = 16'bx;   x12_imag = 16'bx;
        x13_real = 16'bx;   x13_imag = 16'bx;
        x14_real = 16'bx;   x14_imag = 16'bx;
        x15_real = 16'bx;   x15_imag = 16'bx;
        
        #10;
        rst =0;
        
        #10;
        // Apply test inputs
       // Here I have used Block floating point representaion and the numbers given below are in hexa format 
        x0_real = 16'sd0;      x0_imag = 16'sd0;
        x1_real = 16'sd5878;   x1_imag = 16'sd0;
        x2_real = 16'sd9511;   x2_imag = 16'sd0;
        x3_real = 16'sd9511;   x3_imag = 16'sd0;
        x4_real = 16'sd5878;   x4_imag = 16'sd0;
        x5_real = 16'sd0;      x5_imag = 16'sd0;
        x6_real = -16'sd5878;   x6_imag = 16'sd0;
        x7_real = -16'sd9511;   x7_imag = 16'sd0;
        x8_real = -16'sd9511;   x8_imag = 16'sd0;
        x9_real = -16'sd5878;      x9_imag = 16'sd0;
        x10_real = 16'sd0;   x10_imag = 16'sd0;
        x11_real = 16'sd5878;   x11_imag = 16'sd0;
        x12_real = 16'sd9511;   x12_imag = 16'sd0;
        x13_real = 16'sd9511;   x13_imag = 16'sd0;
        x14_real = 16'sd5878;      x14_imag = 16'sd0;
        x15_real = 16'sd0;   x15_imag = 16'sd0;
        
//        #10
        
//        x0_real = 16'sd1;      x0_imag = 16'sd0;
//        x1_real = 16'sd578;   x1_imag = 16'sd1;
//        x2_real = 16'sd5811;   x2_imag = 16'sd0;
//        x3_real = 16'sd951;   x3_imag = 16'sd152;
//        x4_real = 16'sd5878;   x4_imag = 16'sd0;
//        x5_real = 16'sd0;      x5_imag = 16'sd0;
//        x6_real = -16'sd878;   x6_imag = 16'sd203;
//        x7_real = -16'sd7511;   x7_imag = 16'sd0;
//        x8_real = -16'sd9511;   x8_imag = 16'sd0;
//        x9_real = 16'sd0;      x9_imag = 16'sd0;
//        x10_real = 16'sd5878;   x10_imag = 16'sd0;
//        x11_real = 16'sd9511;   x11_imag = 16'sd0;
//        x12_real = 16'sd9511;   x12_imag = 16'sd0;
//        x13_real = 16'sd5878;   x13_imag = 16'sd0;
//        x14_real = 16'sd0;      x14_imag = 16'sd0;
//        x15_real = -16'sd5878;   x15_imag = 16'sd0;
        
//        #20
        
//        x0_real = 16'sd9000;   x0_imag = 16'sd0;
//        x1_real = 16'sd9000;   x1_imag = 16'sd0;
//        x2_real = 16'sd9000;   x2_imag = 16'sd0;
//        x3_real = 16'sd9000;   x3_imag = 16'sd0;
//        x4_real = 16'sd9000;   x4_imag = 16'sd0;
//        x5_real = 16'sd9000;   x5_imag = 16'sd0;
//        x6_real = 16'sd9000;   x6_imag = 16'sd0;
//        x7_real = 16'sd9000;   x7_imag = 16'sd0;
//        x8_real = 16'sd9000;   x8_imag = 16'sd0;
        
//        // Wait for results
        #40;
        
        // Display results
        $display("X(0) = %d + %di", X0_real, X0_imag);
        $display("X(1) = %d + %di", X1_real, X1_imag);
        $display("X(2) = %d + %di", X2_real, X2_imag);
        $display("X(3) = %d + %di", X3_real, X3_imag);
        $display("X(4) = %d + %di", X4_real, X4_imag);
        $display("X(5) = %d + %di", X5_real, X5_imag);
        $display("X(6) = %d + %di", X6_real, X6_imag);
        $display("X(7) = %d + %di", X7_real, X7_imag);
        $display("X(8) = %d + %di", X8_real, X8_imag);
        $display("X(9) = %d + %di", X9_real, X9_imag);
        $display("X(10) = %d + %di", X10_real, X10_imag);
        $display("X(11) = %d + %di", X11_real, X11_imag);
        $display("X(12) = %d + %di", X12_real, X12_imag);
        $display("X(13) = %d + %di", X13_real, X13_imag);
        $display("X(14) = %d + %di", X14_real, X14_imag);
        $display("X(15) = %d + %di", X15_real, X15_imag);

        // Finish simulation
        #100;
        
      $stop;
    end
    endmodule
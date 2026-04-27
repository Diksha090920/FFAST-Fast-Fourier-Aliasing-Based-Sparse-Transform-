
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.02.2025 12:56:59
// Design Name: 
// Module Name: tb_fft_9point
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


module tb_fft_9point;
    
    reg clk;
    
    reg rst;
    
    reg input_valid;
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
    
    wire signed [15:0] Y1_real, Y1_imag;
    wire signed [15:0] Y4_real, Y4_imag;
    wire signed [15:0] Y7_real, Y7_imag;
    
   // wire signed [15:0] temp1, temp2;
    
    
    // Instantiate FFT module
   fft_9point uut (
        .clk(clk), .rst(rst),
        .input_valid(input_valid),
        .x0_real(x0_real), .x0_imag(x0_imag),
        .x1_real(x1_real), .x1_imag(x1_imag),
        .x2_real(x2_real), .x2_imag(x2_imag),
        .x3_real(x3_real), .x3_imag(x3_imag),
        .x4_real(x4_real), .x4_imag(x4_imag),
        .x5_real(x5_real), .x5_imag(x5_imag),
        .x6_real(x6_real), .x6_imag(x6_imag),
        .x7_real(x7_real), .x7_imag(x7_imag),
        .x8_real(x8_real), .x8_imag(x8_imag),
        
        .X0_real(X0_real), .X0_imag(X0_imag),
        .X1_real(X1_real), .X1_imag(X1_imag),
        .X2_real(X2_real), .X2_imag(X2_imag),
        .X3_real(X3_real), .X3_imag(X3_imag),
        .X4_real(X4_real), .X4_imag(X4_imag),
        .X5_real(X5_real), .X5_imag(X5_imag),
        .X6_real(X6_real), .X6_imag(X6_imag),
        .X7_real(X7_real), .X7_imag(X7_imag),
        .X8_real(X8_real), .X8_imag(X8_imag),
        
        .Y1_real(Y1_real), .Y1_imag(Y1_imag),
        .Y4_real(Y4_real), .Y4_imag(Y4_imag),
        .Y7_real(Y7_real), .Y7_imag(Y7_imag)
        
        //.temp1(temp1), .temp2(temp2)
    );
    
    always #5 clk=~clk;
    
    initial begin
       clk =0;
       rst=1;
        input_valid =0;
        x0_real = 16'bx;   x0_imag = 16'bx;
        x1_real = 16'bx;   x1_imag = 16'bx;
        x2_real = 16'bx;   x2_imag = 16'bx;
        x3_real = 16'bx;   x3_imag = 16'bx;
        x4_real = 16'bx;   x4_imag = 16'bx;
        x5_real = 16'bx;   x5_imag = 16'bx;
        x6_real = 16'bx;   x6_imag = 16'bx;
        x7_real = 16'bx;   x7_imag = 16'bx;
        x8_real = 16'bx;   x8_imag = 16'bx;
        
        #10;
        rst =0;
        
        #10;
        // Apply test inputs
       // Here I have used Block floating point representaion and the numbers given below are in hexa format 
        x0_real = 16'sd137;      x0_imag = -16'sd251;
        x1_real = -16'sd305;      x1_imag = 16'sd59;
        x2_real = -16'sd446;      x2_imag = -16'sd301;
        x3_real = -16'sd154;       x3_imag = 16'sd63;
        x4_real = -16'sd219;      x4_imag = 16'sd48;
        x5_real = 16'sd0;       x5_imag = 16'sd220;
        x6_real = 16'sd108;      x6_imag = 16'sd120;
        x7_real = 16'sd141;     x7_imag = -16'sd176;
        x8_real = -16'sd199;     x8_imag = -16'sd412;
//        input_valid =1;
//        #10 input_valid =0;
        
//        x0_real = 16'sd1;      x0_imag = 16'sd0;
//        x1_real = 16'sd578;   x1_imag = 16'sd1;
//        x2_real = 16'sd5811;   x2_imag = 16'sd0;
//        x3_real = 16'sd951;   x3_imag = 16'sd152;
//        x4_real = 16'sd5878;   x4_imag = 16'sd0;
//        x5_real = 16'sd0;      x5_imag = 16'sd0;
//        x6_real = -16'sd878;   x6_imag = 16'sd203;
//        x7_real = -16'sd7511;   x7_imag = 16'sd0;
//        x8_real = -16'sd9511;   x8_imag = 16'sd0;
//        input_valid =1;
//        #10 input_valid =0; 
////        #20
        
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
        
        $display("Y(1) = %d + %di", Y1_real, Y1_imag);
        $display("Y(4) = %d + %di", Y4_real, Y4_imag);
        $display("Y(7) = %d + %di", Y7_real, Y7_imag);
 
//        $display("temp1 = %d",temp1);
//        $display("temp2 = %d",temp2);
        // Finish simulation
        #100;
        
      $stop;
    end
    endmodule
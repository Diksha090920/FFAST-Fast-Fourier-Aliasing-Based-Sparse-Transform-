`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.04.2025 16:55:16
// Design Name: 
// Module Name: fft_16point
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


module fft_16point(
input clk, rst,
    input wire signed [15:0] x0_real, x0_imag,
    input wire signed [15:0] x1_real, x1_imag,
    input wire signed [15:0] x2_real, x2_imag,
    input wire signed [15:0] x3_real, x3_imag,
    input wire signed [15:0] x4_real, x4_imag,
    input wire signed [15:0] x5_real, x5_imag,
    input wire signed [15:0] x6_real, x6_imag,
    input wire signed [15:0] x7_real, x7_imag,
    input wire signed [15:0] x8_real, x8_imag,
    input wire signed [15:0] x9_real, x9_imag,
    input wire signed [15:0] x10_real, x10_imag,
    input wire signed [15:0] x11_real, x11_imag,
    input wire signed [15:0] x12_real, x12_imag,
    input wire signed [15:0] x13_real, x13_imag,
    input wire signed [15:0] x14_real, x14_imag,
    input wire signed [15:0] x15_real, x15_imag,
   
    
    input reg signed [15:0] X0_real, X0_imag,
    input reg signed [15:0] X1_real, X1_imag,
    input reg signed [15:0] X2_real, X2_imag,
    input reg signed [15:0] X3_real, X3_imag,
    input reg signed [15:0] X4_real, X4_imag,
    input reg signed [15:0] X5_real, X5_imag,
    input reg signed [15:0] X6_real, X6_imag,
    input reg signed [15:0] X7_real, X7_imag,
    input reg signed [15:0] X8_real, X8_imag,
    input reg signed [15:0] X9_real, X9_imag,
    input reg signed [15:0] X10_real, X10_imag,
    input reg signed [15:0] X11_real, X11_imag,
    input reg signed [15:0] X12_real, X12_imag,
    input reg signed [15:0] X13_real, X13_imag,
    input reg signed [15:0] X14_real, X14_imag,
    input reg signed [15:0] X15_real, X15_imag
    
    );
    
    wire signed [15:0] Y0_real, Y0_imag, Y1_real, Y1_imag, Y2_real, Y2_imag, Y3_real, Y3_imag;
    wire signed [15:0] Y4_real, Y4_imag, Y5_real, Y5_imag,Y6_real, Y6_imag,Y7_real, Y7_imag;
    wire signed [15:0] Y8_real, Y8_imag, Y9_real, Y9_imag, Y10_real, Y10_imag, Y11_real, Y11_imag;
    wire signed [15:0] Y12_real, Y12_imag, Y13_real, Y13_imag,Y14_real, Y14_imag,Y15_real, Y15_imag;
    
    reg signed [32:0] temp0_real, temp0_imag;
    reg signed [32:0] temp1_real, temp1_imag;
    reg signed [32:0] temp2_real, temp2_imag;
    reg signed [32:0] temp3_real, temp3_imag;
    reg signed [32:0] temp4_real, temp4_imag;
    reg signed [32:0] temp5_real, temp5_imag;
    reg signed [32:0] temp6_real, temp6_imag;
    reg signed [32:0] temp7_real, temp7_imag;
    reg signed [32:0] temp8_real, temp8_imag;
    reg signed [32:0] temp9_real, temp9_imag;
    reg signed [32:0] temp10_real, temp10_imag;
    reg signed [32:0] temp11_real, temp11_imag;
    reg signed [32:0] temp12_real, temp12_imag;
    reg signed [32:0] temp13_real, temp13_imag;
    reg signed [32:0] temp14_real, temp14_imag;
    reg signed [32:0] temp15_real, temp15_imag;
    
    reg signed [32:0] sum1_real_X0, sum1_imag_X0,sum2_real_X0, sum2_imag_X0, sum3_real_X0, sum3_imag_X0;
    reg signed [32:0] sum1_real_X1, sum1_imag_X1,sum2_real_X1, sum2_imag_X1, sum3_real_X1, sum3_imag_X1;
    reg signed [32:0] sum1_real_X2, sum1_imag_X2,sum2_real_X2, sum2_imag_X2, sum3_real_X2, sum3_imag_X2;
    reg signed [32:0] sum1_real_X3, sum1_imag_X3,sum2_real_X3, sum2_imag_X3, sum3_real_X3, sum3_imag_X3;
    reg signed [32:0] sum1_real_X4, sum1_imag_X4,sum2_real_X4, sum2_imag_X4, sum3_real_X4, sum3_imag_X4;
    reg signed [32:0] sum1_real_X5, sum1_imag_X5,sum2_real_X5, sum2_imag_X5, sum3_real_X5, sum3_imag_X5;
    reg signed [32:0] sum1_real_X6, sum1_imag_X6,sum2_real_X6, sum2_imag_X6, sum3_real_X6, sum3_imag_X6;
    reg signed [32:0] sum1_real_X7, sum1_imag_X7,sum2_real_X7, sum2_imag_X7, sum3_real_X7, sum3_imag_X7;
    reg signed [32:0] sum1_real_X8, sum1_imag_X8,sum2_real_X8, sum2_imag_X8, sum3_real_X8, sum3_imag_X8;
    reg signed [32:0] sum1_real_X9, sum1_imag_X9,sum2_real_X9, sum2_imag_X9, sum3_real_X9, sum3_imag_X9;
    reg signed [32:0] sum1_real_X10, sum1_imag_X10,sum2_real_X10, sum2_imag_X10, sum3_real_X10, sum3_imag_X10;
    reg signed [32:0] sum1_real_X11, sum1_imag_X11,sum2_real_X11, sum2_imag_X11, sum3_real_X11, sum3_imag_X11;
    reg signed [32:0] sum1_real_X12, sum1_imag_X12,sum2_real_X12, sum2_imag_X12, sum3_real_X12, sum3_imag_X12;
    reg signed [32:0] sum1_real_X13, sum1_imag_X13,sum2_real_X13, sum2_imag_X13, sum3_real_X13, sum3_imag_X13;
    reg signed [32:0] sum1_real_X14, sum1_imag_X14,sum2_real_X14, sum2_imag_X14, sum3_real_X14, sum3_imag_X14;
    reg signed [32:0] sum1_real_X15, sum1_imag_X15,sum2_real_X15, sum2_imag_X15, sum3_real_X15, sum3_imag_X15;
 
    fft_4point FFT1 (
    clk,rst, input_valid,
        x0_real, x0_imag, x4_real, x4_imag, x8_real, x8_imag,x12_real, x12_imag,
        Y0_real, Y0_imag, Y1_real, Y1_imag, Y2_real, Y2_imag,Y3_real, Y3_imag
        
    );
    
   fft_4point FFT2 (
    clk,rst, input_valid,
        x1_real, x1_imag, x5_real, x5_imag, x9_real, x9_imag,x13_real, x13_imag,
        Y4_real, Y4_imag, Y5_real, Y5_imag, Y6_real, Y6_imag,Y7_real, Y7_imag
        
    );
    
    fft_4point FFT3 (
    clk,rst, input_valid,
        x2_real, x2_imag, x6_real, x6_imag, x10_real, x10_imag,x14_real, x14_imag,
        Y8_real, Y8_imag, Y9_real, Y9_imag, Y10_real, Y10_imag,Y11_real, Y11_imag
        
    );
   
   fft_4point FFT4 (
    clk,rst, input_valid,
        x3_real, x3_imag, x7_real, x7_imag, x11_real, x11_imag,x15_real, x15_imag,
        Y12_real, Y12_imag, Y13_real, Y13_imag, Y14_real, Y14_imag,Y15_real, Y15_imag
        
    );
    
     // 1) W1= W15
     //2) W2= W14
     //3) W3= W13
     //4) W4 =W12
     //5) W5 =W11
     //6) W6=W10
     //7) W7 =W9
    parameter signed [15:0] W1_real =  16'sd30271;
    parameter signed [15:0] W1_imag = -16'sd12539;
    parameter signed [15:0] W2_real = 16'sd23170;
    parameter signed [15:0] W2_imag = -16'sd23170;
    parameter signed [15:0] W3_real = 16'sd12539;
    parameter signed [15:0] W3_imag = -16'sd30271;
    parameter signed [15:0] W4_real = 16'sd0;
    parameter signed [15:0] W4_imag = -16'sd1;
    parameter signed [15:0] W5_real = -16'sd12539;
    parameter signed [15:0] W5_imag = -16'sd30271;
    parameter signed [15:0] W6_real = -16'sd23170;
    parameter signed [15:0] W6_imag = -16'sd23170;
    parameter signed [15:0] W7_real = -16'sd30271;
    parameter signed [15:0] W7_imag = -16'sd12539;
    parameter signed [15:0] W8_real = -16'sd1;
    parameter signed [15:0] W8_imag = 16'sd0;
    
    always @(posedge clk or posedge rst )begin
         if (rst) begin
             
       
             sum1_real_X1 <=0;  sum1_imag_X1 <=0;
             sum2_real_X1 <=0;  sum2_imag_X1 <=0; 
             sum3_real_X1 <=0;  sum3_imag_X1 <=0;
             
             sum1_real_X2 <=0;  sum1_imag_X2 <=0;
             sum2_real_X2 <=0;  sum2_imag_X2 <=0; 
             sum3_real_X2 <=0;  sum3_imag_X2 <=0;
             
             sum1_real_X3 <=0;  sum1_imag_X3 <=0;
             sum2_real_X3 <=0;  sum2_imag_X3 <=0; 
             sum3_real_X3 <=0;  sum3_imag_X3 <=0;
             
             sum1_real_X4 <=0;  sum1_imag_X4 <=0;
             sum2_real_X4 <=0;  sum2_imag_X4 <=0; 
             sum3_real_X4 <=0;  sum3_imag_X4 <=0;
             
             sum1_real_X5 <=0;  sum1_imag_X5 <=0;
             sum2_real_X5 <=0;  sum2_imag_X5 <=0; 
             sum3_real_X5 <=0;  sum3_imag_X5 <=0;
             
             sum1_real_X6 <=0;  sum1_imag_X6 <=0;
             sum2_real_X6 <=0;  sum2_imag_X6 <=0; 
             sum3_real_X6 <=0;  sum3_imag_X6 <=0;
             
             sum1_real_X7 <=0;  sum1_imag_X7 <=0;
             sum2_real_X7 <=0;  sum2_imag_X7 <=0; 
             sum3_real_X7 <=0;  sum3_imag_X7 <=0;
             
             sum1_real_X8 <=0;  sum1_imag_X8 <=0;
             sum2_real_X8 <=0;  sum2_imag_X8 <=0; 
             sum3_real_X8 <=0;  sum3_imag_X8 <=0;
             
             sum1_real_X9 <=0;  sum1_imag_X9 <=0;
             sum2_real_X9 <=0;  sum2_imag_X9 <=0; 
             sum3_real_X9 <=0;  sum3_imag_X9 <=0;
             
             sum1_real_X10 <=0;  sum1_imag_X10 <=0;
             sum2_real_X10 <=0;  sum2_imag_X10 <=0; 
             sum3_real_X10 <=0;  sum3_imag_X10 <=0;
             
             sum1_real_X11 <=0;  sum1_imag_X11 <=0;
             sum2_real_X11 <=0;  sum2_imag_X11 <=0; 
             sum3_real_X11 <=0;  sum3_imag_X11 <=0;
             
             sum1_real_X12 <=0;  sum1_imag_X12 <=0;
             sum2_real_X12 <=0;  sum2_imag_X12 <=0; 
             sum3_real_X12 <=0;  sum3_imag_X12 <=0;
             
             sum1_real_X13 <=0;  sum1_imag_X13 <=0;
             sum2_real_X13 <=0;  sum2_imag_X13 <=0; 
             sum3_real_X13 <=0;  sum3_imag_X13 <=0;
             
             sum1_real_X14 <=0;  sum1_imag_X14 <=0;
             sum2_real_X14 <=0;  sum2_imag_X14 <=0; 
             sum3_real_X14 <=0;  sum3_imag_X14 <=0;
             
             sum1_real_X15 <=0;  sum1_imag_X15 <=0;
             sum2_real_X15 <=0;  sum2_imag_X15 <=0; 
             sum3_real_X15 <=0;  sum3_imag_X15 <=0;
             
            
         end else begin
    
            sum1_real_X1 <=(W1_real * Y5_real - W1_imag * Y5_imag) >> 15;    sum1_imag_X1 <=(W1_real * Y5_imag + W1_imag * Y5_real) >> 15;
            sum2_real_X1 <=(W2_real * Y9_real - W2_imag * Y9_imag) >> 15;    sum1_imag_X1 <=(W2_real * Y9_imag + W2_imag * Y9_real) >>15 ;
            sum3_real_X1 <=(W3_real * Y13_real - W3_imag * Y13_imag)>>15;    sum1_imag_X1 <=(W3_real * Y13_imag + W3_imag * Y13_real)>>15 ;
            
            sum1_real_X2 <=(W2_real * Y6_real - W2_imag * Y6_imag) >> 15;    sum1_imag_X2 <=(W2_real * Y6_imag + W2_imag * Y6_real) >> 15;
            sum2_real_X2 <= (W4_real * Y10_real - W4_imag * Y10_imag) >>15;  sum2_imag_X2 <=(W4_real * Y10_imag + W4_imag * Y10_real) >>15 ;
            sum3_real_X2 <= (W6_real * Y14_real - W6_imag * Y14_imag)>>15 ;  sum3_imag_X2 <=(W6_real * Y14_imag + W6_imag * Y14_real)>>15;
            
            sum1_real_X3 <=(W3_real * Y7_real - W3_imag * Y7_imag) >> 15;    sum1_imag_X3 <=(W3_real * Y7_imag + W3_imag * Y7_real) >> 15 ;
            sum2_real_X3 <=(W6_real * Y11_real - W6_imag * Y11_imag) >>15;   sum2_imag_X3 <=(W6_real * Y11_imag + W6_imag * Y11_real) >>15 ;
            sum3_real_X3 <= (W7_real * Y15_real - (-W7_imag) * Y15_imag)>>15 ;  sum3_imag_X3 <=(W7_real * Y15_imag + (-W7_imag) * Y15_real)>>15;
            
            sum1_real_X4 <= (W4_real * Y4_real - W4_imag * Y4_imag) >> 15;   sum1_imag_X4 <=(W4_real * Y4_imag + W4_imag * Y4_real) >> 15;
            sum2_real_X4 <= (W8_real * Y8_real - W8_imag * Y8_imag) >>15;   sum2_imag_X4 <=(W8_real * Y8_imag + W8_imag * Y8_real) >>15;
            sum3_real_X4 <=  (W4_real * Y12_real - (-W4_imag) * Y12_imag)>>15; sum3_imag_X4 <= (W4_real * Y12_imag + (-W4_imag) * Y12_real)>>15 
            
            sum1_real_X5 <=   sum1_imag_X5 <=
            sum2_real_X5 <=   sum2_imag_X5 <=
            sum3_real_X5 <=    sum3_imag_X5 <=
            
            sum1_real_X6 <=   sum1_imag_X6 <=
            sum2_real_X6 <=    sum2_imag_X6 <=
            sum3_real_X6 <=    sum3_imag_X6 <=
            
            sum1_real_X7 <=   sum1_imag_X7 <=
            sum2_real_X7 <=   sum2_imag_X7 <=
            sum3_real_X7 <=    sum3_imag_X7 <=
            
            sum1_real_X8 <=   sum1_imag_X8 <=
            sum2_real_X8 <=   sum2_imag_X8 <=
            sum3_real_X8 <=    sum3_imag_X8 <=
            
            sum1_real_X9 <=    sum1_imag_X9 <=
            sum2_real_X9 <=    sum2_imag_X9 <=
            sum3_real_X9 <=    sum3_imag_X9 <=
            
            sum1_real_X10 <=   sum1_imag_X10 <=
            sum2_real_X10 <=   sum2_imag_X10 <=
            sum3_real_X10 <=   sum3_imag_X10 <=
            
            sum1_real_X11 <=   sum1_imag_X11 <=
            sum2_real_X11 <=  sum2_imag_X11 <=
            sum3_real_X11 <=   sum3_imag_X11 <=
            
            sum1_real_X12 <=  sum1_imag_X12 <=
            sum2_real_X12 <=   sum2_imag_X12 <=
            sum3_real_X12 <=   sum3_imag_X12 <=
            
            sum1_real_X13 <=  sum1_imag_X13 <=
            sum2_real_X13 <=   sum2_imag_X13 <=
            sum3_real_X13 <=   sum3_imag_X13 <=
            
            sum1_real_X14 <=   sum1_imag_X14 <=
            sum2_real_X14 <=   sum2_imag_X14 <=
            sum3_real_X14 <=  sum3_imag_X14 <=
            
            sum1_real_X15 <=   sum1_imag_X15 <=
            sum2_real_X15 <=   sum2_imag_X15 <=
            sum3_real_X15 <=  sum3_imag_X15 <=
     
        end 
        end
    
    
     always @(posedge clk  or posedge rst) begin
    if (rst) begin
    X0_real <= 0; X0_imag <=0;
    X1_real <= 0; X1_imag <=0;
    X2_real <= 0; X2_imag <=0;
    X3_real <= 0; X3_imag <=0;
    X4_real <= 0; X4_imag <=0;
    X5_real <= 0; X5_imag <=0;
    X6_real <= 0; X6_imag <=0;
    X7_real <= 0; X7_imag <=0;
    X8_real <= 0; X8_imag <=0;
    X9_real <= 0; X9_imag <=0;
    X10_real <= 0; X10_imag <=0;
    X11_real <= 0; X11_imag <=0;
    X12_real <= 0; X12_imag <=0;
    X13_real <= 0; X13_imag <=0;
    X14_real <= 0; X14_imag <=0;
    X15_real <= 0; X15_imag <=0;
    
   //  data_valid <= 0;
      
    end else begin
    // Second stage: Multiply by twiddle factors and sum results
     temp0_real <=( Y0_real + Y4_real + Y8_real + Y12_real)>>2;  //correct
     temp0_imag <= (Y0_imag + Y4_imag + Y8_imag + Y12_imag)>>2; // correct
    
     temp1_real <= (Y1_real +  sum1_real_X1 + sum2_real_X1 + sum3_real_X1 ) >>2; //correct
     temp1_imag <= ( Y1_imag +  sum1_imag_X1+  sum2_imag_X1 +  sum3_imag_X1 ) >>2;  
    
   
   
    temp2_real <= (Y2_real +  (W2_real * Y6_real - W2_imag * Y6_imag) >> 15 + (W4_real * Y10_real - W4_imag * Y10_imag) >>15 + (W6_real * Y14_real - W6_imag * Y14_imag)>>15 ) >>2; //correct
     temp2_imag <= (Y2_imag + (W2_real * Y6_imag + W2_imag * Y6_real) >> 15 + (W4_real * Y10_imag + W4_imag * Y10_real) >>15 + (W6_real * Y14_imag + W6_imag * Y14_real)>>15 ) >>2;  
    
     temp3_real <= (Y3_real +  (W3_real * Y7_real - W3_imag * Y7_imag) >> 15 + (W6_real * Y11_real - W6_imag * Y11_imag) >>15 + (W7_real * Y15_real - W7_imag * Y15_imag)>>15 ) >>2; //correct
    temp3_imag <= (Y3_imag + (W3_real * Y7_imag + W3_imag * Y7_real) >> 15 + (W6_real * Y11_imag + W6_imag * Y11_real) >>15 + (W7_real * Y15_imag + W7_imag * Y15_real)>>15 ) >>2;  
    
////    assign temp1_imag =( -16'sd28377* Y3_real >>15);
////    assign temp2_imag =((W6_real * Y6_imag + W6_imag * Y6_real) >> 15);
    
     temp4_real <= (Y0_real + (W4_real * Y4_real - W4_imag * Y4_imag) >> 15 + (W8_real * Y8_real - W8_imag * Y8_imag) >>15 +  (W4_real * Y12_real - W4_imag * Y12_imag)>>15 ) >>2; //correct
    temp4_imag <= (Y0_imag + (W4_real * Y4_imag + W4_imag * Y4_real) >> 15 + (W8_real * Y8_imag + W8_imag * Y8_real) >>15 + (W4_real * Y12_imag + W4_imag * Y12_real)>>15 ) >>2;  
    
    temp5_real <= (Y1_real + (W5_real * Y5_real - W5_imag * Y5_imag) >> 15 + (W6_real * Y9_real - W6_imag * Y9_imag) >>15 + (W1_real * Y13_real - W1_imag * Y13_imag)>>15 ) >>2; //correct
  temp5_imag <= (Y1_imag + (W5_real * Y5_imag + W3_imag * Y5_real) >> 15 + (W6_real * Y9_imag + W6_imag * Y9_real) >>15 + (W1_real * Y13_imag + W1_imag * Y13_real)>>15 ) >>2;  
     
    temp6_real <= (Y2_real +  (W6_real * Y6_real - W6_imag * Y6_imag) >> 15 + (W4_real * Y10_real - W4_imag * Y10_imag) >>15 + (W2_real * Y14_real - W2_imag * Y14_imag)>>15 ) >>2; //correct
    temp6_imag <= (Y2_imag + (W6_real * Y6_imag + W6_imag * Y6_real) >> 15 + (W4_real * Y10_imag + W4_imag * Y10_real) >>15 + (W2_real * Y14_imag + W2_imag * Y14_real)>>15 ) >>2;  
    
//    temp7_real <= (Y3_real + (W7_real * Y7_real - W3_imag * Y7_imag) >> 15 + (W2_real * Y11_real - W2_imag * Y11_imag) >>15 + (W5_real * Y15_real - W5_imag * Y15_imag)>>15 ) >>2; //correct
//    temp7_imag <= (Y3_imag + (W7_real * Y7_imag + W3_imag * Y7_real) >> 15 + (W2_real * Y11_imag + W2_imag * Y11_real) >>15 + (W5_real * Y15_imag + W5_imag * Y15_real)>>15 ) >>2;  
    
//    temp8_real <= (Y0_real + (W8_real * Y4_real - W8_imag * Y4_imag) >> 15 + (  1 * Y8_real - 1 * Y8_imag)  + (W8_real * Y12_real - W8_imag * Y12_imag)>>15 ) >>2; //correct
//    temp8_imag <= (Y0_imag + (W8_real * Y4_imag + W8_imag * Y4_real) >> 15 + (1 * Y8_imag + 1* Y8_real) >>15 + (W8_real * Y12_imag + W8_imag * Y12_real)>>15 ) >>2;  
    
//    temp9_real <= (Y1_real + (W7_real * Y5_real - W7_imag * Y5_imag) >> 15 + (W2_real * Y9_real - W2_imag * Y9_imag) >>15 + (W5_real * Y13_real - W5_imag * Y13_imag)>>15 ) >>2; //correct
//    temp9_imag <= (Y1_imag + (W7_real * Y5_imag + W7_imag * Y5_real) >> 15 + (W2_real * Y9_imag + W2_imag * Y9_real) >>15 + (W5_real * Y13_imag + W5_imag * Y13_real)>>15 ) >>2;  
    
//    temp10_real <= (Y2_real + (W6_real * Y6_real - W6_imag * Y6_imag) >> 15 + (W4_real * Y10_real - W4_imag * Y10_imag) >>15 + (W2_real * Y14_real - W2_imag * Y14_imag)>>15 ) >>2; //correct
//    temp10_imag <= (Y2_imag + (W6_real * Y6_imag + W6_imag * Y6_real) >> 15 + (W4_real * Y10_imag + W4_imag * Y10_real) >>15 + (W2_real * Y14_imag + W2_imag * Y14_real)>>15 ) >>2;  
    
//    temp11_real <= (Y3_real + (W5_real * Y7_real - W5_imag * Y7_imag) >> 15 + (W6_real * Y11_real - W6_imag * Y11_imag) >>15 + (W1_real * Y15_real - W1_imag * Y15_imag)>>15 ) >>2; //correct
//    temp11_imag <= (Y3_imag + (W5_real * Y7_imag + W5_imag * Y7_real) >> 15 + (W6_real * Y11_imag + W6_imag * Y11_real) >>15 + (W1_real * Y15_imag + W1_imag * Y15_real)>>15 ) >>2; 
    
//    temp12_real <= (Y0_real + (W4_real * Y4_real - W4_imag * Y4_imag) >> 15 + (W8_real * Y8_real - W8_imag * Y8_imag) >>15 + (W4_real * Y12_real - W4_imag * Y12_imag)>>15 ) >>2; //correct
//    temp12_imag <= (Y0_imag + (W4_real * Y4_imag + W4_imag * Y4_real) >> 15 + (W8_real * Y8_imag + W8_imag * Y8_real) >>15 + (W4_real * Y12_imag + W4_imag * Y12_real)>>15 ) >>2; 
    
//    temp13_real <= (Y1_real + (W3_real * Y5_real - W3_imag * Y5_imag) >> 15 + (W6_real * Y9_real - W6_imag * Y9_imag) >>15 + (W7_real * Y13_real - W7_imag * Y13_imag)>>15 ) >>2; //correct
//    temp13_imag <= (Y1_imag + (W3_real * Y5_imag + W3_imag * Y5_real) >> 15 + (W6_real * Y9_imag + W6_imag * Y9_real) >>15 + (W7_real * Y13_imag + W7_imag * Y13_real)>>15 ) >>2;    
    
//    temp14_real <= (Y2_real + (W4_real * Y6_real - W4_imag * Y6_imag) >> 15 + (W4_real * Y10_real - W4_imag * Y10_imag) >>15 + (W6_real * Y14_real - W6_imag * Y14_imag)>>15 ) >>2; //correct
//    temp14_imag <= (Y2_imag + (W4_real * Y6_imag + W4_imag * Y6_real) >> 15 + (W4_real * Y10_imag + W4_imag * Y10_real) >>15 + (W6_real * Y14_imag + W6_imag * Y14_real)>>15 ) >>2;    
    
//    temp15_real <= (Y3_real + (W1_real * Y7_real - W1_imag * Y7_imag) >> 15 + (W2_real * Y11_real - W2_imag * Y11_imag) >>15 + (W3_real * Y15_real - W3_imag * Y15_imag)>>15 ) >>2; //correct
//    temp15_imag <= (Y3_imag + (W1_real * Y7_imag + W1_imag * Y7_real) >> 15 + (W2_real * Y11_imag + W2_imag * Y11_real) >>15 + (W3_real * Y15_imag + W3_imag * Y15_real)>>15 ) >>2;    
    
    end
    
    end 
    
      always @(posedge clk or posedge rst) begin
        if (rst) begin
    X0_real <= 0; X0_imag <=0;
    X1_real <= 0; X1_imag <=0;
    X2_real <= 0; X2_imag <=0;
    X3_real <= 0; X3_imag <=0;
    X4_real <= 0; X4_imag <=0;
    X5_real <= 0; X5_imag <=0;
    X6_real <= 0; X6_imag <=0;
    X7_real <= 0; X7_imag <=0;
    X8_real <= 0; X8_imag <=0;
    X9_real <= 0; X9_imag <=0;
    X10_real <= 0; X10_imag <=0;
    X11_real <= 0; X11_imag <=0;
    X12_real <= 0; X12_imag <=0;
    X13_real <= 0; X13_imag <=0;
    X14_real <= 0; X14_imag <=0;
    X15_real <= 0; X15_imag <=0;
            
          //  data_valid <= 0;
          //end else if (all_done) begin
        end else begin
            
            X0_real <= temp0_real[15:0];  X0_imag <= temp0_imag[15:0];
            X1_real <= temp1_real[15:0];  X1_imag <= temp1_imag[15:0];
//            X2_real <= temp2_real[15:0];  X2_imag <= temp2_imag[15:0];
//            X3_real <= temp3_real[15:0];  X3_imag <= temp3_imag[15:0];
//            X4_real <= temp4_real[15:0];  X4_imag <= temp4_imag[15:0];
//            X5_real <= temp5_real[15:0];  X5_imag <= temp5_imag[15:0];
//            X6_real <= temp6_real[15:0];  X6_imag <= temp6_imag[15:0];
//            X7_real <= temp7_real[15:0];  X7_imag <= temp7_imag[15:0];
//            X8_real <= temp8_real[15:0];  X8_imag <= temp8_imag[15:0];
//            X9_real <= temp0_real[15:0];  X9_imag <= temp0_imag[15:0];
//            X10_real <= temp1_real[15:0];  X10_imag <= temp1_imag[15:0];
//            X11_real <= temp2_real[15:0];  X11_imag <= temp2_imag[15:0];
//            X12_real <= temp3_real[15:0];  X12_imag <= temp3_imag[15:0];
//            X13_real <= temp4_real[15:0];  X13_imag <= temp4_imag[15:0];
//            X14_real <= temp5_real[15:0];  X14_imag <= temp5_imag[15:0];
//            X15_real <= temp6_real[15:0];  X15_imag <= temp6_imag[15:0];
            

    end
    end
   
endmodule

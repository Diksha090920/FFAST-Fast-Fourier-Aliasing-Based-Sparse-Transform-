
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.02.2025 12:55:59
// Design Name: 
// Module Name: fft_9point
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


module fft_9point (
    input clk, rst,
    input wire input_valid,
    input wire signed [15:0] x0_real, x0_imag,
    input wire signed [15:0] x1_real, x1_imag,
    input wire signed [15:0] x2_real, x2_imag,
    input wire signed [15:0] x3_real, x3_imag,
    input wire signed [15:0] x4_real, x4_imag,
    input wire signed [15:0] x5_real, x5_imag,
    input wire signed [15:0] x6_real, x6_imag,
    input wire signed [15:0] x7_real, x7_imag,
    input wire signed [15:0] x8_real, x8_imag,
    
    output reg signed [15:0] X0_real, X0_imag,
    output reg signed [15:0] X1_real, X1_imag,
    output reg signed [15:0] X2_real, X2_imag,
    output reg signed [15:0] X3_real, X3_imag,
    output reg signed [15:0] X4_real, X4_imag,
    output reg signed [15:0] X5_real, X5_imag,
    output reg signed [15:0] X6_real, X6_imag,
    output reg signed [15:0] X7_real, X7_imag,
    output reg signed [15:0] X8_real, X8_imag,
    
    output wire signed [15:0] Y1_real, Y1_imag,
    output wire signed [15:0] Y4_real, Y4_imag,
    output wire signed [15:0]  Y7_real, Y7_imag
    
   
   
);

    // Using three 3-point FFT modules to compute the 9-point FFT
    wire signed [15:0] Y0_real, Y0_imag, Y1_real, Y1_imag, Y2_real, Y2_imag;
    wire signed [15:0] Y3_real, Y3_imag, Y4_real, Y4_imag, Y5_real, Y5_imag;
    wire signed [15:0] Y6_real, Y6_imag, Y7_real, Y7_imag, Y8_real, Y8_imag;
    
    reg signed [32:0] temp0_real, temp0_imag;
    reg signed [32:0] temp1_real, temp1_imag;
    reg signed [32:0] temp2_real, temp2_imag;
    reg signed [32:0] temp3_real, temp3_imag;
    reg signed [32:0] temp4_real, temp4_imag;
    reg signed [32:0] temp5_real, temp5_imag;
    reg signed [32:0] temp6_real, temp6_imag;
    reg signed [32:0] temp7_real, temp7_imag;
    reg signed [32:0] temp8_real, temp8_imag;
    
//    wire signed [15:0] temp_Y0_real, temp_Y0_imag;
//    wire signed [15:0] temp_Y3_real, temp_Y3_imag;
//    wire signed [15:0] temp_Y6_real, temp_Y6_imag;




    
    // Data valid from each of the 3-point FFT blocks
   // wire  dv0, dv1, dv2;

    // First stage: Compute three 3-point FFTs
    fft_3point FFT1 (
    clk,rst, input_valid,
        x0_real, x0_imag, x3_real, x3_imag, x6_real, x6_imag,
        Y0_real, Y0_imag, Y1_real, Y1_imag, Y2_real, Y2_imag
        
    );
    
   
    fft_3point FFT2 (
    clk,rst, input_valid,
        x1_real, x1_imag, x4_real, x4_imag, x7_real, x7_imag,
        Y3_real, Y3_imag, Y4_real, Y4_imag, Y5_real, Y5_imag
        
    );
    

    fft_3point FFT3 (
    clk,rst, input_valid,
        x2_real, x2_imag, x5_real, x5_imag, x8_real, x8_imag,
        Y6_real, Y6_imag, Y7_real, Y7_imag, Y8_real, Y8_imag
        
    );
    


    // Twiddle factors)
    // Here I have used Block floating point representaion and the numbers given below are in hexa format 
    
    // 1) W1= W10
     //2) W7= W16
     //3) W3= W12
     //4) W5 =W14
    parameter signed [15:0] W1_real =  16'sd25100;
    parameter signed [15:0] W1_imag = -16'sd21069;
    parameter signed [15:0] W2_real = 16'sd5668;
    parameter signed [15:0] W2_imag = -16'sd32276;
    parameter signed [15:0] W3_real = -16'sd16384;
    parameter signed [15:0] W3_imag = -16'sd28377;
    parameter signed [15:0] W4_real = -16'sd30769;
    parameter signed [15:0] W4_imag = -16'sd11206;
    parameter signed [15:0] W5_real = -16'sd30769;
    parameter signed [15:0] W5_imag = 16'sd11206;
    parameter signed [15:0] W6_real = -16'sd16384;
    parameter signed [15:0] W6_imag = 16'sd28377;
    parameter signed [15:0] W7_real = 16'sd5668;
    parameter signed [15:0] W7_imag = 16'sd32276;
    parameter signed [15:0] W8_real = 16'sd25100;
    parameter signed [15:0] W8_imag = 16'sd21069;


    //wire signed [32:0] temp1_imag, temp2_imag ;
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
    
   //  data_valid <= 0;
      
    end else begin
    // Second stage: Multiply by twiddle factors and sum results
     temp0_real <=( Y0_real + Y3_real + Y6_real)>>2; //correct
     temp0_imag <= (Y0_imag + Y3_imag + Y6_imag)>>2;// correct
    
     temp1_real <= (Y1_real + ((W1_real * Y4_real - W1_imag * Y4_imag) >> 15) + ((W2_real * Y7_real - W2_imag * Y7_imag) >> 15))>>2;//correct
     temp1_imag <= (Y1_imag + ((W1_real * Y4_imag + W1_imag * Y4_real) >> 15) + ((W2_real * Y7_imag + W2_imag * Y7_real) >> 15))>>2;
    
    
   
   
     temp2_real <= (Y2_real + ((W2_real * Y5_real - W2_imag * Y5_imag) >> 15) + ((W4_real * Y8_real - W4_imag * Y8_imag) >> 15)) >>2; //correct
     temp2_imag <= (Y2_imag + ((W2_real * Y5_imag + W2_imag * Y5_real) >> 15) + ((W4_real * Y8_imag + W4_imag * Y8_real) >> 15))>>2; //correct
    
     temp3_real <= (Y0_real + ((W3_real * Y3_real - W3_imag * Y3_imag) >> 15) + ((W6_real * Y6_real - W6_imag * Y6_imag) >> 15)) >>2; //correct
     temp3_imag <= (Y0_imag + ((W3_real * Y3_imag + W3_imag * Y3_real) >> 15) + ((W6_real * Y6_imag + W6_imag * Y6_real) >> 15) )>>2; //correct
    
//    assign temp1_imag =( -16'sd28377* Y3_real >>15);
//    assign temp2_imag =((W6_real * Y6_imag + W6_imag * Y6_real) >> 15);
    
     temp4_real <= (Y1_real + ((W4_real * Y4_real - W4_imag * Y4_imag) >> 15) + ((W8_real * Y7_real - W8_imag * Y7_imag) >> 15) )>>2;
     temp4_imag <= (Y1_imag + ((W4_real * Y4_imag + W4_imag * Y4_real) >> 15) + ((W8_real * Y7_imag + W8_imag * Y7_real) >> 15) )>>2;
    
    temp5_real <= (Y2_real + ((W5_real * Y5_real - W5_imag * Y5_imag) >> 15) + ((W1_real * Y8_real - W1_imag * Y8_imag) >> 15) )>>2;
    temp5_imag <= (Y2_imag + ((W5_real * Y5_imag + W5_imag * Y5_real) >> 15) + ((W1_real * Y8_imag + W1_imag * Y8_real) >> 15) )>>2;
    
    temp6_real <= (Y0_real + ((W6_real * Y3_real - W6_imag * Y3_imag) >> 15) + ((W3_real * Y6_real - W3_imag * Y6_imag) >> 15) )>>2;
    temp6_imag <= (Y0_imag + ((W6_real * Y3_imag + W6_imag * Y3_real) >> 15) + ((W3_real * Y6_imag + W3_imag * Y6_real) >> 15) )>>2;
    
    temp7_real <= (Y1_real + ((W7_real * Y4_real - W7_imag * Y4_imag) >> 15) + ((W5_real * Y7_real - W5_imag * Y7_imag) >> 15) )>>2;
    temp7_imag <= (Y1_imag + ((W7_real * Y4_imag + W7_imag * Y4_real) >> 15) + ((W5_real * Y7_imag + W5_imag * Y7_real) >> 15) )>>2;
    
    temp8_real <= (Y2_real + ((W8_real * Y5_real - W8_imag * Y5_imag) >> 15) + ((W7_real * Y8_real - W7_imag * Y8_imag) >> 15) )>>2;
    temp8_imag <= (Y2_imag + ((W8_real * Y5_imag + W8_imag * Y5_real) >> 15) + ((W7_real * Y8_imag + W7_imag * Y8_real) >> 15) )>>2;
    
    end
    
    end 
    
     always @(posedge clk or posedge rst) begin
        if (rst) begin
            X0_real <= 0;
            X0_imag <= 0;
            X1_real <= 0;
            X1_imag <= 0;
            X2_real <= 0;
            X2_imag <= 0;
            X3_real <= 0;
            X3_imag <= 0;
            X4_real <= 0;
            X4_imag <= 0;
            X5_real <= 0;
            X5_imag <= 0;
            X6_real <= 0;
            X6_imag <= 0;
            X7_real <= 0;
            X7_imag <= 0;
            X8_real <= 0;
            X8_imag <= 0;
            
          //  data_valid <= 0;
          //end else if (all_done) begin
        end else begin
            
            X0_real <= temp0_real[15:0];
            X0_imag <= temp0_imag[15:0];
            X1_real <= temp1_real[15:0];
            X1_imag <= temp1_imag[15:0];
            X2_real <= temp2_real[15:0];
            X2_imag <= temp2_imag[15:0];
            X3_real <= temp3_real[15:0];
            X3_imag <= temp3_imag[15:0];
            X4_real <= temp4_real[15:0];
            X4_imag <= temp4_imag[15:0];
            X5_real <= temp5_real[15:0];
            X5_imag <= temp5_imag[15:0];
            X6_real <= temp6_real[15:0];
            X6_imag <= temp6_imag[15:0];
            X7_real <= temp7_real[15:0];
            X7_imag <= temp7_imag[15:0];
            X8_real <= temp8_real[15:0];
            X8_imag <= temp8_imag[15:0];
            

    end
    end
endmodule



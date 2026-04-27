`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.04.2025 15:57:10
// Design Name: 
// Module Name: fft_4point
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



module fft_4point(
input clk, rst,
    
    input wire input_valid,
    input wire signed [15:0] x0_real, x0_imag,
    input wire signed [15:0] x1_real, x1_imag,
    input wire signed [15:0] x2_real, x2_imag,
    input wire signed [15:0] x3_real, x3_imag,
    
    output reg signed [15:0] X0_real, X0_imag,
    output reg signed [15:0] X1_real, X1_imag,
    output reg signed [15:0] X2_real, X2_imag,
    output reg signed [15:0] X3_real, X3_imag
   
    );
    
    reg signed [16:0] sum1_real, sum1_imag;
    reg signed [16:0] sum2_real, sum2_imag;
    reg signed [16:0] diff1_real, diff1_imag;
    reg signed [16:0] diff2_real, diff2_imag;
    
    wire signed [15:0] inter_x0_real, inter_x0_imag;
    wire signed [15:0] inter_x1_real, inter_x1_imag;
    wire signed [15:0] inter_x2_real, inter_x2_imag;
    wire signed [15:0] inter_x3_real, inter_x3_imag;
    
    D_flip_flop d1 (.clk(clk), .rst(rst), .d(x0_real), .q(inter_x0_real));
    D_flip_flop d2 (.clk(clk), .rst(rst), .d(x0_imag), .q(inter_x0_imag));
    D_flip_flop d3 (.clk(clk), .rst(rst), .d(x1_real), .q(inter_x1_real));  
    D_flip_flop d4 (.clk(clk), .rst(rst), .d(x1_imag), .q(inter_x1_imag));
    D_flip_flop d5 (.clk(clk), .rst(rst), .d(x2_real), .q(inter_x2_real));
    D_flip_flop d6 (.clk(clk), .rst(rst), .d(x2_imag), .q(inter_x2_imag));
    D_flip_flop d7 (.clk(clk), .rst(rst), .d(x3_real), .q(inter_x3_real));
    D_flip_flop d8 (.clk(clk), .rst(rst), .d(x3_imag), .q(inter_x3_imag));
    
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            sum1_real <= 0;
            sum1_imag <= 0;
            sum2_real <= 0;
            sum2_imag <= 0;
            diff1_real <= 0;
            diff1_imag <= 0;
            diff2_real <= 0;
            diff2_imag <= 0;
        end else begin
            sum1_real <= inter_x0_real + inter_x2_real;
            sum1_imag <= inter_x0_imag + inter_x2_imag;
            sum2_real <= inter_x1_real + inter_x3_real;
            sum2_imag <= inter_x1_imag + inter_x3_imag;
            diff1_real <= inter_x0_real - inter_x2_real;
            diff1_imag <= inter_x0_imag - inter_x2_imag;
            diff2_real <= inter_x1_real - inter_x3_real;
            diff2_imag <= inter_x1_imag - inter_x3_imag;
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
           // data_valid <=0;
        end else begin
            X0_real <= (sum1_real + sum2_real)>>2;
            X0_imag <= (sum1_imag + sum2_imag)>>2;
            X1_real <= (diff1_real + diff2_imag)>>2;
            X1_imag <=( diff1_imag - diff2_real)>>2 ;
            X2_real <= (sum1_real - sum2_real)>>2;
            X2_imag <= (sum2_imag - sum1_imag)>>2;
            X3_real <= (diff1_real - diff2_imag)>>2;
            X3_imag <=  (diff1_imag + diff2_real)>>2;
           
        end
    end
    
endmodule

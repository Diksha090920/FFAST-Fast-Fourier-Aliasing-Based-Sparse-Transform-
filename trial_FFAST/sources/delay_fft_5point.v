`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.04.2025 11:13:17
// Design Name: 
// Module Name: delay_fft_5point
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


module delay_fft_5point(

    input clk, rst,
    input wire input_valid,
    
    input wire signed [15:0] x0_real, x0_imag,
    input wire signed [15:0] x1_real, x1_imag,
    input wire signed [15:0] x2_real, x2_imag,
    input wire signed [15:0] x3_real, x3_imag,
    input wire signed [15:0] x4_real, x4_imag,

    output reg signed [15:0] X0_real, X0_imag,
    output reg signed [15:0] X1_real, X1_imag,
    output reg signed [15:0] X2_real, X2_imag,
    output reg signed [15:0] X3_real, X3_imag,
    output reg signed [15:0] X4_real, X4_imag
    
    );
    
wire [15:0] x0_real_d1, x0_real_d2, x1_real_d1, x1_real_d2, x2_real_d1, x2_real_d2;
wire [15:0] x3_real_d1, x3_real_d2, x4_real_d1, x4_real_d2;
wire [15:0] x0_imag_d1, x0_imag_d2, x1_imag_d1, x1_imag_d2, x2_imag_d1, x2_imag_d2;
wire [15:0] x3_imag_d1, x3_imag_d2, x4_imag_d1, x4_imag_d2;

// Real part delays
D_flip_flop d_x0r_1 (.clk(clk), .rst(rst), .d(x0_real), .q(x0_real_d1));
D_flip_flop d_x0r_2 (.clk(clk), .rst(rst), .d(x0_real_d1), .q(x0_real_d2));
//D_flip_flop d_x0r_3 (.clk(clk), .rst(rst), .d(x0_real_d2), .q(x0_real_delayed));

D_flip_flop d_x1r_1 (.clk(clk), .rst(rst), .d(x1_real), .q(x1_real_d1));
D_flip_flop d_x1r_2 (.clk(clk), .rst(rst), .d(x1_real_d1), .q(x1_real_d2));
//D_flip_flop d_x1r_3 (.clk(clk), .rst(rst), .d(x1_real_d2), .q(x1_real_delayed));

D_flip_flop d_x2r_1 (.clk(clk), .rst(rst), .d(x2_real), .q(x2_real_d1));
D_flip_flop d_x2r_2 (.clk(clk), .rst(rst), .d(x2_real_d1), .q(x2_real_d2));
//D_flip_flop d_x2r_3 (.clk(clk), .rst(rst), .d(x2_real_d2), .q(x2_real_delayed));

D_flip_flop d_x3r_1 (.clk(clk), .rst(rst), .d(x3_real), .q(x3_real_d1));
D_flip_flop d_x3r_2 (.clk(clk), .rst(rst), .d(x3_real_d1), .q(x3_real_d2));
//D_flip_flop d_x3r_3 (.clk(clk), .rst(rst), .d(x3_real_d2), .q(x3_real_delayed));

D_flip_flop d_x4r_1 (.clk(clk), .rst(rst), .d(x4_real), .q(x4_real_d1));
D_flip_flop d_x4r_2 (.clk(clk), .rst(rst), .d(x4_real_d1), .q(x4_real_d2));
//D_flip_flop d_x4r_3 (.clk(clk), .rst(rst), .d(x4_real_d2), .q(x4_real_delayed));

// Imaginary part delays
D_flip_flop d_x0i_1 (.clk(clk), .rst(rst), .d(x0_imag), .q(x0_imag_d1));
D_flip_flop d_x0i_2 (.clk(clk), .rst(rst), .d(x0_imag_d1), .q(x0_imag_d2));
//D_flip_flop d_x0i_3 (.clk(clk), .rst(rst), .d(x0_imag_d2), .q(x0_imag_delayed));

D_flip_flop d_x1i_1 (.clk(clk), .rst(rst), .d(x1_imag), .q(x1_imag_d1));
D_flip_flop d_x1i_2 (.clk(clk), .rst(rst), .d(x1_imag_d1), .q(x1_imag_d2));
//D_flip_flop d_x1i_3 (.clk(clk), .rst(rst), .d(x1_imag_d2), .q(x1_imag_delayed));

D_flip_flop d_x2i_1 (.clk(clk), .rst(rst), .d(x2_imag), .q(x2_imag_d1));
D_flip_flop d_x2i_2 (.clk(clk), .rst(rst), .d(x2_imag_d1), .q(x2_imag_d2));
//D_flip_flop d_x2i_3 (.clk(clk), .rst(rst), .d(x2_imag_d2), .q(x2_imag_delayed));

D_flip_flop d_x3i_1 (.clk(clk), .rst(rst), .d(x3_imag), .q(x3_imag_d1));
D_flip_flop d_x3i_2 (.clk(clk), .rst(rst), .d(x3_imag_d1), .q(x3_imag_d2));
//D_flip_flop d_x3i_3 (.clk(clk), .rst(rst), .d(x3_imag_d2), .q(x3_imag_delayed));

D_flip_flop d_x4i_1 (.clk(clk), .rst(rst), .d(x4_imag), .q(x4_imag_d1));
D_flip_flop d_x4i_2 (.clk(clk), .rst(rst), .d(x4_imag_d1), .q(x4_imag_d2));
//D_flip_flop d_x4i_3 (.clk(clk), .rst(rst), .d(x4_imag_d2), .q(x4_imag_delayed));

always @(posedge clk or posedge rst) begin

        if (rst) begin

            X0_real <= 0; X0_imag <= 0;
            X1_real <= 0; X1_imag <= 0;
            X2_real <= 0; X2_imag <= 0;
            X3_real <= 0; X3_imag <= 0;
            X4_real <= 0; X4_imag <= 0;
          
        end else begin

            X0_real <=x0_real_d2 ;
            X0_imag <= x0_imag_d2;

            X1_real <=x1_real_d2;
            X1_imag <= x1_imag_d2;
            
            X2_real <= x2_real_d2;
            X2_imag <= x2_imag_d2;

            X3_real <= x3_real_d2;
            X3_imag <=x3_imag_d2;

            X4_real <= x4_real_d2;
            X4_imag <= x4_imag_d2;

        

    end
    
    end
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.04.2025 14:57:36
// Design Name: 
// Module Name: singleton_estimator
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


//module singleton_estimator (
//    input clk,
//    input rst,
//    input signed [15:0] x1_real,
//    input signed [15:0] x1_imag,
//    input signed [15:0] x2_real,
//    input signed [15:0] x2_imag,
   
//    output reg ratio_test_pass
   
//);
//  // wire ratio_test_pass;
//    // Intermediate squared magnitude values
//    reg [31:0] mag1_sq;
//    reg [31:0] mag2_sq;
    
//    wire signed [15:0] inter_x1_real, inter_x1_imag;
//    wire signed [15:0] inter_x2_real, inter_x2_imag;

// D_flip_flop d1 (.clk(clk), .rst(rst), .d(x1_real), .q(inter_x1_real));
// D_flip_flop d2 (.clk(clk), .rst(rst), .d(x1_imag), .q(inter_x1_imag));
// D_flip_flop d3 (.clk(clk), .rst(rst), .d(x2_real), .q(inter_x2_real));
// D_flip_flop d4 (.clk(clk), .rst(rst), .d(x2_imag), .q(inter_x2_imag));
 
 
//    always @(posedge clk or posedge rst) begin
//        if (rst) begin
//            mag1_sq <= 32'd0;
//            mag2_sq <= 32'd0;
//            ratio_test_pass <= 1'b0;
//        end else begin
//            mag1_sq <= inter_x1_real * inter_x1_real + inter_x1_imag * inter_x1_imag;
//            mag2_sq <= inter_x2_real * inter_x2_real + inter_x2_imag * inter_x2_imag;      
//      end
////      if  ((x1_real != 0 || x1_imag != 0 || x2_real != 0 || x2_imag != 0) && (mag1_sq == mag2_sq))
////                ratio_test_pass <= 1'b1;
////            else
////                ratio_test_pass <= 1'b0;
      
//end

//always @ (posedge clk) begin
//            if  ((x1_real != 0 || x1_imag != 0 || x2_real != 0 || x2_imag != 0) && (mag1_sq == mag2_sq))
//                ratio_test_pass <= 1'b1;
//            else
//                ratio_test_pass <= 1'b0;
      
//end
////x1_real != 0 || x1_imag != 0 || x2_real != 0 || x2_imag != 0) &&
////            if (( (mag1_sq == mag2_sq))
////                ratio_test_pass <= 1'b1;
////            else
////                ratio_test_pass <= 1'b0;

//endmodule

module singleton_estimator (
    input clk,
    input rst,
    input signed [15:0] x1_real,
    input signed [15:0] x1_imag,
    input signed [15:0] x2_real,
    input signed [15:0] x2_imag,
    output reg ratio_test_pass,
    output reg data_valid_delay

);

    // Intermediate registers

    reg [31:0] mag1_sq;
    reg [31:0] mag2_sq;
    reg [31:0] diff;
    reg data_valid;

    wire signed [15:0] inter_x1_real, inter_x1_imag;
    wire signed [15:0] inter_x2_real, inter_x2_imag;

    reg first_valid;
    reg first_valid_flag;
    wire data_internal;
    wire data_internal_2;

    parameter [31:0] TOLERANCE = 32'd1000;

    // Input synchronization

    D_flip_flop d1 (.clk(clk), .rst(rst), .d(x1_real), .q(inter_x1_real));
    D_flip_flop d2 (.clk(clk), .rst(rst), .d(x1_imag), .q(inter_x1_imag));
    D_flip_flop d3 (.clk(clk), .rst(rst), .d(x2_real), .q(inter_x2_real));
    D_flip_flop d4 (.clk(clk), .rst(rst), .d(x2_imag), .q(inter_x2_imag));



   //D_flip_flop  d5 (.clk(clk), .rst(rst), .d(first_valid), .q(first_valid_delay));

    // Processing logic

    always @(posedge clk or posedge rst) begin

        if (rst) begin
            mag1_sq <= 0;
            mag2_sq <= 0;
            diff <= 0;
            data_valid <=1'b0;
            ratio_test_pass <= 1'b0;
            first_valid <= 1'b0;
            first_valid_flag <= 1'b0;

        end else begin

            // Magnitude square calculations

            mag1_sq <= inter_x1_real * inter_x1_real + inter_x1_imag * inter_x1_imag;
            mag2_sq <= inter_x2_real * inter_x2_real + inter_x2_imag * inter_x2_imag;
          // Absolute difference

            if ((mag1_sq > mag2_sq) || mag1_sq == mag2_sq) begin
                diff <= mag1_sq - mag2_sq;
               data_valid <=1'b1;
               end
            else begin
                diff <= mag2_sq - mag1_sq;
                data_valid <=1'b1;
             end

            // Only set pass when inputs are not all zero AND diff is below tolerance

            if (data_valid ==1'd1) begin

            if ((inter_x1_real != 0 || inter_x1_imag != 0 || inter_x2_real != 0 || inter_x2_imag != 0) && (diff < TOLERANCE)&& (diff != 1'b0))
            begin
                ratio_test_pass <= 1'b1;
            end

            else begin

                ratio_test_pass <= 1'b0;
               end
        end
      else begin

               ratio_test_pass <= 1'b0;

               end

//            if (data_valid ==1'b1 && !first_valid_flag ) begin
//                  first_valid <=1'b1;
//                  first_valid_flag <=1'b1;

//            end else begin

//            first_valid <=1'b0;
//           end 

    end

    end  
    D_flip_flop  d5 (.clk(clk), .rst(rst), .d(data_valid), .q(data_internal));
     D_flip_flop  d6 (.clk(clk), .rst(rst), .d(data_internal), .q(data_internal_2));
    always @(posedge clk or posedge rst) begin
     if (rst) begin
            data_valid_delay <= 0;
        end else begin
            data_valid_delay <= data_internal_2;
        end
    end

endmodule

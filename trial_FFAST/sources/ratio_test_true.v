`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.04.2025 17:28:55
// Design Name: 
// Module Name: ratio_test_true
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


//module ratio_test_true (
//    input clk, rst,
//    input signed [15:0] inp_x, inp_y,  // from cordic_mod 
//    output reg signed [31:0] mult_result,
//    output reg valid_out
//);

//    // Fixed-point constant: (180 / 2*pi) ~ 28.64 -> scaled by 2^8 = 256 -> 28.64*256 ? 7332
//    // or as per your earlier scale (e.g., by 1000): 28.64*1000 = 28640
    
//    // or if angle is scaled by 2^15 and we want final in degrees*100 -> SCALE_CONST = 8796
//    parameter signed [15:0] SCALE_CONST = 16'sd9;

//    wire signed [15:0] angle_out;
//    wire   cordic_valid;

//    // CORDIC module instantiation
//    cordic_mod uut1 (
//        .clk(clk), .rst(rst),
//        .inp_x(inp_x), .inp_y(inp_y),  // ensure your ports are correctly named
//        .arctan(angle_out),
//        .valid(cordic_valid)
//    );

//    always @(posedge clk or posedge rst) begin
//        if (rst) begin
//            mult_result <= 0;
//            valid_out <= 0;
//        end else begin
//            if (cordic_valid) begin
//                mult_result <= angle_out * SCALE_CONST;  // scaled angle in degrees
//                valid_out <= 1;
//            end else begin
//                valid_out <= 0;
//            end
//        end
//    end

//endmodule

//module ratio_test_true (
//    input clk, rst,
//    input valid_input,
//    input signed [15:0] inp_x, inp_y,  // from cordic_mod 
//    output reg signed [31:0] mult_result,
//    output reg valid_out

//);

//    // Fixed-point constant: (180 / 2*pi) ~ 28.64 -> scaled by 2^8 = 256 -> 28.64*256 ? 7332
//    // or as per your earlier scale (e.g., by 1000): 28.64*1000 = 28640
    
//    // or if angle is scaled by 2^15 and we want final in degrees*100 -> SCALE_CONST = 8796
//    parameter signed [15:0] SCALE_CONST = 16'sd9;

//    wire signed [15:0] angle_out;
//    wire   cordic_valid;

//    // CORDIC module instantiation
//    cordic_mod uut1 (
//        .clk(clk), .rst(rst),
//        .inp_x(inp_x), .inp_y(inp_y),  // ensure your ports are correctly named
//        .arctan(angle_out),
//        .valid(cordic_valid)
//    );

//    always @(posedge clk or posedge rst) begin
//        if (rst) begin
//            mult_result <= 0;
//            valid_out <= 0;
//        end else begin
//            if (cordic_valid) begin
//                mult_result <= angle_out * SCALE_CONST;  // scaled angle in degrees
//                valid_out <= 1;
//            end else begin
//                valid_out <= 0;
//            end
//        end
//    end



//endmodule

module ratio_test_true (
    input clk, rst,
    input valid_input,
    input signed [15:0] inp_x, inp_y,  // from cordic_mod 
    output reg signed [31:0] mult_result,
    output reg valid_out
);

    // Scaling constant (customize if needed)
    parameter signed [15:0] SCALE_CONST = 16'sd9;

    // Internal registers to hold input only when valid
    reg signed [15:0] latched_x, latched_y;

    // Output from cordic
    wire signed [15:0] angle_out;
    wire cordic_valid;

    // Latch input only when valid_input is high
always @(posedge clk or posedge rst) begin
    if (rst) begin
        latched_x <= 0;
        latched_y <= 0;
    end else if (valid_input) begin
        if (inp_x < 0 && inp_y < 0) begin
            latched_x <= -inp_x;
            latched_y <= -inp_y;
        end else begin
            latched_x <= inp_x;
            latched_y <= inp_y;
        end
    end
end

    // Instantiate CORDIC with latched inputs
    cordic_mod uut1 (
        .clk(clk),
        .rst(rst),
        .inp_x(latched_x),
        .inp_y(latched_y),
        .arctan(angle_out),
        .valid(cordic_valid)
    );

    // Multiply angle and assert valid_out only when cordic_valid is high
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            mult_result <= 0;
            valid_out <= 0;
        end else begin
            if (cordic_valid) begin
                mult_result <= angle_out * SCALE_CONST;
                valid_out <= 1;
            end else begin
                valid_out <= 0;
            end
        end
    end

endmodule

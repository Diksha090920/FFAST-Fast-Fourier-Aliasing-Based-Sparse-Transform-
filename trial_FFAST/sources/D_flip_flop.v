`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.04.2025 17:47:12
// Design Name: 
// Module Name: D_flip_flop
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


module D_flip_flop (

    input wire clk,      // Clock input

    input wire rst,      // Asynchronous reset

    input wire [15:0] d,        // Data input

    output reg [15:0]q         // input

);



    always @(posedge clk or posedge rst) begin

        if (rst) 

            q <= 0;  // Reset input to 0

        else 

            q <= d;  // Transfer input to input on clock edge

    end



endmodule

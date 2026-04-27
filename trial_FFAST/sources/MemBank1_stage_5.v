`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.05.2025 14:56:13
// Design Name: 
// Module Name: MemBank1_stage_5
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


module MemBank1_stage_5 (
    input wire clk,
    input wire [4:0] write_address,
    input wire signed write_data,
    input wire write_enable,
    input wire [4:0] read_address,
    output reg signed read_data,
    input wire read_enable
    );

   reg signed memory_ratio [0:4];  

    // Write Operation 

    always @(posedge clk) begin
       if (write_enable) begin
       memory_ratio[write_address] <= write_data;
       end
    end
   // Read Operation 
    always @(posedge clk) begin
    if (read_enable) begin
       read_data<= memory_ratio[read_address];
    end
    end
  endmodule 
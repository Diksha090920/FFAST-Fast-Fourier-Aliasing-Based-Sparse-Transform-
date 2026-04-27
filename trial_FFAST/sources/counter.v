`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.02.2025 15:27:15
// Design Name: 
// Module Name: counter
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


module counter (
	input clk, rst, enable,
	output reg [2:0] count_val
);

	always @(posedge clk) begin
		if (rst) begin
			count_val <= 3'b000;
		end
		else if (enable) begin
			count_val <= count_val + 1;
		end
	end

endmodule
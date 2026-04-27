`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.04.2025 11:41:44
// Design Name: 
// Module Name: delay_n_cycles
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

module delay_n_cycles #(
  parameter N = 16,       // Width
  parameter D = 4         // Delay cycles
)(
  input clk,
  input rst,
  input [N-1:0] d,
  input [N-1:0] q
);

  reg [N-1:0] pipeline [0:D-1];
  integer i;

  always @(posedge clk or posedge rst) begin
    if (rst) begin
      for (i = 0; i < D; i = i + 1)
        pipeline[i] <= 0;
    end else begin
      pipeline[0] <= d;
      for (i = 1; i < D; i = i + 1)
        pipeline[i] <= pipeline[i-1];
    end
  end

  assign q = pipeline[D-1];

endmodule

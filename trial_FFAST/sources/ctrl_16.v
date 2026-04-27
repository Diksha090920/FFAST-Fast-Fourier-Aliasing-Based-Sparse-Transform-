`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.02.2025 12:32:44
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
module ctrl_16(
  input  wire       clk,
  input  wire       rst,
  input  wire       s_p_flag_in,  // s_p_flag_in equals to 1 when s_p module has 13 elements, else equals to 0
  output reg        mux_flag,
  output reg  [2:0] rotation,
  output reg        demux_flag
  );

  parameter STOP = 3'b0;
  parameter MUX_IDLE = 1'b0;
  parameter ROT_IDLE = 3'b0;
  parameter DEMUX_IDLE = 1'b0;
  parameter S_P_SEL_0 = 1'b0;
  parameter S_P_SEL_1 = 1'b0;
  parameter S_P_SEL_2 = 1'b0;
  parameter S_P_SEL_3 = 1'b0;
  parameter REG_SEL_0 = 1'b1;
  parameter REG_SEL_1 = 1'b1;
  parameter REG_SEL_2 = 1'b1;
  parameter REG_SEL_3 = 1'b1;
  parameter P_S_SEL_0 = 1'b0;
  parameter P_S_SEL_1 = 1'b0;
  parameter P_S_SEL_2 = 1'b0;
  parameter P_S_SEL_3 = 1'b0;

  reg[2:0] core_tick;  // count how many sequential logic

// This always part controls signal core_tick. 
  always @ ( posedge clk or posedge rst) begin
    if (rst )
      core_tick <= STOP; // 3 bits
    else if ( core_tick == STOP ) begin
      case ( s_p_flag_in )
        1'b0: core_tick <= STOP;
        1'b1: core_tick <= core_tick + 1;
      endcase
    end else
      core_tick <= core_tick + 1;
  end

// This always part controls signal mux_flag.
  always @ ( posedge clk or posedge rst ) begin
    if ( rst )
      mux_flag <= MUX_IDLE;
    else begin
      case ( core_tick )
        3'b000: mux_flag <= S_P_SEL_0;  // Comment here to lower power consumption but no use
        3'b001: mux_flag <= S_P_SEL_1;  // 15
        3'b010: mux_flag <= S_P_SEL_2;  // 16
        3'b011: mux_flag <= S_P_SEL_3;  // 17
        3'b100: mux_flag <= REG_SEL_0;  // 18
        3'b101: mux_flag <= REG_SEL_1;  // 19
        3'b110: mux_flag <= REG_SEL_2;  // 20
        3'b111: mux_flag <= REG_SEL_3;  // 21
        // If MUX/DEMUX has 3 OPTIONS (SP/PS, REG, IDLE), but no use to lower power consumption because still need compute IDLE
      endcase
    end
  end

// This always part controls signal demux_flag.
  always @ ( posedge clk or posedge rst ) begin
    if ( rst )
      demux_flag <= DEMUX_IDLE;
    else begin
      case ( core_tick )
        3'b000: demux_flag <= REG_SEL_0;  // Comment here to lower power consumption but no use
        3'b001: demux_flag <= REG_SEL_1;  // 15
        3'b010: demux_flag <= REG_SEL_2;  // 16
        3'b011: demux_flag <= REG_SEL_3;  // 17
        3'b100: demux_flag <= P_S_SEL_0;  // 18
        3'b101: demux_flag <= P_S_SEL_1;  // 19
        3'b110: demux_flag <= P_S_SEL_2;  // 20
        3'b111: demux_flag <= P_S_SEL_3;  // 21
        // If MUX/DEMUX has 3 OPTIONS (SP/PS, REG, IDLE), but no use to lower power consumption because still need compute IDLE
      endcase
    end
  end

// This always part controls signal rotation.
always @ ( posedge clk or posedge rst ) begin
  if ( rst )
    rotation <= ROT_IDLE; 
  else
    rotation <=core_tick;
end
    
endmodule
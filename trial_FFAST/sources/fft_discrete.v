`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.02.2025 13:34:13
// Design Name: 
// Module Name: fft_discrete
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


module fft_discrete (
    input aclk,
    input aresetn,

    input [15:0] in_data,
    input in_valid,
    input in_last,
    input in_ready,

    input [7:0] config_data,
    input config_valid,
    input config_ready,

    input [15:0] out_data,
    input out_valid,
    input out_last,
    input out_ready
);

    // Expanding 16-bit input to 32-bit for FFT IP Core
    wire [31:0] s_axis_data_tdata;
    assign s_axis_data_tdata[31:16] = 16'd0; // Zero-padding upper bits
    assign s_axis_data_tdata[15:0] = in_data;

    // FFT IP Core Wires
    wire [31:0] m_axis_data_tdata;
    wire [7:0] m_axis_data_tuser;
    wire m_axis_data_tvalid, m_axis_data_tready, m_axis_data_tlast;

    // Status Events
    wire event_frame_started;
    wire event_tlast_unexpected;
    wire event_tlast_missing;
    wire event_status_channel_halt;
    wire event_data_in_channel_halt;
    wire event_data_out_channel_halt;

    // FFT Core Instance
    xfft_0 FFT_core (
        .aclk(aclk),
        .s_axis_config_tdata(config_data),       // Configuration Data (8-bit)
        .s_axis_config_tvalid(config_valid),
        .s_axis_config_tready(config_ready),

        .s_axis_data_tdata(s_axis_data_tdata),   // Input Data (32-bit)
        .s_axis_data_tvalid(in_valid),
        .s_axis_data_tready(in_ready),
        .s_axis_data_tlast(in_last),

        .m_axis_data_tdata(m_axis_data_tdata),   // input Data (32-bit)
        .m_axis_data_tvalid(out_valid),
        .m_axis_data_tready(out_ready),
        .m_axis_data_tlast(out_last),

        .m_axis_status_tdata(),                  // Status Signals (Not used)
        .m_axis_status_tvalid(),
        .m_axis_status_tready(1'b1),             // Always ready

        .event_frame_started(event_frame_started),
        .event_tlast_unexpected(event_tlast_unexpected),
        .event_tlast_missing(event_tlast_missing),
        .event_status_channel_halt(event_status_channel_halt),
        .event_data_in_channel_halt(event_data_in_channel_halt),
        .event_data_out_channel_halt(event_data_out_channel_halt)
    );

    // Assigning 16-bit input from 32-bit FFT input
    assign out_data = m_axis_data_tdata[15:0];

endmodule

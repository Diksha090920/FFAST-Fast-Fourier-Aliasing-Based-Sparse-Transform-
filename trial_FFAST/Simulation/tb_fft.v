`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.02.2025 17:02:53
// Design Name: 
// Module Name: tb_fft
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


module tb_fft();

reg aclk;
reg aresetn;

reg [15:0] in_data;
reg in_valid;
reg in_last;
wire in_ready;

reg [7:0] config_data;
reg config_valid;
wire config_ready;

wire [15:0] out_data;
wire out_valid;
wire out_last;
reg out_ready;

reg [15:0] input_data[15:0];

integer i;

// Instantiate FFT Module
fft_discrete tb_in(
    .aclk(aclk),
    .aresetn(aresetn),
    
    .in_data(in_data),
    .in_valid(in_valid),
    .in_ready(in_ready),
    .in_last(in_last),
    
    .config_data(config_data),
    .config_valid(config_valid),
    .config_ready(config_ready),
    
    .out_data(out_data),
    .out_valid(out_valid),
    .out_last(out_last),
    .out_ready(out_ready)
);

// Clock Generation
always #5 aclk = ~aclk;

initial begin
    aclk = 0;
    aresetn = 0;
    in_valid = 0;
    in_data = 16'd0;
    in_last = 0;
    out_ready = 1;
    config_data = 8'd0;
    config_valid = 0;
    
    // Hold reset for a few clock cycles
    #50 aresetn = 1;
end

// Initialize Input Data
initial begin
    #60;
    input_data[0]  = 16'b0000000000000000;  //  0.0000
    input_data[1]  = 16'b0000001001101111;  //  0.5878
    input_data[2]  = 16'b0000001111000011;  //  0.9511
    input_data[3]  = 16'b0000001111000011;  //  0.9511
    input_data[4]  = 16'b0000001001101111;  //  0.5878
    input_data[5]  = 16'b0000000000000000;  //  0.0000
    input_data[6]  = 16'b1111110110010001;  // -0.5878
    input_data[7]  = 16'b1111101000111101;  // -0.9511
    input_data[8]  = 16'b1111101000111101;  // -0.9511
    input_data[9]  = 16'b1111110110010001;  // -0.5878
    input_data[10] = 16'b0000000000000000;  //  0.0000
    input_data[11] = 16'b0000001001101111;  //  0.5878
    input_data[12] = 16'b0000001111000011;  //  0.9511
    input_data[13] = 16'b0000001111000011;  //  0.9511
    input_data[14] = 16'b0000001001101111;  //  0.5878
    input_data[15] = 16'b0000000000000000;  //  0.0000
end

// Configuration Phase
initial begin
    #100;
    config_data = 8'd1;
    config_valid = 1;
    
    // Wait for FFT core to accept configuration
    wait (config_ready);
    
    #5 config_valid = 0;
end

// Input Data Transmission
initial begin
    #150; // Ensure configuration is completed before data transmission

    for (i = 0; i < 16; i = i + 1) begin
        in_data = input_data[i];
        in_valid = 1;

        if (i == 15)
            in_last = 1'b1;

        wait (in_ready); // Wait until FFT core is ready

        #10;
    end

    // Deassert control signals
    in_valid = 0;
    in_last = 0;
end

// input Handling
initial begin
    #200;
    wait (out_valid);

    #300;
    out_ready = 0;

    #50;
    $finish; // End simulation
    
    
end

endmodule

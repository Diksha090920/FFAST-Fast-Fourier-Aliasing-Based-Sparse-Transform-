`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.04.2025 10:53:10
// Design Name: 
// Module Name: sampling
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


module sampling (
    input  clk,
    input  reset,
    input wire valid_in, // asserts when sample_in is valid
    
    
     output wire signed [15:0] X0_real, X0_imag,
     output wire signed [15:0] X1_real, X1_imag,
     output wire signed [15:0] X2_real, X2_imag,
     output wire signed [15:0] X3_real, X3_imag,
     output wire signed [15:0] X4_real, X4_imag,
     output wire signed [15:0] X5_real, X5_imag,
     output wire signed [15:0] X6_real, X6_imag,
     output wire signed [15:0] X7_real, X7_imag,
     output wire signed [15:0] X8_real, X8_imag,
    
     output wire signed [15:0] X0_real_1, X0_imag_1,
     output wire signed [15:0] X1_real_1, X1_imag_1,
     output wire signed [15:0] X2_real_1, X2_imag_1,
     output wire signed [15:0] X3_real_1, X3_imag_1,
     output wire signed [15:0] X4_real_1, X4_imag_1,
     output wire signed [15:0] X5_real_1, X5_imag_1,
     output wire signed [15:0] X6_real_1, X6_imag_1,
     output wire signed [15:0] X7_real_1, X7_imag_1,
     output wire signed [15:0] X8_real_1, X8_imag_1,
  
     output wire signed [15:0] inter_Y0_real, inter_Y0_imag,
     output wire signed [15:0] inter_Y1_real, inter_Y1_imag,
     output wire signed [15:0] inter_Y2_real, inter_Y2_imag,
     output wire signed [15:0] inter_Y3_real, inter_Y3_imag,
     output wire signed [15:0] inter_Y4_real, inter_Y4_imag,
   
     output wire signed [15:0] inter_Y0_real_1, inter_Y0_imag_1,
     output wire signed [15:0] inter_Y1_real_1, inter_Y1_imag_1,
     output wire signed [15:0] inter_Y2_real_1, inter_Y2_imag_1,
     output wire signed [15:0] inter_Y3_real_1, inter_Y3_imag_1,
     output wire signed [15:0] inter_Y4_real_1, inter_Y4_imag_1,
   
     output wire signed [15:0] inter_Z0_real, inter_Z0_imag,
     output wire signed [15:0] inter_Z1_real, inter_Z1_imag,
     output wire signed [15:0] inter_Z2_real, inter_Z2_imag,
     output wire signed [15:0] inter_Z3_real, inter_Z3_imag,
  
   
     output wire signed [15:0] inter_Z0_real_1, inter_Z0_imag_1,
     output wire signed [15:0] inter_Z1_real_1, inter_Z1_imag_1,
     output wire signed [15:0] inter_Z2_real_1, inter_Z2_imag_1,
     output wire signed [15:0] inter_Z3_real_1, inter_Z3_imag_1
  
    
);
    // 9-point FFT inputs
//    wire signed [15:0] X0_real, X0_imag;
//    wire signed [15:0] X1_real, X1_imag;
//    wire signed [15:0] X2_real, X2_imag;
//    wire signed [15:0] X3_real, X3_imag;
//    wire signed [15:0] X4_real, X4_imag;
//    wire signed [15:0] X5_real, X5_imag;
//    wire signed [15:0] X6_real, X6_imag;
//    wire signed [15:0] X7_real, X7_imag;
//    wire signed [15:0] X8_real, X8_imag;
    
//    wire signed [15:0] X0_real_1, X0_imag_1;
//    wire signed[15:0] X1_real_1, X1_imag_1;
//    wire signed [15:0] X2_real_1, X2_imag_1;
//    wire signed [15:0] X3_real_1, X3_imag_1;
//    wire signed [15:0] X4_real_1, X4_imag_1;
//    wire signed [15:0] X5_real_1, X5_imag_1;
//    wire signed [15:0] X6_real_1, X6_imag_1;
//    wire signed [15:0] X7_real_1, X7_imag_1;
//    wire signed [15:0] X8_real_1, X8_imag_1;

//   //    // 5-point FFT inputs
    wire signed [15:0] Y0_real, Y0_imag;
    wire signed [15:0] Y1_real, Y1_imag;
    wire signed [15:0] Y2_real, Y2_imag;
    wire signed [15:0] Y3_real, Y3_imag;
    wire signed [15:0] Y4_real, Y4_imag;

    wire signed [15:0] Y0_real_1, Y0_imag_1;
    wire signed [15:0] Y1_real_1, Y1_imag_1;
    wire signed [15:0] Y2_real_1, Y2_imag_1;
    wire signed [15:0] Y3_real_1, Y3_imag_1;
    wire signed [15:0] Y4_real_1, Y4_imag_1;
    
    //    // 4-point FFT inputs
    wire signed [15:0] Z0_real, Z0_imag;
    wire signed [15:0] Z1_real, Z1_imag;
    wire signed [15:0] Z2_real, Z2_imag;
    wire signed [15:0] Z3_real, Z3_imag;
    
    wire signed [15:0] Z0_real_1, Z0_imag_1;
    wire signed [15:0] Z1_real_1, Z1_imag_1;
    wire signed [15:0] Z2_real_1, Z2_imag_1;
    wire signed [15:0] Z3_real_1, Z3_imag_1;


   

   // Buffers
    wire signed [15:0] buffer_9_real [0:8], buffer_9_imag [0:8];
    wire signed [15:0] buffer_9_real_shift [0:8], buffer_9_imag_shift [0:8];
    wire signed [15:0] buffer_5_real [0:4], buffer_5_imag [0:4];
    wire signed [15:0] buffer_5_real_shift [0:4], buffer_5_imag_shift [0:4];
    wire signed [15:0] buffer_4_real [0:3], buffer_4_imag [0:3];
    wire signed [15:0] buffer_4_real_shift [0:3], buffer_4_imag_shift [0:3];

   wire signed [15:0] inter_Y0_real, inter_Y0_imag;
   wire signed [15:0] inter_Y1_real, inter_Y1_imag;
   wire signed [15:0] inter_Y2_real, inter_Y2_imag;
   wire signed [15:0] inter_Y3_real, inter_Y3_imag;
   wire signed [15:0] inter_Y4_real, inter_Y4_imag;
   
   wire signed [15:0] inter_Y0_real_1, inter_Y0_imag_1;
   wire signed [15:0] inter_Y1_real_1, inter_Y1_imag_1;
   wire signed [15:0] inter_Y2_real_1, inter_Y2_imag_1;
   wire signed [15:0] inter_Y3_real_1, inter_Y3_imag_1;
   wire signed [15:0] inter_Y4_real_1, inter_Y4_imag_1;
   
   wire signed [15:0] inter_Z0_real, inter_Z0_imag;
   wire signed [15:0] inter_Z1_real, inter_Z1_imag;
   wire signed [15:0] inter_Z2_real, inter_Z2_imag;
   wire signed [15:0] inter_Z3_real, inter_Z3_imag;
  
   
   wire signed [15:0] inter_Z0_real_1, inter_Z0_imag_1;
   wire signed [15:0] inter_Z1_real_1, inter_Z1_imag_1;
   wire signed [15:0] inter_Z2_real_1, inter_Z2_imag_1;
   wire signed [15:0] inter_Z3_real_1, inter_Z3_imag_1;
  
    
    

    reg [15:0] R1_real [0:179];
    reg [15:0] R1_imag [0:179];
    

    initial $readmemb("output_real_trial.txt", R1_real);
    initial $readmemb ("output_imag_trial.txt",R1_imag);
    
    
//    // Counters
//reg [5:0] count_20 = 6'd0;

//reg [3:0] idx_9  = 4'd0;


//reg       fft9_start = 1'b0;



   assign buffer_9_real[0] = R1_real[0];
   assign buffer_9_real[1] = R1_real[20];
   assign buffer_9_real[2] = R1_real[40];
   assign buffer_9_real[3] = R1_real[60];
   assign buffer_9_real[4] = R1_real[80];
   assign buffer_9_real[5] = R1_real[100];
   assign buffer_9_real[6] = R1_real[120];
   assign buffer_9_real[7] = R1_real[140];
   assign buffer_9_real[8] = R1_real[160];

   assign buffer_9_imag[0] = R1_imag[0];
   assign buffer_9_imag[1] = R1_imag[20];
   assign buffer_9_imag[2] = R1_imag[40];
   assign buffer_9_imag[3] = R1_imag[60];
   assign buffer_9_imag[4] = R1_imag[80];
   assign buffer_9_imag[5] = R1_imag[100];
   assign buffer_9_imag[6] = R1_imag[120];
   assign buffer_9_imag[7] = R1_imag[140];
   assign buffer_9_imag[8] = R1_imag[160];

   assign buffer_9_real_shift[0] = R1_real[0+1];
   assign buffer_9_real_shift[1] = R1_real[20+1];
   assign buffer_9_real_shift[2] = R1_real[40+1];
   assign buffer_9_real_shift[3] = R1_real[60+1];
   assign buffer_9_real_shift[4] = R1_real[80+1];
   assign buffer_9_real_shift[5] = R1_real[100+1];
   assign buffer_9_real_shift[6] = R1_real[120+1];
   assign buffer_9_real_shift[7] = R1_real[140+1];
   assign buffer_9_real_shift[8] = R1_real[160+1];

   assign buffer_9_imag_shift[0] = R1_imag[0+1];
   assign buffer_9_imag_shift[1] = R1_imag[20+1];
   assign buffer_9_imag_shift[2] = R1_imag[40+1];
   assign buffer_9_imag_shift[3] = R1_imag[60+1];
   assign buffer_9_imag_shift[4] = R1_imag[80+1];
   assign buffer_9_imag_shift[5] = R1_imag[100+1];
   assign buffer_9_imag_shift[6] = R1_imag[120+1];
   assign buffer_9_imag_shift[7] = R1_imag[140+1];
   assign buffer_9_imag_shift[8] = R1_imag[160+1];
    
assign buffer_5_real[0] =R1_real[0];
assign buffer_5_real[1] =R1_real[36];
assign buffer_5_real[2] =R1_real[72];
assign buffer_5_real[3] =R1_real[108];
assign buffer_5_real[4] =R1_real[144];

assign buffer_5_imag[0] =R1_imag[0];
assign buffer_5_imag[1] =R1_imag[36];
assign buffer_5_imag[2] =R1_imag[72];
assign buffer_5_imag[3] =R1_imag[108];
assign buffer_5_imag[4] =R1_imag[144];

assign buffer_5_real_shift[0] =R1_real[0+1];
assign buffer_5_real_shift[1] =R1_real[36+1];
assign buffer_5_real_shift[2] =R1_real[72+1];
assign buffer_5_real_shift[3] =R1_real[108+1];
assign buffer_5_real_shift[4] =R1_real[144+1];

assign buffer_5_imag_shift[0] =R1_imag[0+1];
assign buffer_5_imag_shift[1] =R1_imag[36+1];
assign buffer_5_imag_shift[2] =R1_imag[72+1];
assign buffer_5_imag_shift[3] =R1_imag[108+1];
assign buffer_5_imag_shift[4] =R1_imag[144+1];


assign buffer_4_real[0] =R1_real[0];
assign buffer_4_real[1] =R1_real[45];
assign buffer_4_real[2] =R1_real[90];
assign buffer_4_real[3] =R1_real[135];

assign buffer_4_imag[0] =R1_imag[0];
assign buffer_4_imag[1] =R1_imag[45];
assign buffer_4_imag[2] =R1_imag[90];
assign buffer_4_imag[3] =R1_imag[135];

assign buffer_4_real_shift[0] =R1_real[0+1];
assign buffer_4_real_shift[1] =R1_real[45+1];
assign buffer_4_real_shift[2] =R1_real[90+1];
assign buffer_4_real_shift[3] =R1_real[135+1];

assign buffer_4_imag_shift[0] =R1_imag[0+1];
assign buffer_4_imag_shift[1] =R1_imag[45+1];
assign buffer_4_imag_shift[2] =R1_imag[90+1];
assign buffer_4_imag_shift[3] =R1_imag[135+1];



//    // === FFT 9-point Instantiation ===
    fft_9point u_fft_9point (
        .clk(clk),
        .rst(reset),
        .input_valid(fft9_start),
        .x0_real(buffer_9_real[0]), .x0_imag(buffer_9_imag[0]),
        .x1_real(buffer_9_real[1]), .x1_imag(buffer_9_imag[1]),
        .x2_real(buffer_9_real[2]), .x2_imag(buffer_9_imag[2]),
        .x3_real(buffer_9_real[3]), .x3_imag(buffer_9_imag[3]),
        .x4_real(buffer_9_real[4]), .x4_imag(buffer_9_imag[4]),
        .x5_real(buffer_9_real[5]), .x5_imag(buffer_9_imag[5]),
        .x6_real(buffer_9_real[6]), .x6_imag(buffer_9_imag[6]),
        .x7_real(buffer_9_real[7]), .x7_imag(buffer_9_imag[7]),
        .x8_real(buffer_9_real[8]), .x8_imag(buffer_9_imag[8]),
        .X0_real(X0_real), .X0_imag(X0_imag),
        .X1_real(X1_real), .X1_imag(X1_imag),
        .X2_real(X2_real), .X2_imag(X2_imag),
        .X3_real(X3_real), .X3_imag(X3_imag),
        .X4_real(X4_real), .X4_imag(X4_imag),
        .X5_real(X5_real), .X5_imag(X5_imag),
        .X6_real(X6_real), .X6_imag(X6_imag),
        .X7_real(X7_real), .X7_imag(X7_imag),
        .X8_real(X8_real), .X8_imag(X8_imag)
    );
    
        fft_9point u_fft1_9point (
        .clk(clk),
        .rst(reset),
        .input_valid(fft9_start),
        .x0_real(buffer_9_real_shift[0]), .x0_imag(buffer_9_imag_shift[0]),
        .x1_real(buffer_9_real_shift[1]), .x1_imag(buffer_9_imag_shift[1]),
        .x2_real(buffer_9_real_shift[2]), .x2_imag(buffer_9_imag_shift[2]),
        .x3_real(buffer_9_real_shift[3]), .x3_imag(buffer_9_imag_shift[3]),
        .x4_real(buffer_9_real_shift[4]), .x4_imag(buffer_9_imag_shift[4]),
        .x5_real(buffer_9_real_shift[5]), .x5_imag(buffer_9_imag_shift[5]),
        .x6_real(buffer_9_real_shift[6]), .x6_imag(buffer_9_imag_shift[6]),
        .x7_real(buffer_9_real_shift[7]), .x7_imag(buffer_9_imag_shift[7]),
        .x8_real(buffer_9_real_shift[8]), .x8_imag(buffer_9_imag_shift[8]),
        .X0_real(X0_real_1), .X0_imag(X0_imag_1),
        .X1_real(X1_real_1), .X1_imag(X1_imag_1),
        .X2_real(X2_real_1), .X2_imag(X2_imag_1),
        .X3_real(X3_real_1), .X3_imag(X3_imag_1),
        .X4_real(X4_real_1), .X4_imag(X4_imag_1),
        .X5_real(X5_real_1), .X5_imag(X5_imag_1),
        .X6_real(X6_real_1), .X6_imag(X6_imag_1),
        .X7_real(X7_real_1), .X7_imag(X7_imag_1),
        .X8_real(X8_real_1), .X8_imag(X8_imag_1)
    );

////    // === FFT 5-point Instantiation ===
    fft_5point u_fft_5point (
        .clk(clk),
        .rst(reset),
        .input_valid(fft5_start),
        .x0_real(buffer_5_real[0]), .x0_imag(buffer_5_imag[0]),
        .x1_real(buffer_5_real[1]), .x1_imag(buffer_5_imag[1]),
        .x2_real(buffer_5_real[2]), .x2_imag(buffer_5_imag[2]),
        .x3_real(buffer_5_real[3]), .x3_imag(buffer_5_imag[3]),
        .x4_real(buffer_5_real[4]), .x4_imag(buffer_5_imag[4]),
        .X0_real(Y0_real), .X0_imag(Y0_imag),
        .X1_real(Y1_real), .X1_imag(Y1_imag),
        .X2_real(Y2_real), .X2_imag(Y2_imag),
        .X3_real(Y3_real), .X3_imag(Y3_imag),
        .X4_real(Y4_real), .X4_imag(Y4_imag)
       
    );
    
    fft_5point u_fft1_5point (
        .clk(clk),
        .rst(reset),
        .input_valid(fft5_start),
        .x0_real(buffer_5_real_shift[0]), .x0_imag(buffer_5_imag_shift[0]),
        .x1_real(buffer_5_real_shift[1]), .x1_imag(buffer_5_imag_shift[1]),
        .x2_real(buffer_5_real_shift[2]), .x2_imag(buffer_5_imag_shift[2]),
        .x3_real(buffer_5_real_shift[3]), .x3_imag(buffer_5_imag_shift[3]),
        .x4_real(buffer_5_real_shift[4]), .x4_imag(buffer_5_imag_shift[4]),
        .X0_real(Y0_real_1), .X0_imag(Y0_imag_1),
        .X1_real(Y1_real_1), .X1_imag(Y1_imag_1),
        .X2_real(Y2_real_1), .X2_imag(Y2_imag_1),
        .X3_real(Y3_real_1), .X3_imag(Y3_imag_1),
        .X4_real(Y4_real_1), .X4_imag(Y4_imag_1)
       
    );

    delay_fft_5point u_fft1_5point_1(

    .clk(clk), .rst(rst),
    .input_valid(fft5_start),
    
    .x0_real(Y0_real), .x0_imag(Y0_imag),
    .x1_real(Y1_real), .x1_imag(Y1_imag),
    .x2_real(Y2_real), .x2_imag(Y2_imag),
    .x3_real(Y3_real), .x3_imag(Y3_imag),
    .x4_real(Y4_real), .x4_imag(Y4_imag),

    .X0_real(inter_Y0_real), .X0_imag(inter_Y0_imag),
    .X1_real(inter_Y1_real), .X1_imag(inter_Y1_imag),
    .X2_real(inter_Y2_real), .X2_imag(inter_Y2_imag),
    .X3_real(inter_Y3_real), .X3_imag(inter_Y3_imag),
    .X4_real(inter_Y4_real), .X4_imag(inter_Y4_imag)
    
    );
    
     delay_fft_5point u_fft1_5point_2(

    .clk(clk), .rst(rst),
    .input_valid(fft5_start),
    
    .x0_real(Y0_real_1), .x0_imag(Y0_imag_1),
    .x1_real(Y1_real_1), .x1_imag(Y1_imag_1),
    .x2_real(Y2_real_1), .x2_imag(Y2_imag_1),
    .x3_real(Y3_real_1), .x3_imag(Y3_imag_1),
    .x4_real(Y4_real_1), .x4_imag(Y4_imag_1),

    .X0_real(inter_Y0_real_1), .X0_imag(inter_Y0_imag_1),
    .X1_real(inter_Y1_real_1), .X1_imag(inter_Y1_imag_1),
    .X2_real(inter_Y2_real_1), .X2_imag(inter_Y2_imag_1),
    .X3_real(inter_Y3_real_1), .X3_imag(inter_Y3_imag_1),
    .X4_real(inter_Y4_real_1), .X4_imag(inter_Y4_imag_1)
    
    );

//    // === FFT 4-point Instantiation ===
    fft_4point u_fft_4point (
        .clk(clk),
        .rst(reset),
        .input_valid(fft4_start),
        .x0_real(buffer_4_real[0]), .x0_imag(buffer_4_imag[0]),
        .x1_real(buffer_4_real[1]), .x1_imag(buffer_4_imag[1]),
        .x2_real(buffer_4_real[2]), .x2_imag(buffer_4_imag[2]),
        .x3_real(buffer_4_real[3]), .x3_imag(buffer_4_imag[3]),
        .X0_real(Z0_real), .X0_imag(Z0_imag),
        .X1_real(Z1_real), .X1_imag(Z1_imag),
        .X2_real(Z2_real), .X2_imag(Z2_imag),
        .X3_real(Z3_real), .X3_imag(Z3_imag)
    );

 fft_4point u_fft1_4point (
        .clk(clk),
        .rst(reset),
        .input_valid(fft4_start),
        .x0_real(buffer_4_real_shift[0]), .x0_imag(buffer_4_imag_shift[0]),
        .x1_real(buffer_4_real_shift[1]), .x1_imag(buffer_4_imag_shift[1]),
        .x2_real(buffer_4_real_shift[2]), .x2_imag(buffer_4_imag_shift[2]),
        .x3_real(buffer_4_real_shift[3]), .x3_imag(buffer_4_imag_shift[3]),
        .X0_real(Z0_real_1), .X0_imag(Z0_imag_1),
        .X1_real(Z1_real_1), .X1_imag(Z1_imag_1),
        .X2_real(Z2_real_1), .X2_imag(Z2_imag_1),
        .X3_real(Z3_real_1), .X3_imag(Z3_imag_1)
    );
    
    
 delay_fft_4point u_fft1_4point_1 (
        .clk(clk),
        .rst(reset),
        .input_valid(fft4_start),
        .x0_real(Z0_real), .x0_imag(Z0_imag),
        .x1_real(Z1_real), .x1_imag(Z1_imag),
        .x2_real(Z2_real), .x2_imag(Z2_imag),
        .x3_real(Z3_real), .x3_imag(Z3_imag),
        .X0_real(inter_Z0_real), .X0_imag(inter_Z0_imag),
        .X1_real(inter_Z1_real), .X1_imag(inter_Z1_imag),
        .X2_real(inter_Z2_real), .X2_imag(inter_Z2_imag),
        .X3_real(inter_Z3_real), .X3_imag(inter_Z3_imag)
    );

delay_fft_4point u_fft1_4point_2 (
        .clk(clk),
        .rst(reset),
        .input_valid(fft4_start),
        .x0_real(Z0_real_1), .x0_imag(Z0_imag_1),
        .x1_real(Z1_real_1), .x1_imag(Z1_imag_1),
        .x2_real(Z2_real_1), .x2_imag(Z2_imag_1),
        .x3_real(Z3_real_1), .x3_imag(Z3_imag_1),
        .X0_real(inter_Z0_real_1), .X0_imag(inter_Z0_imag_1),
        .X1_real(inter_Z1_real_1), .X1_imag(inter_Z1_imag_1),
        .X2_real(inter_Z2_real_1), .X2_imag(inter_Z2_imag_1),
        .X3_real(inter_Z3_real_1), .X3_imag(inter_Z3_imag_1)
        );
        
        
endmodule

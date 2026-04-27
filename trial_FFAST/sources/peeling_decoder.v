`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.04.2025 14:04:32
// Design Name: 
// Module Name: peeling_decoder
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


//module peeling_decoder (
//    input  wire clk,
//    input  wire reset,

//    // FFT inputs (x1)

//    input wire signed [15:0] X0_real, X0_imag,
//    input wire signed [15:0] X1_real, X1_imag,
//    input wire signed [15:0] X2_real, X2_imag,
//    input wire signed [15:0] X3_real, X3_imag,
//    input wire signed [15:0] X4_real, X4_imag,
//    input wire signed [15:0] X5_real, X5_imag,
//    input wire signed [15:0] X6_real, X6_imag,
//    input wire signed [15:0] X7_real, X7_imag,
//    input wire signed [15:0] X8_real, X8_imag,



//    // FFT inputs (x2)

//    input wire signed [15:0] X0_real_1, X0_imag_1,
//    input wire signed [15:0] X1_real_1, X1_imag_1,
//    input wire signed [15:0] X2_real_1, X2_imag_1,
//    input wire signed [15:0] X3_real_1, X3_imag_1,
//    input wire signed [15:0] X4_real_1, X4_imag_1,
//    input wire signed [15:0] X5_real_1, X5_imag_1,
//    input wire signed [15:0] X6_real_1, X6_imag_1,
//    input wire signed [15:0] X7_real_1, X7_imag_1,
//    input wire signed [15:0] X8_real_1, X8_imag_1

//);


//    // Flattened input arrays

//    wire signed [15:0] X_real   [0:8];
//    wire signed [15:0] X_imag   [0:8];
//    wire signed [15:0] X11_real [0:8];
//    wire signed [15:0] X11_imag [0:8];



//    assign X_real[0] = X0_real; assign X_imag[0] = X0_imag;
//    assign X_real[1] = X1_real; assign X_imag[1] = X1_imag;
//    assign X_real[2] = X2_real; assign X_imag[2] = X2_imag;
//    assign X_real[3] = X3_real; assign X_imag[3] = X3_imag;
//    assign X_real[4] = X4_real; assign X_imag[4] = X4_imag;
//    assign X_real[5] = X5_real; assign X_imag[5] = X5_imag;
//    assign X_real[6] = X6_real; assign X_imag[6] = X6_imag;
//    assign X_real[7] = X7_real; assign X_imag[7] = X7_imag;
//    assign X_real[8] = X8_real; assign X_imag[8] = X8_imag;


//    assign X11_real[0] = X0_real_1; assign X11_imag[0] = X0_imag_1;
//    assign X11_real[1] = X1_real_1; assign X11_imag[1] = X1_imag_1;
//    assign X11_real[2] = X2_real_1; assign X11_imag[2] = X2_imag_1;
//    assign X11_real[3] = X3_real_1; assign X11_imag[3] = X3_imag_1;
//    assign X11_real[4] = X4_real_1; assign X11_imag[4] = X4_imag_1;
//    assign X11_real[5] = X5_real_1; assign X11_imag[5] = X5_imag_1;
//    assign X11_real[6] = X6_real_1; assign X11_imag[6] = X6_imag_1;
//    assign X11_real[7] = X7_real_1; assign X11_imag[7] = X7_imag_1;
//    assign X11_real[8] = X8_real_1; assign X11_imag[8] = X8_imag_1;

//    // Output from singleton_estimator

//    wire ratio_test_pass;
//    wire multiton_signal;
//    wire first_valid_delay;



//// // State encoding

////    localparam stStart = 2'd0;

////    localparam stIdle  = 2'd1;

////    localparam stWrite = 2'd2;

    

////    reg [1:0] current_state, next_state;

    

////    // Counter

////    reg [4:0] counter; // Can count 0â€"31, so enough for up to 18

////    wire [4:0] addr = counter;

    

////    // Write enable

////    reg write_enable;

    

////    // FSM sequential

////    always @(posedge clk or posedge reset) begin

////        if (reset)

////            current_state <= stStart;

////        else

////            current_state <= next_state;

////    end

    

////    // FSM combinational

////    always @(*) begin

////        case (current_state)

////            stStart: next_state = stIdle;

////            stIdle : next_state = (counter == 5'd9)  ? stWrite : stIdle;

////            stWrite: next_state = (counter == 5'd18) ? stIdle  : stWrite;

////            default: next_state = stStart;

////        endcase

////    end

    

////    // Counter logic

////    always @(posedge clk or posedge reset) begin

////        if (reset)

////            counter <= 0;

////        else begin

////            case (current_state)

////                stIdle : if (counter < 9)  counter <= counter + 1;

////                stWrite: if (counter < 18) counter <= counter + 1;

////                default: counter <= counter;

////            endcase

////        end

////    end

    

////    // Write enable logic

////    always @(posedge clk or posedge reset) begin

////        if (reset)

////            write_enable <= 0;

////        else

////            write_enable <= (current_state == stWrite);

////    end



//// State encoding

//localparam stStart = 4'd0;
//localparam stIdle  = 4'd1;
//localparam stWait =  4'd2;
//localparam stWrite = 4'd3;
//localparam stDone =  4'd4;


//reg [3:0] current_state, next_state;
//reg ratio_buffer [0:8];
//reg [4:0] write_index; // To index ratio_buffer during write phase
//reg [4:0] read_index;

//// Counter

//reg [5:0] counter; // Can count 0-31, so enough for up to 18
//// Write enable

//reg write_enable;
//reg start_write;

//// FSM sequential

//always @(posedge clk or posedge reset) begin
//    if (reset)
//        current_state <= stStart;
//    else
//        current_state <= next_state;
//end


//// FSM combinational

//always @(*) begin
//    case (current_state)
//        stStart: next_state = stIdle;
//        stIdle : next_state = (read_index == 4'd9)  ? stWait  : stIdle;
//        stWait : next_state = stWrite;
//        stWrite: next_state = (write_index == 5'd9) ? stIdle : stWrite;
//        stDone : next_state = stDone; // Terminal state
//        default: next_state = stStart;
//    endcase

//end

//// Counter logic

//always @(posedge clk or posedge reset) begin

//    if (reset) begin
//        counter <= 0;
//        write_index <= 0;
//        write_enable <= 0;
//        read_index <=0;
//        start_write <=0;
//    end
//    else begin
//        case (current_state)
//            stIdle: begin
//                write_enable <= 0;

//                if (first_valid_delay && !start_write)begin
//                   start_write <=1;
//                   counter <=0;
//                   read_index <=0;
//                end 

//         if (counter < 9 && start_write) begin
//                    ratio_buffer[read_index] <= ratio_test_pass;
//                    counter <= counter + 1;
//                    read_index <= read_index +1;
//                end
//            end

//            stWait: begin
//                // Just wait one cycle before moving to stWrite
//               write_enable <= 0;
//            end

//            stWrite: begin
//                write_enable <= 1;
//                if (write_index < 9) begin
//                    write_index <= write_index + 1;
//                    counter <= counter + 1;
//                end
//            end
            
//            stDone: begin
//                    write_enable <= 0;

//                    // Optional: You can assert a 'done' signal here

//                end
//            default: begin
//                counter <= 0;
//                write_index <= 0;
//                write_enable <= 0;
//                read_index <= 0;
//                start_write <=0;
//            end
//        endcase
//    end
//end



//// Address for memory is equal to write_index during write phase

//wire [4:0] addr = write_index[4:0];

//    // Singleton Estimator

//    singleton_estimator u_singleton (
//        .clk(clk),
//        .rst(reset),
//        .x1_real(X_real[read_index]),
//        .x1_imag(X_imag[read_index]),
//        .x2_real(X11_real[read_index]),
//        .x2_imag(X11_imag[read_index]),
//        .ratio_test_pass(ratio_test_pass),
//        .first_valid_delay(first_valid_delay)

//    );

//    // Memory block

//    MemBank1_stage memory_bank (
//        .clk(clk),
//        .write_address(addr),
//        .write_data(ratio_buffer[write_index]),
//        .write_enable(write_enable),
//        .read_address(3'b000),
//        .read_data(), // dummy read
//        .read_enable(1'b0)

//    );
//endmodule


module peeling_decoder (
    input  wire clk,
    input  wire reset,

    // FFT inputs (x1)

    input wire signed [15:0] X0_real, X0_imag,
    input wire signed [15:0] X1_real, X1_imag,
    input wire signed [15:0] X2_real, X2_imag,
    input wire signed [15:0] X3_real, X3_imag,
    input wire signed [15:0] X4_real, X4_imag,
    input wire signed [15:0] X5_real, X5_imag,
    input wire signed [15:0] X6_real, X6_imag,
    input wire signed [15:0] X7_real, X7_imag,
    input wire signed [15:0] X8_real, X8_imag,



    // FFT inputs (x2)

    input wire signed [15:0] X0_real_1, X0_imag_1,
    input wire signed [15:0] X1_real_1, X1_imag_1,
    input wire signed [15:0] X2_real_1, X2_imag_1,
    input wire signed [15:0] X3_real_1, X3_imag_1,
    input wire signed [15:0] X4_real_1, X4_imag_1,
    input wire signed [15:0] X5_real_1, X5_imag_1,
    input wire signed [15:0] X6_real_1, X6_imag_1,
    input wire signed [15:0] X7_real_1, X7_imag_1,
    input wire signed [15:0] X8_real_1, X8_imag_1,
    
    output wire [31:0] mult_result  // or the correct width of your multiplier output


);


    // Flattened input arrays

    wire signed [15:0] X_real   [0:8];
    wire signed [15:0] X_imag   [0:8];
    wire signed [15:0] X11_real [0:8];
    wire signed [15:0] X11_imag [0:8];



    assign X_real[0] = X0_real; assign X_imag[0] = X0_imag;
    assign X_real[1] = X1_real; assign X_imag[1] = X1_imag;
    assign X_real[2] = X2_real; assign X_imag[2] = X2_imag;
    assign X_real[3] = X3_real; assign X_imag[3] = X3_imag;
    assign X_real[4] = X4_real; assign X_imag[4] = X4_imag;
    assign X_real[5] = X5_real; assign X_imag[5] = X5_imag;
    assign X_real[6] = X6_real; assign X_imag[6] = X6_imag;
    assign X_real[7] = X7_real; assign X_imag[7] = X7_imag;
    assign X_real[8] = X8_real; assign X_imag[8] = X8_imag;


    assign X11_real[0] = X0_real_1; assign X11_imag[0] = X0_imag_1;
    assign X11_real[1] = X1_real_1; assign X11_imag[1] = X1_imag_1;
    assign X11_real[2] = X2_real_1; assign X11_imag[2] = X2_imag_1;
    assign X11_real[3] = X3_real_1; assign X11_imag[3] = X3_imag_1;
    assign X11_real[4] = X4_real_1; assign X11_imag[4] = X4_imag_1;
    assign X11_real[5] = X5_real_1; assign X11_imag[5] = X5_imag_1;
    assign X11_real[6] = X6_real_1; assign X11_imag[6] = X6_imag_1;
    assign X11_real[7] = X7_real_1; assign X11_imag[7] = X7_imag_1;
    assign X11_real[8] = X8_real_1; assign X11_imag[8] = X8_imag_1;

    // Output from singleton_estimator

    wire ratio_test_pass;
    wire multiton_signal;
    wire data_valid_delay;



// // State encoding

//    localparam stStart = 2'd0;

//    localparam stIdle  = 2'd1;

//    localparam stWrite = 2'd2;

    

//    reg [1:0] current_state, next_state;

    

//    // Counter

//    reg [4:0] counter; // Can count 0â€"31, so enough for up to 18

//    wire [4:0] addr = counter;

    

//    // Write enable

//    reg write_enable;

    

//    // FSM sequential

//    always @(posedge clk or posedge reset) begin

//        if (reset)

//            current_state <= stStart;

//        else

//            current_state <= next_state;

//    end

    

//    // FSM combinational

//    always @(*) begin

//        case (current_state)

//            stStart: next_state = stIdle;

//            stIdle : next_state = (counter == 5'd9)  ? stWrite : stIdle;

//            stWrite: next_state = (counter == 5'd18) ? stIdle  : stWrite;

//            default: next_state = stStart;

//        endcase

//    end

    

//    // Counter logic

//    always @(posedge clk or posedge reset) begin

//        if (reset)

//            counter <= 0;

//        else begin

//            case (current_state)

//                stIdle : if (counter < 9)  counter <= counter + 1;

//                stWrite: if (counter < 18) counter <= counter + 1;

//                default: counter <= counter;

//            endcase

//        end

//    end

    

//    // Write enable logic

//    always @(posedge clk or posedge reset) begin

//        if (reset)

//            write_enable <= 0;

//        else

//            write_enable <= (current_state == stWrite);

//    end



// State encoding

//localparam stStart = 4'd0;
localparam stRead  = 4'd1;
localparam stWait  = 4'd2;
localparam stWrite = 4'd3;
localparam stDone  = 4'd4;



reg [3:0] current_state, next_state;
reg ratio_buffer [0:8];
reg [4:0] write_index; // To index ratio_buffer during write phase
reg [4:0] read_index;

// Counter

reg [5:0] counter; // Can count 0-31, so enough for up to 18
// Write enable

reg write_enable;
reg start_write;
reg [4:0] buffer_index;
reg [4:0] write_address;

// For memory scanning
reg [4:0] stable_index;
reg [4:0] scan_index;
reg scan_enable;
wire signed memory_value;
reg [4:0] matched_count;  // number of 1s found

// To store matched values
reg signed [15:0] matched_real [0:8];
reg signed [15:0] matched_imag [0:8];
reg [4:0] matched_index; // Points to next available slot in matched arrays

// Flag when scan is done
reg scan_done;

reg [4:0] non_zero_index;
reg [4:0] send_index;
reg start_ratio_test_true;
reg [15:0] inp_x, inp_y;
wire valid_out_latched;
reg matched_data_ready;

reg valid_input;
reg input_consumed;
// FSM sequential

// FSM sequential
always @(posedge clk or posedge reset) begin
    if (reset)
        current_state <= stRead;
    else
        current_state <= next_state;
end

// FSM combinational
always @(*) begin
    case (current_state)
       // stStart : next_state = stRead;
        stRead  : next_state = (read_index == 4'd9) ? stWait : stRead;
        stWait  : next_state = stWrite;
        stWrite : next_state = (write_index == 4'd9) ? stDone : stWrite;
        stDone  : next_state = stDone;
        default : next_state = stRead;
    endcase
end


// Counter logic

always @(posedge clk or posedge reset) begin
    if (reset) begin
        counter <= 0;
        read_index <= 0;
        write_index <= 0;
        write_enable <= 0;
    end else begin
        case (current_state)
            stRead: begin
                if (read_index < 9) begin            
                    ratio_buffer[read_index] <= ratio_test_pass;
                    read_index <= read_index + 1;
                    counter <= counter + 1;
                end
            end

            stWait: begin
                write_enable <= 0;  // 1-cycle wait
            end

            stWrite: begin
                write_enable <= 1;
                if (write_index < 9) begin
                    write_index <= write_index + 1;
                    counter <= counter + 1;
                end
            end

            default: begin
                write_enable <= 0;
            end
        endcase
    end
end

// Data capture logic: store valid ratio_test_pass into buffer
always @(posedge clk or posedge reset) begin
    if (reset) begin
        buffer_index <= 0;
    end else if (data_valid_delay && buffer_index < 9) begin
        ratio_buffer[buffer_index] <= ratio_test_pass;
        buffer_index <= buffer_index + 1;
    end
end


always @(posedge clk or posedge reset) begin
    if (reset) begin
        write_address <= 0;
    end else if (write_enable) begin
        write_address <= write_index;
    end
end

reg [4:0] zero_fill_index;
reg fill_zeros;
reg [4:0] delayed_scan_index;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        scan_index <= 0;
        scan_enable <= 0;
        matched_count <= 0;
        scan_done <= 0;
        zero_fill_index <=0;
        fill_zeros <=0;
        matched_data_ready <= 0;
    end else if (current_state == stDone && !scan_done) begin
        scan_enable <= 1;
         delayed_scan_index <= scan_index; 
        if (scan_index < 9) begin
            if (memory_value == 1) begin
                matched_real[matched_count] <= X11_real[delayed_scan_index];
                matched_imag[matched_count] <= X11_imag[delayed_scan_index];
                matched_count <= matched_count + 1;
                                    end
            scan_index <= scan_index + 1;
                            end else begin
            scan_enable <= 0;
            scan_done <= 1;
            fill_zeros <=1;
                                     end        
                                                      end
    else if (fill_zeros) begin
    if (zero_fill_index < (9 - matched_count)) begin
        matched_real[matched_count + zero_fill_index] <= 0;
        matched_imag[matched_count + zero_fill_index] <= 0;
        zero_fill_index <= zero_fill_index + 1;
    end else begin 
        fill_zeros <= 0;
        matched_data_ready <= 1; // <--- ADD THIS HERE
    end
end
end


always @(posedge clk or posedge reset) begin
    if (reset) begin
        send_index <= 0;
        non_zero_index <= 0;
        start_ratio_test_true <= 0;
        inp_x <= 0;
        inp_y <= 0;
        valid_input <= 0; // NEW signal
    end else begin
     //   valid_input <= 0; // Default low each cycle unless updated below

        if (scan_done && !start_ratio_test_true && send_index < 9) begin
            // Find next non-zero entry
            if (matched_real[send_index] != 0 || matched_imag[send_index] != 0) begin
                inp_x <= matched_real[send_index];
                inp_y <= matched_imag[send_index];
                start_ratio_test_true <= 1;  // Trigger module
                valid_input <= 1;            // Signal valid data input
            end else begin
                send_index <= send_index + 1; // Skip zero
                
            end
        end else if (start_ratio_test_true) begin
            start_ratio_test_true <= 0; // Pulse done
            send_index <= send_index + 1;
            
        end
    end
end

//reg [15:0] latched_x, latched_y;

//always @(posedge clk or posedge reset) begin
//    if (reset) begin
//        latched_x <= 0;
//        latched_y <= 0;
//    end else if (valid_input) begin
//        latched_x <= inp_x;
//        latched_y <= inp_y;
//    end
//end


// Address for memory is equal to write_index during write phase

//wire [4:0] addr = write_index[4:0];

    // Singleton Estimator

    singleton_estimator u_singleton (
        .clk(clk),
        .rst(reset),
        .x1_real(X_real[read_index]),
        .x1_imag(X_imag[read_index]),
        .x2_real(X11_real[read_index]),
        .x2_imag(X11_imag[read_index]),
        .ratio_test_pass(ratio_test_pass),
        .data_valid_delay(data_valid_delay)

    );

    // Memory block

    MemBank1_stage memory_bank (
        .clk(clk),
        .write_address(write_address),
        .write_data(ratio_buffer[write_address]),
        .write_enable(write_enable),
        .read_address(scan_index),
        .read_data(memory_value), // dummy read
        .read_enable(scan_enable)

    );
    
    ratio_test_true rt_true(
     .clk(clk), 
     .rst(reset),
     .valid_input(valid_input),
     .inp_x(inp_x),
     .inp_y(inp_y),  // from cordic_mod 
     .mult_result(mult_result),
     .valid_out(valid_out_latched)
);


endmodule
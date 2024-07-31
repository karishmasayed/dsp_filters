///This is RTL Design for 3 Tap IIR filter. The on board frequency should be 40Khz or greater, because maximum audio frequency is 20Khz, so here clock generated in testbench is 50Khz
///b0,b1,a1 is taken from net and given in Q1.15 format for fraction calculation.
///// IIR filter difference equation: y[n] = b0*Data_IN[n] + b1*Data_IN[n-1] - a1*Data_OUT[n-1]


module IIR_Filter (
    input wire CLK,
    input wire RESET,
    input wire signed [15:0] Data_IN, 
    output reg signed [15:0] Data_OUT  
);

    parameter signed [15:0] a1 = 16'h0CCC; // -0.75 in Q1.15 format
    parameter signed [15:0] b0 = 16'h1000; //  1.00 in Q1.15 format
    parameter signed [15:0] b1 = 16'h0CCC; //  0.75 in Q1.15 format

    reg signed [15:0] x1; // Delay element for input
    reg signed [15:0] y1; // Delay element for output

    always @(posedge CLK or posedge RESET) begin
        if (RESET) begin
            x1 <= 16'b0;
            y1 <= 16'b0;
            Data_OUT <= 16'b0;
        end else begin
            // IIR filter difference equation: y[n] = b0*Data_IN[n] + b1*Data_IN[n-1] - a1*Data_OUT[n-1]
            Data_OUT <= (b0 * Data_IN + b1 * x1 - a1 * y1) >>> 15; // Q1.15 fixed-point arithmetic
            x1 <= Data_IN;
            y1 <= Data_OUT;
        end
    end

endmodule





`timescale 1ms/1ps

module tb_IIR_Filter;
    reg CLK;
    reg RESET;
    reg signed [15:0] Data_IN;
    wire signed [15:0] Data_OUT;

    IIR_Filter uut (
        .CLK(CLK),
        .RESET(RESET),
        .Data_IN(Data_IN),
        .Data_OUT(Data_OUT)
    );

    always #25 CLK = ~CLK;   // Clock generation here clock freq is 50Khz as max audio signal 20Khz range the operating freq should be 40Khz or higher

    initial begin
        CLK = 0;
        RESET = 1;
        Data_IN = 16'b0;
        
        #10;
        RESET = 0;

        #10 Data_IN = 16'h1000; 
        #10 Data_IN = 16'h0800; 
        #10 Data_IN = 16'h0400; 
        #10 Data_IN = 16'h0200; 
        #10 Data_IN = 16'h0100; 
        #10 Data_IN = 16'h0080; 
        #10 Data_IN = 16'h0040; 
        #10 Data_IN = 16'h0020; 
        #10 Data_IN = 16'h0010; 
        #10 Data_IN = 16'h0008; 
        #10 Data_IN = 16'h0004; 
        #10 Data_IN = 16'h0002; 
        #10 Data_IN = 16'h0001; 
        #10 Data_IN = 16'h0000; 
         #10 Data_IN = 16'h1000; 
        #10 Data_IN = 16'h0800; 
        #10 Data_IN = 16'h0400; 
        #10 Data_IN = 16'h0200; 
        #10 Data_IN = 16'h0100; 
        #10 Data_IN = 16'h0080; 
        #10 Data_IN = 16'h0040; 
        #10 Data_IN = 16'h0020; 
        #10 Data_IN = 16'h0010; 
        #10 Data_IN = 16'h0008; 
        #10 Data_IN = 16'h0004; 
        #10 Data_IN = 16'h0002; 
        #10 Data_IN = 16'h0001; 
        #10 Data_IN = 16'h0000;
         #10 Data_IN = 16'h1000; 
        #10 Data_IN = 16'h0800; 
        #10 Data_IN = 16'h0400; 
        #10 Data_IN = 16'h0200; 
        #10 Data_IN = 16'h0100; 
        #10 Data_IN = 16'h0080; 
        #10 Data_IN = 16'h0040; 
        #10 Data_IN = 16'h0020; 
        #10 Data_IN = 16'h0010; 
        #10 Data_IN = 16'h0008; 
        #10 Data_IN = 16'h0004; 
        #10 Data_IN = 16'h0002; 
        #10 Data_IN = 16'h0001; 
        #10 Data_IN = 16'h0000;
         #10 Data_IN = 16'h1000; 
        #10 Data_IN = 16'h0800; 
        #10 Data_IN = 16'h0400; 
        #10 Data_IN = 16'h0200; 
        #10 Data_IN = 16'h0100; 
        #10 Data_IN = 16'h0080; 
        #10 Data_IN = 16'h0040; 
        #10 Data_IN = 16'h0020; 
        #10 Data_IN = 16'h0010; 
        #10 Data_IN = 16'h0008; 
        #10 Data_IN = 16'h0004; 
        #10 Data_IN = 16'h0002; 
        #10 Data_IN = 16'h0001; 
        #10 Data_IN = 16'h0000;

        #100;
        $stop;
    end

endmodule

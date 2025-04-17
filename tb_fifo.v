`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
module tb_fifo();

reg clk;
reg reset;
reg [7:0] data_in;
reg push;
reg pop;
wire full;
wire empty;
wire [7:0] data_out;

fifo uut (
.clk (clk),
.reset (reset),
.data_in (data_in),
.push (push),
.pop (pop),
.full (full),
.empty (empty),
.data_out (data_out)
);

initial begin
clk = 0;
forever #5 clk = ~clk;
end

initial begin
    reset = 0;
    push = 0;
    pop = 0;
    data_in = 0;
    #2 reset = 1;
    #1 reset = 0;
    #3 data_in = 3;
    #1 data_in = 1;
    #2 push = 1;
    #12 push = 0;
    #2 pop = 1;
    #3 pop = 0;
    #1 data_in = 23;
    #2 push = 1;
    #40 $finish;
end
endmodule

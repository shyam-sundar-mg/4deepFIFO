`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
module fifo(
    input clk,
    input reset,
    input [7:0] data_in,
    input push,
    input pop,
    output full,
    output empty,
    output reg [7:0] data_out
    );

    // register files
    reg [7:0] files[3:0];
    reg [1:0] wrt_ptr = 0;
    reg [1:0] rd_ptr = 0;
    
    // count
    wire [3:0] count; 
    
    // counter instance
    counter counter_instant (
        .clk (clk),
        .reset (reset),
        .increment (push && !pop),
        .decrement (pop && !push),
        .count (count)
        );
    
    assign full = (count == 4);
    assign empty = (count == 0);
    
    always @(posedge clk)
    begin
        if (reset)
        begin
            wrt_ptr <= 0;
            rd_ptr <= 0;
//            count <= 0;
        end
        else
        begin
        if (push && !full)
            begin
            files[wrt_ptr] <= data_in;
            wrt_ptr <= wrt_ptr + 1;
            end    
        else if (pop && !empty)
            begin
            data_out <= files[rd_ptr];
            rd_ptr <= rd_ptr + 1;
            end    
        end
    end
endmodule

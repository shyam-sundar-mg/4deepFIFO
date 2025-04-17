`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
module counter(
    input clk,
    input reset,
    input increment,
    input decrement,
    output reg [3:0] count
    );
//wire enable;
reg [3:0] out;
wire inc = increment && !decrement;
wire dec = !increment && decrement;
wire enable = inc | dec;
always @(posedge clk or posedge reset) 
        begin
        if (reset)
            count <= 0;
        else if (inc)
            count <= count + 1;
        else if (dec)
            count <= count - 1;
        end
endmodule

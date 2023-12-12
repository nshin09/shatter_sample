`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/25/2023 03:15:30 PM
// Design Name: 
// Module Name: posedge
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


module edging(
        input logic clk, signal, reset,
        output logic aligned
    );
    
   logic button_ff, button_ff_ff;
   logic  button_posedge;
   always_ff @(posedge clk or posedge reset) begin
    if(reset) begin
        button_ff <= signal;
        button_ff_ff <= signal;
    end
    else begin
        button_ff <= signal;
        button_ff_ff <= button_ff;
    
    end
   end
   assign aligned = button_ff && ~button_ff_ff;
    
endmodule

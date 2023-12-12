`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/04/2023 01:09:35 AM
// Design Name: 
// Module Name: toggle
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


module toggle(input logic btn, clk, reset,
              output logic signal, reset_out
    );
    
    always_ff @ (posedge clk) begin
        if (reset)
            signal <= 1'b0;
        else if (btn) begin
            signal <= ~signal;
            reset_out <= 1'b1;
        end else
            reset_out <= 1'b0;
    end
    
endmodule

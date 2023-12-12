`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/23/2023 11:06:12 PM
// Design Name: 
// Module Name: clkdiv
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


module clkdiv(input logic reset, clk1, 
              output logic clk2
    );
   
   always_ff @ (posedge clk1 or posedge reset) begin
        if(reset) begin
            clk2 <= 1'b0;
        end
        else begin
            clk2 <= ~clk2;
        end
    end
endmodule

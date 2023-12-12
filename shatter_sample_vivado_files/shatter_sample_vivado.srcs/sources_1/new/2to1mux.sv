`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/04/2023 12:55:12 AM
// Design Name: 
// Module Name: 2to1mux
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


module mux2to1(input logic a,     // First input
               input logic b,     // Second input
               input logic sel,   // Select signal
               output logic y     // Output
);

    // Mux functionality
    always_comb begin
        case(sel)
            1'b0: y = a;    // Select input a
            1'b1: y = b;    // Select input b
        endcase
    end
endmodule

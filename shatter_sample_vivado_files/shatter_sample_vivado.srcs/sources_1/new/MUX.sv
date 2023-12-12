`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/28/2023 07:34:33 PM
// Design Name: 
// Module Name: MUX
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


module MUX(
    input logic toggle,
    input logic [15:0] in,
    output logic [15:0] out1, out2
    );
    
    logic switch = 1'b0;
    
    always_ff @ (posedge toggle) begin
        switch <= ~switch;
    end
    
    always_comb begin
        if (switch == 1'b0) begin
            out1 = in;
            out2 = 16'h0000;
        end else begin
            out1 = 16'h0000;
            out2 = in;
        end
    end
    
endmodule

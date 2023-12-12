`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/14/2023 04:47:46 PM
// Design Name: 
// Module Name: eight_to_one_MUX
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


module eight_to_one_MUX(
     input logic [15:0] A,B,C,D,E,F,G,H,
     input logic[3:0] S,
     output logic [15:0]Z,
     output logic [31:0]letters
    );
    always_comb begin
    case(S)
    4'b0001: begin
    Z = A;
    letters = {4'b0111,4'b0000,4'b0010,4'b1011,4'b0010,4'b0111,4'b0011,4'b1011}; 
    end
    4'b0010: begin
    Z = B;
    letters = {4'b1101,4'b1110,4'b0110,4'b0010,4'b0011,4'b1010,4'b0110,4'b1101}; 
    end
    4'b0011: begin
    Z = C;
    letters = {4'b0100,4'b1110,4'b0110,4'b1011,4'b0011,4'b1010,4'b0110,4'b1101}; 
    end
    4'b0100:begin
    Z = D; 
    letters = {4'b0010,4'b1100,4'b1010,4'b1000,4'b1111,4'b0100,4'b0001,4'b0111}; 
    end
    4'b0101:begin
    Z = E;
    letters = {4'b0010,4'b0000,4'b0101,4'b0110,4'b1001,4'b1011,4'b1011,4'b1011}; 
    end
    4'b0110:
    Z = F;
    4'b0111:
    Z = G;
    4'b1000:
    Z = H;
    default: Z = 16'h0000;
    endcase
    end
endmodule

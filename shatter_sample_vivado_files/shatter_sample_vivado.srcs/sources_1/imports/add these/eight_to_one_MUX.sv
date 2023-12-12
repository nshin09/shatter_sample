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
    if(D[15:8] != 0)
    Z = {8'b11111111, D[7:0]};
    else
    Z = {8'b00000000, D[7:0]};
    letters = {4'b1010,4'b0011,4'b1000,4'b1011,4'b1111,4'b0100,4'b0001,4'b0111};  //ArP.
    end
    4'b0101:begin
     for (int i = 16; i > 0; i--) begin
       if(E == i) begin
        for(int j = i; j >= 0; j--) begin
            Z[j-1] = 1'b1;
        end
        for(int k = i; k <= 15; k++)begin
            Z[k] = 1'b0;
       end
    end
    if(E == 0) 
    Z = 16'h0000;
end
    letters = {4'b0010,4'b0000,4'b0101,4'b0110,4'b1001,4'b1011,4'b1011,4'b1011}; 
    end
    4'b0110: begin
    for (int i = 16; i > 0; i--) begin
       if(F == i) begin
        for(int j = i; j >= 0; j--) begin
            Z[j-1] = 1'b1;
        end
        for(int k = i; k <= 15; k++)begin
            Z[k] = 1'b0;
        end
    end
    if(F == 0) 
    Z = 16'h0000;
end
    letters = {4'b0010,4'b1010,4'b0110,4'b0110,4'b0111,4'b0100,4'b1110,4'b1011}; 
    end
    4'b0111:begin
     for (int i = 16; i > 0; i--) begin
       if(G == i) begin
        for(int j = i; j >= 0; j--) begin
            Z[j-1] = 1'b1;
        end
        for(int k = i; k <= 15; k++)begin
            Z[k] = 1'b0;
        end
    end    
end
    if(G == 0) 
    Z = 16'h0000;
    letters = {4'b0100,4'b0000,4'b0101,4'b1001,4'b0110,4'b1110,4'b0010,4'b0010};
end
    4'b1000:begin
    Z = H;
    end
    default: Z = 16'h0000;
    endcase
    end
endmodule

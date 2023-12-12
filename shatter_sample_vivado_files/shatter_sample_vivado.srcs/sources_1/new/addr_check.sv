`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/25/2023 09:59:07 AM
// Design Name: 
// Module Name: addr_check
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


module addr_check( input logic [31:0] ram_addr,
                   output logic [15:0] bool

    );
    
    always_comb begin
    
        if (ram_addr >= 28'h3FFFFF) begin
            bool[7:0] = 8'b1;
        end else begin
            bool[7:0] = 8'b0;   
        end
        
        if (ram_addr >= 28'h1228FFF) begin
            bool[15:8] = 8'b1;
        end else begin
            bool[15:8] = 8'b0;   
        end
    end
    
endmodule

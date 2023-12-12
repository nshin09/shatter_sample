`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/29/2023 11:10:41 PM
// Design Name: 
// Module Name: impulse
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


module impulse(
    input logic clk,     
    input logic reset,
    input logic [15:0] density, 
    output logic go
);

    logic idk;
    assign go = idk;
    logic [31:0] max;
    assign max = ((256-density) * 380000) + 2500000;
    logic [31:0] count = 32'b0;
  
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            count <= 32'd0;
        end else begin
            if (count >= max) begin
                count <= 32'd0;
            end else begin
                count <= count + 1;
            end
        end
    end
    
    always_comb begin
        if(count == (max - 1))
            idk = 1'b1;
        else
            idk = 1'b0;
    end
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/24/2023 04:05:18 PM
// Design Name: 
// Module Name: clkdiv3
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


module clkdiv3(
    input logic clk,     
    input logic reset, 
    output logic read_clk,
    input logic [15:0] read_count
);

   
    logic [15:0] read_counter = 16'b0; 
    

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            read_counter <= 24'd0;
            read_clk <= 1'b0;
        end else begin
            if (read_counter == read_count) begin
                read_clk <= ~read_clk;
                read_counter <= 24'd0;
            end else begin
                read_counter <= read_counter + 1;
            end
        end
      end
endmodule

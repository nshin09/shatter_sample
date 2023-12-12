`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/24/2023 04:28:54 PM
// Design Name: 
// Module Name: PCM2PWM
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


module PCM2PWM(input clk, input logic [15:0] data, output logic PWML, PWMR,
               input logic [4:0] vol
    );
    logic [7:0] left_channel, right_channel;
    assign left_channel = data[15:8] * vol / 16 ;
    assign right_channel = data[7:0] * vol / 16;
    logic [7:0] count = 8'b0;
    always_ff @(posedge clk) begin
  
        PWML <= (count < left_channel);
        PWMR <= (count < right_channel);

        if (count == 8'd255) begin
            count <= 8'd0;
        end else begin
            count <= count + 1;
        end
    end
endmodule

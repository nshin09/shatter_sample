`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/02/2023 04:12:46 PM
// Design Name: 
// Module Name: note2clk
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


module note2clk(input logic [7:0] keycode,
                input logic clk,
                output logic [15:0] count,
                output logic read_en
    );
    
    logic [1:0] octave = 2'b01;
    logic [1:0] octave_3;
    logic [7:0] octave_keycode_f = 8'b0;
    logic [7:0] octave_keycode_ff = 8'b0;
    logic octave_up, octave_down;
    logic double_tap_f = 1'b0;
    logic double_tap_ff = 1'b0;
    
    always_comb begin
        case (keycode)
        
            8'h14: begin
                count = 16'd2267;
                read_en = 1'b1;
                end
                
            8'h1A: begin
                count = 16'd2139;
                read_en = 1'b1;
                end
                
            8'h08: begin
                count = 16'd2019;
                read_en = 1'b1;
                end
                
            8'h15: begin
                count = 16'd1906;
                read_en = 1'b1;
                end
                
            8'h17: begin
                count = 16'd1799;
                read_en = 1'b1;
                end
                
            8'h1C: begin
                count = 16'd1698;
                read_en = 1'b1;
                end
                
            8'h18: begin
                count = 16'd1602;
                read_en = 1'b1;
                end
                
            8'h0C: begin
                count = 16'd1512;
                read_en = 1'b1;
                end
                
            8'h12: begin
                count = 16'd1428;
                read_en = 1'b1;
                end
                
            8'h13: begin
                count = 16'd1347;
                read_en = 1'b1;
                end
                
            8'h04: begin
                count = 16'd1272;
                read_en = 1'b1;
                end
                
            8'h16: begin
                count = 16'd1200;
                read_en = 1'b1;
                end
                
            8'h07: begin
                count = 16'd1133;
                read_en = 1'b1;
                end
                
            8'h09: begin
                count = 16'd1069;
                read_en = 1'b1;
                end
                
            8'h0A: begin
                count = 16'd1009;
                read_en = 1'b1;
                end
                
            8'h0B: begin
                count = 16'd952;
                read_en = 1'b1;
                end
                
            8'h0D: begin
                count = 16'd899;
                read_en = 1'b1;
                end
                
            8'h0E: begin
                count = 16'd848;
                read_en = 1'b1;
                end
                
            8'h0F: begin
                count = 16'd801;
                read_en = 1'b1;
                end
                
            8'h1D: begin
                count = 16'd756;
                read_en = 1'b1;
                end
                
            8'h1B: begin
                count = 16'd713;
                read_en = 1'b1;
                end
                
            8'h06: begin
                count = 16'd673;
                read_en = 1'b1;
                end
                
            8'h19: begin
                count = 16'd635;
                read_en = 1'b1;
                end
                
            8'h05: begin
                count = 16'd600;
                read_en = 1'b1;
                end
                
            default: begin
                count = 16'd1133;
                read_en = 1'b0;
            end
        endcase
     end
endmodule

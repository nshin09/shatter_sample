`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/06/2023 12:31:41 AM
// Design Name: 
// Module Name: octaves
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


module octaves(input logic [7:0] keycode,
               input logic clk,
               input logic [15:0] count,
               output logic [15:0] count_mod
    );
    
    logic octave_up, octave_up_short, octave_down, octave_down_short;
    logic octave_up_f, octave_up_ff, octave_down_f, octave_down_ff;
    logic [1:0] octave = 2'b10;
    
    always_comb begin
        if (keycode == 8'h52)
            octave_up = 1'b1;
        else
            octave_up = 1'b0;
        if (keycode == 8'h51)
            octave_down = 1'b1;
        else
            octave_down = 1'b0;
            
        if (octave == 2'b11)
            count_mod = count / 2;
        else if (octave == 2'b10)
            count_mod = count;
        else if (octave == 2'b01)
            count_mod = count * 2;
        else
            count_mod = count * 4;
        
    end
    
   
   always_ff @ (posedge clk) begin
        octave_up_f <= octave_up;
        octave_up_ff <= octave_up_f;
        octave_down_f <= octave_down;
        octave_down_ff <= octave_down_f;
        
        if (octave_up_short)
            octave <= octave + 1;
        else if (octave_down_short)
            octave <= octave - 1;
        else
            octave <= octave;
   end
   
   assign octave_up_short = octave_up_f && ~octave_up_ff;
   assign octave_down_short = octave_down_f && ~octave_down_ff;
    
endmodule

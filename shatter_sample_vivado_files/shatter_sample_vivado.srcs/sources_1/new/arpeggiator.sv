`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/07/2023 04:24:32 PM
// Design Name: 
// Module Name: arpeggiator
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


module arpeggiator(input logic trigger, sampler_mode,
                   input logic [31:0] notes,
                   input logic [7:0] arppegiate,
                   output logic [7:0] note,
                   output logic [2:0] track_check
    );
    
    logic on;
    logic active_1, active_2, active_3, active_4;
    assign active_1 = (notes[7:0] != 8'b0);
    assign active_2 = (notes[15:8] != 8'b0);
    assign active_3 = (notes[23:16] != 8'b0);
    assign active_4 = (notes[31:24] != 8'b0);
    always_comb begin
    if(arppegiate != 1'b0)
        on = 1'b1;
    else
        on = 1'b0;
    end
    logic [1:0] tracker = 2'b0;
    assign track_check = tracker;
    always_ff @ (posedge trigger) begin
        if (~active_2 && ~active_3 && ~active_4)
            tracker <= 2'b0;
        else if (active_1 && active_2 && ~active_3 && ~active_4) begin
            if (tracker >= 2'b01)
                tracker <= 2'b0;
            else
                tracker <= tracker + 1;
        end else if (active_1 && active_2 && active_3 && ~active_4) begin
            if (tracker >= 2'b10)
                tracker <= 2'b0;
            else
                tracker <= tracker + 1;
        end else if (active_1 && active_2 && active_3 && active_4)
                tracker <= tracker + 1;
    end
   
    always_comb begin
        if (sampler_mode)
            note = notes[7:0];
        else if (on) begin
            if (tracker == 2'b00)
                note = notes[7:0];
            else if (tracker == 2'b01)
                note = notes[15:8];
            else if (tracker == 2'b10)
                note = notes[23:16];
            else
                note = notes[31:24];
        end
        else
            note = notes[7:0];
    end
   
endmodule

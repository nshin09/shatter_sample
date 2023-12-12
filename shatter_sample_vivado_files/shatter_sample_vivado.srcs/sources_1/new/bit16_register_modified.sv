`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/30/2023 02:10:49 PM
// Design Name: 
// Module Name: bit16_register_modified
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


module bit16_register_modified(input  logic Clk, Reset, Write_En,
              input  logic [15:0]  D,
              output logic [4:0]  Data_Out);
              
    logic initial_check = 1'b1;

    always_ff @ (posedge Clk)
    begin
             if (Reset && initial_check) begin
                    Data_Out <= 5'b0100;
                    initial_check <= 1'b0;
             end else if (Reset && ~initial_check)
                    Data_Out <= Data_Out;
             else if (Write_En) begin
                  if(D[15] == 1'b1)
                  Data_Out <= 5'd16;
                  else if(D[14] == 1'b1)
                  Data_Out <= 5'd15;
                  else if(D[13] == 1'b1)
                  Data_Out <= 5'd14;
                  else if(D[12] == 1'b1)
                  Data_Out <= 5'd13;
                  else if(D[11] == 1'b1)
                  Data_Out <= 5'd12;
                  else if(D[10] == 1'b1)
                  Data_Out <= 5'd11;
                  else if(D[9] == 1'b1)
                  Data_Out <= 5'd10;
                  else if(D[8] == 1'b1)
                  Data_Out <= 5'd9;
                  else if(D[7] == 1'b1)
                  Data_Out <= 5'd8;
                  else if(D[6] == 1'b1)
                  Data_Out <= 5'd7;
                  else if(D[5] == 1'b1)
                  Data_Out <= 5'd6;
                  else if(D[4] == 1'b1)
                  Data_Out <= 5'd5;
                  else if(D[3] == 1'b1)
                  Data_Out <= 5'd4;
                  else if(D[2] == 1'b1)
                  Data_Out <= 5'd3;
                  else if(D[1] == 1'b1)
                  Data_Out <= 5'd2;
                  else if(D[0] == 1'b1)
                  Data_Out <= 5'd1;
                  else
                  Data_Out <= 5'h0000;
                  
                  end
                    
    end

endmodule

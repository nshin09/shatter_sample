`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/30/2023 02:12:21 PM
// Design Name: 
// Module Name: bit8_register
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


module bit8_register(input  logic Clk, Reset, Write_En, sampler_mode,
              input  logic [7:0]  D,
              input logic [3:0] reset_init,
              output logic [7:0]  Data_Out

    );
    
    
    
    always_ff @ (posedge Clk) begin
        if (Reset) begin
            if (sampler_mode) begin
                case (reset_init)
                    4'd1: begin
                        Data_Out <= 8'b00000000;
                    end
                    4'd2: begin
                        Data_Out <= 8'b00000000;
                    end
                    4'd3: begin
                        Data_Out <= 8'b00000000;
                    end
                    4'd4: begin
                        Data_Out <= 8'b00000000;
                    end
                    4'd5: begin
                        Data_Out <= 8'b00000000;
                    end
                    4'd6: begin
                        Data_Out <= 8'b00000000;
                    end
                    4'd7: begin
                        Data_Out <= 8'b00000000;
                    end
                    4'd8: begin
                        Data_Out <= 8'b00000000;
                    end
                endcase
            end else begin
                case (reset_init)
                    4'd1: begin
                        Data_Out <= 8'b01000000;
                    end
                    4'd2: begin
                        Data_Out <= 8'b11111111;
                    end
                    4'd3: begin
                        Data_Out <= 8'b10100000;
                    end
                    4'd4: begin
                        Data_Out <= 8'b00010000;
                    end
                    4'd5: begin
                        Data_Out <= 8'b11111111;
                    end
                    4'd6: begin
                        Data_Out <= 8'b00000000;
                    end
                    4'd7: begin
                        Data_Out <= 8'b00000000;
                    end
                    4'd8: begin
                        Data_Out <= 8'b00000000;
                    end
                endcase
         end
            
            
        end else if (Write_En) begin
            Data_Out <= D;
        end
    end
    
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/14/2023 12:22:56 PM
// Design Name: 
// Module Name: setting_state_machine
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


module setting_state_machine(
input logic Clk,
input logic sampler_mode,
input logic [3:0] buttons,
output logic [3:0] grid_in,
output logic LD1,LD2,LD3,LD4,LD5,LD6,LD7,LD8,LD9,LD10,
output logic initial_clear
    );
    enum logic[5:0] {initial_state,setting1,setting1_change,setting2,setting2_change,setting3,setting3_change,
   setting4,setting4_change,setting5,setting5_change,setting6,setting6_change,switch_settings_right1,switch_settings_left1,switch_settings_right2,switch_settings_left2,
   switch_settings_right3,switch_settings_left3,switch_settings_right4,switch_settings_left4,
    switch_settings_right5,switch_settings_left5,switch_settings_right6,switch_settings_left6,Sampler_State,Sampler_Sound_Change}State, Next_State;
    
//,setting6,setting6_change,
//    setting7,setting7_change,setting8,setting8_change,,switch_settings_right6,switch_settings_left6,
//    switch_settings_right7,switch_settings_left7,switch_settings_right8,switch_settings_left8}State, Next_State;
    
    
    always_ff@(posedge Clk)
    begin
        if(buttons[0])
        State <= initial_state;
        else
        State <= Next_State;
    end
    
    always_comb begin
    Next_State = State;
     LD1 = 1'b0;
     LD2 = 1'b0;
     LD3 = 1'b0;
     LD4 = 1'b0;
     LD5 = 1'b0;
     LD6 = 1'b0;
     LD7 = 1'b0;
     LD8 = 1'b0;
     LD9 = 1'b0;
     LD10 = 1'b0;
     grid_in = 4'b0001;
     initial_clear = 1'b0;
        
     unique case(State)
     initial_state
            :
            Next_State = setting1;
     setting1: 
//             if(buttons[1])
//             Next_State = setting2;
//             else if(buttons[2])
//             Next_State = setting7;
            if(buttons[1])
             Next_State = switch_settings_right1;
             else if(buttons[2])
             Next_State = switch_settings_left1;
             else if(buttons[3])
             Next_State = setting1_change;
             else if(sampler_mode)
             Next_State = Sampler_State;             
             else 
             Next_State = setting1;
     setting1_change:
            Next_State = setting1;
     setting2: 
//             if(buttons[1])
//             Next_State = setting3;
//             else if(buttons[2])
//             Next_State = setting1;
            if(buttons[1])
             Next_State = switch_settings_right2;
             else if(buttons[2])
             Next_State = switch_settings_left2;
             else if(buttons[3])
             Next_State = setting2_change;
             else if(sampler_mode)
             Next_State = Sampler_State; 
             else 
             Next_State = setting2;
            
    setting2_change:
            Next_State = setting2;
    setting3: 
//             if(buttons[1])
//             Next_State = setting4;
//             else if(buttons[2])
//             Next_State = setting2;
             if(buttons[1])
             Next_State = switch_settings_right3;
             else if(buttons[2])
             Next_State = switch_settings_left3;
             else if(buttons[3])
             Next_State = setting3_change;
             else if(sampler_mode)
             Next_State = Sampler_State; 
             else 
             Next_State = setting3;
    setting3_change:
            Next_State = setting3;
     setting4: 
//             if(buttons[1])
//             Next_State = setting5;
//             else if(buttons[2])
//             Next_State = setting3;
             if(buttons[1])
             Next_State = switch_settings_right4;
             else if(buttons[2])
             Next_State = switch_settings_left4;
             else if(buttons[3])
             Next_State = setting4_change;
             else if(sampler_mode)
             Next_State = Sampler_State; 
             else 
             Next_State = setting4;
    setting4_change:
            Next_State = setting4;
    setting5: 
//             if(buttons[1])
//             Next_State = setting6;
//             else if(buttons[2])
//             Next_State = setting4;
              if(buttons[1])
             Next_State = switch_settings_right5;
             else if(buttons[2])
             Next_State = switch_settings_left5;
             else if(buttons[3])
             Next_State = setting5_change;
             else if(sampler_mode)
             Next_State = Sampler_State; 
             else 
             Next_State = setting5;
    setting5_change:
            Next_State = setting5;
    setting6: 
             if(buttons[1])
             Next_State = switch_settings_right6;
             else if(buttons[2])
             Next_State = switch_settings_left6;
             else if(buttons[3])
             Next_State = setting6_change;
             else if(sampler_mode)
             Next_State = Sampler_State; 
             else 
             Next_State = setting6;
    setting6_change:
            Next_State = setting6;
//   setting7: 
////             if(buttons[1])
////             Next_State = setting1;
////             else if(buttons[2])
////             Next_State = setting6;
//             if(buttons[1])
//             Next_State = switch_settings_right7;
//             else if(buttons[2])
//             Next_State = switch_settings_left7;
//             else if(buttons[3])
//             Next_State = setting7_change;
//             else 
//             Next_State = setting7;
//    setting7_change:
//            Next_State = setting7;
//    setting8:
//             if(buttons[1])
//             Next_State = switch_settings_right8;
//             else if(buttons[2])
//             Next_State = switch_settings_left8;
//             else if(buttons[3])
//             Next_State = setting8_change;
//             else 
//             Next_State = setting8;
//    setting8_change:
//            Next_State = setting8;
    switch_settings_right1:
            if(~buttons[1])
            Next_State = setting2;
            else
            Next_State = switch_settings_right1;
    switch_settings_right2:
            if(~buttons[1])
            Next_State = setting3;
            else
            Next_State = switch_settings_right2;
   switch_settings_right3:
            if(~buttons[1])
            Next_State = setting4;
            else
            Next_State = switch_settings_right3;
   switch_settings_right4:
            if(~buttons[1])
            Next_State = setting5;
            else
            Next_State = switch_settings_right4;
    switch_settings_right5:
            if(~buttons[1])
            Next_State = setting6;
            else
            Next_State = switch_settings_right5;
    switch_settings_right6:
            if(~buttons[1])
            Next_State = setting1;
            else
            Next_State = switch_settings_right6;
//    switch_settings_right6:
//            if(~buttons[1])
//            Next_State = setting7;
//            else
//            Next_State = switch_settings_right6;
//   switch_settings_right7:
//            if(~buttons[1])
//            Next_State = setting8;
//            else
//            Next_State = switch_settings_right7;      
//   switch_settings_right8:
//            if(~buttons[1])
//            Next_State = setting1;
//            else
//            Next_State = switch_settings_right8;    
    switch_settings_left1:
            if(~buttons[2])
            Next_State = setting6;
            else
            Next_State = switch_settings_left1;   
    switch_settings_left2:
            if(~buttons[2])
            Next_State = setting1;
            else
            Next_State = switch_settings_left2; 
    switch_settings_left3:
            if(~buttons[2])
            Next_State = setting2;
            else
            Next_State = switch_settings_left3; 
    switch_settings_left4:
            if(~buttons[2])
            Next_State = setting3;
            else
            Next_State = switch_settings_left4; 
    switch_settings_left5:
            if(~buttons[2])
            Next_State = setting4;
            else
            Next_State = switch_settings_left5; 
    switch_settings_left6:
            if(~buttons[2])
            Next_State = setting5;
            else
            Next_State = switch_settings_left6; 
     Sampler_State:
            if(buttons[3])
                Next_State = Sampler_Sound_Change;
            else if(sampler_mode == 0)
                Next_State = setting1;
            else 
                Next_State = Sampler_State;
        Sampler_Sound_Change:
            Next_State = Sampler_State;
//     switch_settings_left6:
//            if(~buttons[2])
//            Next_State = setting5;
//            else
//            Next_State = switch_settings_left6; 
//     switch_settings_left7:
//            if(~buttons[2])
//            Next_State = setting6;
//            else
//            Next_State = switch_settings_left7;   
//     switch_settings_left8:
//            if(~buttons[2])
//            Next_State = setting7;
//            else
//            Next_State = switch_settings_left8;                                                                      
            
    default:;
    endcase 
    case(State)
            initial_state:
                    initial_clear = 1'b1;
           setting1,switch_settings_left1,switch_settings_right1:
                   grid_in = 4'b0001;
           setting2,switch_settings_left2,switch_settings_right2:
                    grid_in = 4'b0010;
           setting3,switch_settings_left3,switch_settings_right3:
                    grid_in = 4'b0011;
           setting4,switch_settings_left4,switch_settings_right4:
                    grid_in = 4'b0100;
           setting5,switch_settings_left5,switch_settings_right5:
                    grid_in = 4'b0101;
           setting6,switch_settings_left6,switch_settings_right6:
                    grid_in = 4'b0111;
//           setting6,switch_settings_left6,switch_settings_right6:
//                    grid_in = 4'b0110;
//           setting7,switch_settings_left7,switch_settings_right7:
//                    grid_in = 4'b0111;
//           setting8,switch_settings_left8,switch_settings_right8:
//                    grid_in = 4'b1000;
           setting1_change: begin
                    LD1 = 1'b1;
                    LD2 = 1'b1;
                    grid_in = 4'b0001;
                    end
           setting2_change: begin
                    LD3 = 1'b1;
                    LD4 = 1'b1;
                    grid_in = 4'b0010;
                    end
           setting3_change: begin
                    LD5 = 1'b1;
                    LD6 = 1'b1;
                    grid_in = 4'b0011;
                    end
           setting4_change: begin
                    LD7 = 1'b1; //Didn't implement envelope.
                    LD8 = 1'b1;
                    grid_in = 4'b0100;
                    end
           setting5_change: begin
                    LD9 = 1'b1;
                    grid_in = 4'b0101;
                    end
           setting6_change: begin
                    LD10 = 1'b1;
                    grid_in = 4'b0111;
                    end
           Sampler_State: begin
//                    LD9 = 1'b1;
                    grid_in = 4'b0110;
                    end
           Sampler_Sound_Change: begin
                    LD9 = 1'b1;
                    grid_in = 4'b0110;
                    end
//           setting6_change: begin
//                    LD6 = 1'b1;
//                    grid_in = 4'b0110;
//                    end
//           setting7_change: begin
//                    LD7 = 1'b1;
//                    grid_in = 4'b0111;
//                    end
//           setting8_change: begin
//                    LD8 = 1'b1;
//                    grid_in = 4'b1000;
//                    end
            default:;
      endcase
    end
endmodule


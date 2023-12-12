`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/23/2023 10:48:11 PM
// Design Name: 
// Module Name: toplevel
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


module toplevel(
        input logic clk_100, 
        output logic cs, sclk, mosi, PWML, PWMR, 
        input logic miso, //reset_3, ren_0, debug_trig,
        input logic [3:0] btn,
        input logic [15:0] SW,
       // input logic [7:0] length, start,
        output logic [15:0] LED,
        output logic [7:0] hex_segA,
        output logic [3:0] hex_gridA,
        output logic [7:0] hex_segB,
        output logic [3:0] hex_gridB,
        input logic uart_txd,
        output logic uart_rxd,
        // USB SPI CONNECTIONS //
        input logic [0:0] gpio_usb_int_tri_i,
        output logic gpio_usb_rst_tri_o,
        input logic usb_spi_miso,
        output logic usb_spi_mosi,
        output logic usb_spi_sclk,
        output logic usb_spi_ss
    );
    
    logic [31:0] monitor;
    logic [31:0] ram_address, maxx, keycode_0_gpio, keycode_1_gpio;
    logic [15:0] din1, din2, dout1, dout2, ram_data, stereo_sample, density, read_count;
    logic not_rready, done, wren, rready1, rready2, error, rresponse, GO, reset_short, reverse, playback_controller;
    logic clk_50, read_clk, read_clk_short, read_en, sampler_mode_trig, sampler_mode_trig_short, sampler_mode, trigger;
    logic [7:0] outs;
    logic [7:0] length, start, note, reverse_block;
    enum logic [12:0]	{INIT, READBLOCK, READL_0, READL_1, READH_0, READH_1, WRITE, ERROR, DONE, HOLUP, HOLUP2, LESGO, RESET} state_r, state_x;
    

   // assign density = SW;
    //assign LED = density;
    assign btn_clk = read_clk_short && read_en;
    assign stereo_sample = dout1 + dout2;
    //assign length = 8'b00001111;
    assign reverse = reverse_block[0];
    
    
    // used for the synth settings
    logic [3:0] into;
    logic [7:0] R1,R2,R3,R4,R5,R6,R7,R8, pos_mod, dens_mod, len_mod;
    logic [4:0] R9;
    logic LD1,LD2,LD3,LD4,LD5,LD6,LD7,LD8,LD9;
    logic Set_SH,Left_SH,Right_SH,Reset_SH;
    logic initial_clear;
    logic [31:0] letters;
    assign note = keycode_0_gpio[7:0];
    
    sync buttonsync1(.Clk(clk_100),.d(btn[3]),.q(Set_SH));
    sync buttonsync2(.Clk(clk_100),.d(btn[2]),.q(Left_SH));
    sync buttonsync3(.Clk(clk_100),.d(btn[1]),.q(Right_SH));
    sync buttonsync4(.Clk(clk_100),.d(btn[0]),.q(sampler_mode_trig));
    
    eight_to_one_MUX(
        .A({R1,R2}),
        .B({R3,R4}),
        .C({R5,R6}),
        .D({R7,R8}),
        .E(R9),
        .F(16'b0),
        .G(16'b0),
        .H(16'b0),
        .S(into),
        .Z(LED),
        .letters(letters)
        
    );
       setting_state_machine granular_settings(
        .Clk(clk_100),
        .buttons({Set_SH, Left_SH, Right_SH, sampler_mode_trig}),
        .grid_in(into),
        .LD1(LD1),
        .LD2(LD2),
        .LD3(LD3),
        .LD4(LD4),
        .LD5(LD5),
        .LD6(LD6),
        .LD7(LD7),
        .LD8(LD8),
        .LD9(LD9),
        .initial_clear(initial_clear)
    );
    
     //Position 
    bit8_register setting1(
    .Clk(clk_100),
    .Reset(Reset_SH || initial_clear),
    .Write_En(LD1),
    .D(SW[15:8]),
    .Data_Out(R1),
    .reset_init(4'd1),
    .sampler_mode(sampler_mode)
    );
    //Spray 
    bit8_register setting2(
    .Clk(clk_100),
    .Reset(Reset_SH || initial_clear),
    .Write_En(LD2),
    .D(SW[7:0]),
    .Data_Out(R2),
    .reset_init(4'd2),
    .sampler_mode(sampler_mode)
    );
    
    //Density
    bit8_register setting3(
    .Clk(clk_100),
    .Reset(Reset_SH || initial_clear),
    .Write_En(LD3),
    .D(SW[15:8]),
    .Data_Out(R3),
    .reset_init(4'd3),
    .sampler_mode(sampler_mode)
    );
    
    //Density Randomization
    bit8_register setting4(
    .Clk(clk_100),
    .Reset(Reset_SH || initial_clear),
    .Write_En(LD4),
    .D(SW[7:0]),
    .Data_Out(R4),
    .reset_init(4'd4),
    .sampler_mode(sampler_mode)
    );
    
    //Length 
    bit8_register setting5(
    .Clk(clk_100),
    .Reset(Reset_SH || initial_clear),
    .Write_En(LD5),
    .D(SW[15:8]),
    .Data_Out(R5),
    .reset_init(4'd5),
    .sampler_mode(sampler_mode)
    );
    //Length Randomization
    bit8_register setting6(
    .Clk(clk_100),
    .Reset(Reset_SH || initial_clear),
    .Write_En(LD6),
    .D(SW[7:0]),
    .Data_Out(R6),
    .reset_init(4'd6),
    .sampler_mode(sampler_mode)
    );
    //Envelope
    bit8_register setting7(
    .Clk(clk_100),
    .Reset(Reset_SH || initial_clear),
    .Write_En(LD7),
    .D(SW[15:8]),
    .Data_Out(R7),
    .reset_init(4'd7),
    .sampler_mode(sampler_mode)
    );
    
    // REVERSE RATIO //
    
     bit8_register setting8(
    .Clk(clk_100),
    .Reset(Reset_SH || initial_clear),
    .Write_En(LD8),
    .D(SW[7:0]),
    .Data_Out(R8),
    .reset_init(4'd8),
    .sampler_mode(sampler_mode)
    );
    
    //Sound Select
     bit16_register_modified setting9(
    .Clk(clk_100),
    .Reset(initial_clear),
    .Write_En(LD9),
    .D(SW),
    .Data_Out(R9)
    );
    // CLOCKS AND SYNCHRONIZATION // 
    
    clkdiv div2(
        .reset(fake_reset),
        .clk1(clk_100),
        .clk2(clk_50));
        
   clkdiv3 div3(
        .reset(read_en_short),
        .clk(clk_100),
        .read_clk(read_clk),
        .read_count(read_count));
    
    edging goon(
        .clk(clk_50),
        .reset(fake_reset), // !!!
        .signal(read_clk),
        .aligned(read_clk_short));
        
    edging ren(
        .clk(clk_50),
        .reset(fake_reset), // !!!
        .signal(read_en),
        .aligned(read_en_short));
        
//     edging rst(
//        .clk(clk_50),
//        .reset(fake_reset),
//        .signal(Reset_SH),
//        .aligned(reset_short));
        
    edging smpl(
        .clk(clk_50),
        .reset(fake_reset), // !!!
        .signal(sampler_mode_trig),
        .aligned(sampler_mode_trig_short));
        
    impulse train(
        .clk(clk_50),
        .reset(Reset_SH),
        .density(dens_mod),
        .go(GO));
        
    mux2to1 sample_mode_select(
        .a(GO),
        .b(read_en_short),
        .sel(sampler_mode),
        .y(trigger));
        
    toggle tog(
        .clk(clk_50),
        .reset(fake_reset),
        .btn(sampler_mode_trig_short),
        .signal(sampler_mode),
        .reset_out(Reset_SH));
        
    // SD TO AUDIO OUTPUT //
    
   sdcard_init sd(
        .clk50(clk_50),
        .reset(fake_reset), 
        .ram_we(wren),
        .ram_address(ram_address),
        .ram_data(ram_data),
        .ram_op_begun(rready1 || rready2),
        .ram_init_error(error),
        .ram_init_done(done),
        .cs_bo(cs),
        .sclk_o(sclk),
        .mosi_o(mosi),
        .miso_i(miso),
        .GO(trigger),
        .length(len_mod),
        .start(pos_mod),
        .outs(outs),
        .sound_select(R9),
        .state_r(state_r),
        .state_x(state_x),
        .maxx(maxx),
        .sample_mode(sampler_mode),
        .reverse(reverse),
        .monitor(monitor));
        
   MUX mux(
        .toggle(GO),
        .in(ram_data),
        .out1(din1),
        .out2(din2));

        
   fifo_generator_0 fifo(
        .srst(Reset_SH), 
        .clk(clk_50),
        .wr_en(wren),
        .rd_en(btn_clk),
        .din(din1),
        .dout(dout1),
        .prog_full(not_rready1));
        
   inverter invert(
        .a(not_rready1),
        .b(rready1));
        
   fifo_generator_1 fifo1(
        .srst(Reset_SH), 
        .clk(clk_50),
        .wr_en(wren),
        .rd_en(btn_clk),
        .din(din2),
        .dout(dout2),
        .prog_full(not_rready2));
        
   inverter invert1(
        .a(not_rready2),
        .b(rready2));
   
   PCM2PWM PWM(
        .clk(clk_50),
        .data(stereo_sample),
        .PWML(PWML),
        .PWMR(PWMR));
        
        
  // IO //
  
  HexDriver HexA (
        .clk(clk_100),
        .reset(Reset_SH),
        .in({letters[31:28],letters[27:24],letters[23:20],letters[19:16]}),
        .hex_seg(hex_segA),
        .hex_grid(hex_gridA)
    );
    
    HexDriver HexB (
        .clk(clk_100),
        .reset(Reset_SH),
        .in({letters[15:12],letters[11:8],letters[7:4],letters[3:0]}),
        .hex_seg(hex_segB),
        .hex_grid(hex_gridB)
    );
    
    design_1 micro(
        .clk_100MHz(clk_100),
        .reset_rtl_0(~fake_reset), // !!! !!! !!!
        .gpio_rtl_0_tri_i({R1, R2, R3, R4}),
        .gpio_rtl_1_tri_o({pos_mod, dens_mod, len_mod, reverse_block}),
        .gpio_rtl_2_tri_i({R5, R6, R8}),
        .uart_rtl_0_rxd(uart_txd),
        .uart_rtl_0_txd(uart_rxd),
        .gpio_usb_int_tri_i(gpio_usb_int_tri_i),
        .gpio_usb_keycode_0_tri_o(keycode_0_gpio),
        .gpio_usb_keycode_1_tri_o(keycode_1_gpio),
        .gpio_usb_rst_tri_o(gpio_usb_rst_tri_o),
        .usb_spi_miso(usb_spi_miso),
        .usb_spi_mosi(usb_spi_mosi),
        .usb_spi_sclk(usb_spi_sclk),
        .usb_spi_ss(usb_spi_ss));
        
    note2clk notes(
        .keycode(note),
        .count(read_count),
        .read_en(read_en));
          
   ila_0 ila(
        .clk(clk_100),
        .probe0(clk_50),
        .probe1(sampler_mode),
        .probe2(btn_clock),
        .probe3(monitor),
        .probe4(state_r),
        .probe5(outs),
        .probe6(ram_address),
        .probe7(rready1),
        .probe8(rready2),
        .probe9(maxx),
        .probe10(read_clk_short),
        .probe11(read_en));

        
   
endmodule

`timescale 1ns/1ns
module  tb_DDS
();

reg             sys_clk     ;
reg             sys_rst_n   ;
reg             dds_en      ;
reg     [31:0]  f_word      ;
reg     [11:0]  p_word      ;
reg     [1:0]   wave_type   ;

wire    [7:0]   da_data     ;
wire            clk_da      ;

always #20 sys_clk = ~sys_clk;

initial begin
    sys_clk <= 1'b1;
    sys_rst_n <= 1'b0;
    dds_en <= 1'b0;
    f_word <= 32'd0;
    p_word <= 12'd0;
    wave_type <= 2'd0;
    #20
    sys_rst_n <= 1'b1;
    dds_en <= 1'b1;
    f_word <= 32'h1FFFFFFF;
    p_word <= 12'd2047;
    wave_type <= 2'd0;
    #100_000_000
    wave_type <= 2'b1;
    f_word <= 32'h0000_1000;
    #100_000_000
    wave_type <= 2'd2;
    p_word <= 12'h800;
    #100_000_000
    wave_type <= 2'd3;
    #100_000_000
    $stop;

end


top u_top
(
    .sys_clk    ( sys_clk    ),
    .sys_rst_n  ( sys_rst_n  ),
    .dds_en     ( dds_en     ),
    .f_word     ( f_word     ),
    .p_word     ( p_word     ),
    .wave_type  ( wave_type  ),
    .clk_da     ( clk_da     ),
    .da_data    ( da_data    )
);





endmodule
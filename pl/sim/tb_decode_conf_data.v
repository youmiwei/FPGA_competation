`timescale 1ns/1ns
module  tb_decode_conf_data
();

reg             axi_clk         ;
reg             rst             ;
reg     [31:0]  conf_data       ;
reg             dds_work_flag   ;

wire            set_flag        ;
wire            dds_en          ;
wire    [31:0]  f_word          ;
wire    [11:0]  p_word          ;
wire    [1:0]   wave_type       ;

always #5 axi_clk <= ~axi_clk    ;

initial begin
    axi_clk <= 1'b1;
    rst <= 1'b0;
    conf_data <= 32'd0;
    dds_work_flag <= 1'b0;
    #10
    rst <= 1'b1;
    #10
    dds_work_flag <= 1'b1;
    #10
    conf_data <= 32'hffff_ffff;
    #10
    conf_data <= 32'd1000;
    #10
    conf_data <= 32'd2048;
    #10
    conf_data <= 32'd2;
    #10
    conf_data <= 32'hffff_ffff;
    #10
    conf_data <= 32'd0;
end

decode_conf_data u_decode_conf_data
(
    .axi_clk        ( axi_clk        ),
    .rst            ( rst            ),
    .conf_data      ( conf_data      ),
    .dds_work_flag  ( dds_work_flag  ),
    .set_flag       ( set_flag       ),
    .dds_en         ( dds_en         ),
    .f_word         ( f_word         ),
    .p_word         ( p_word         ),
    .wave_type      ( wave_type      )
);

endmodule
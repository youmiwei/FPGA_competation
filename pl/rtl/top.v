module top
(
    input   wire            sys_clk         ,
    input   wire            sys_rst_n       ,
    input   wire            dds_en          ,
    input   wire    [31:0]  f_word          ,//*频率控制字
    input   wire    [11:0]  p_word          ,//*相位控制字
    input   wire    [1:0]   wave_type       ,//*波的类型
    output  wire            clk_da          ,
    output  wire    [7:0]   da_data 
);

wire            sys_clk_bufg            ;
wire            clk_dds                 ;
wire            rst                     ;

wire    [7:0]   dds_out                 ;

//*原语，HDGC引脚需经过BUFG才能连接PLL
BUFG BUFG_inst (
    .O(sys_clk_bufg), // 1-bit output: Clock output.
    .I(sys_clk) // 1-bit input: Clock input.
);

//*PLL模块
clk_wiz_0 CLK_PLL
(
    .clk_out1(clk_dds),//*DDS时钟信号 - 100MHz
    .reset(~sys_rst_n), //*系统复位信号
    .locked(rst),       //*模块复位信号
    .clk_in1(sys_clk_bufg)//*系统时钟
);

//*DDS模块
DDS u_DDS
(
    .clk_dds    ( clk_dds    ),
    .rst        ( rst        ),
    .dds_en     ( dds_en     ),
    .f_word     ( f_word     ),
    .p_word     ( p_word     ),
    .wave_type  ( wave_type  ),
    .dds_out    ( dds_out    )
);

//*DA输出模块
DA_ctrl u_DA_ctrl
(
    .clk_dds  ( clk_dds  ),
    .rst      ( rst      ),
    .dds_out  ( dds_out  ),
    .clk_da   ( clk_da   ),
    .da_data  ( da_data  )
);

endmodule
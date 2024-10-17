module  decode_conf_data
(
    input   wire            axi_clk         ,
    input   wire            dds_clk         ,
    input   wire            rst             ,
    input   wire    [31:0]  conf_data       ,//*配置数据
    input   wire            dds_work_flag   ,//*dds开关

    //*DDS配置信息
    output  reg             dds_en          ,//*dds使能信号
    output  reg             set_flag        ,//*设置参数的脉冲信号
    output  reg     [31:0]  f_word          ,//*频率控制字
    output  reg     [11:0]  p_word          ,//*相位控制字
    output  reg     [1:0]   wave_type        //*波的类型
);

//always@(posedge axi_clk)
fifo_generator_0 fifo_generator_0_inst (
  .wr_clk       (axi_clk),      //* input wire wr_clk
  .rd_clk       (dds_clk),       //* input wire rd_clk
  .din          (conf_data),          //* input wire [31 : 0] din
  .wr_en        (wr_en),        //* input wire wr_en
  .rd_en        (rd_en),        //* input wire rd_en
  .dout         (dout),         //* output wire [31 : 0] dout
  .full         (full),         //* output wire full
  .empty        (empty)         //* output wire empty
);



endmodule
`timescale 1ns/1ns
module  DDS
(
    input   wire            clk_dds         ,
    input   wire            rst             ,
    input   wire            dds_en          ,//*dds使能信号
    input   wire    [31:0]  f_word          ,//*频率控制字
    input   wire    [11:0]  p_word          ,//*相位控制字
    input   wire    [1:0]   wave_type       ,//*波的类型
    output  wire    [7:0]   dds_out          //*输出DDS数据
);

reg     [31:0]      cnt_fre     ;//*频率计数器
reg     [13:0]      cnt_addr    ;//*地址控制
reg                 set_flag_reg;//*set_flag打一拍

//*cnt_fre:频率计数器
always@(posedge clk_dds or negedge rst)
    if(!rst)
        cnt_fre <= 32'd0;
    else if(dds_en == 1'b0)
        cnt_fre <= 32'd0;
    else
        cnt_fre <= cnt_fre + f_word;

//*cnt_addr:地址控制
always@(*)
    if(!rst)
        cnt_addr <= 14'd0;
    else if(dds_en == 1'b0)
        begin
            cnt_addr[11:0] <= p_word;
            cnt_addr[13:12] <= wave_type;
        end
    else
        begin
            cnt_addr[11:0] <= cnt_fre[31:20] + p_word;
            cnt_addr[13:12] <= wave_type;
        end

rom_16384x8b rom_16384x8b_inst 
(
  .clka(clk_dds ),    // input wire clka
  .addra(cnt_addr),  // input wire [13 : 0] addra
  .douta(dds_out )  // output wire [7 : 0] douta
);



endmodule
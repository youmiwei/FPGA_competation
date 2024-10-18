`timescale 1ns/1ns
module  decode_conf_data
(
    input   wire            axi_clk         ,
    input   wire            rst             ,
    input   wire    [31:0]  conf_data       ,//*配置数据
    input   wire            dds_work_flag   ,//*dds开关

    //*DDS配置信息
    output  reg             set_flag        ,//*设置参数的信号
    output  reg             dds_en          ,//*dds使能信号
    output  reg     [31:0]  f_word          ,//*频率控制字
    output  reg     [11:0]  p_word          ,//*相位控制字
    output  reg     [1:0]   wave_type        //*波的类型
);

parameter   DDS_CONF_MAX_NUM = 4'd3         ;
parameter   DDS_CONF_FRAME = 32'hffff_ffff  ;

reg     [3:0]   conf_cnt        ;//*配置计数器

//*set_flag:设置参数的信号
always@(posedge axi_clk or negedge rst)
    if(!rst)
        set_flag <= 1'b0;
    else if(conf_data == DDS_CONF_FRAME)
        set_flag <= ~set_flag;
    else
        set_flag <= set_flag;

//*dds_en:dds使能信号
always@(posedge axi_clk or negedge rst)
    if(!rst)
        dds_en <= 1'b0;
    else if(dds_work_flag == 1'b1)
        dds_en <= 1'b1;
    else
        dds_en <= 1'b0;

//*conf_cnt:配置计数器
always@(posedge axi_clk or negedge rst)
    if(!rst)
        conf_cnt <= 4'd0;
    else if(dds_en == 1'b0 ||  set_flag == 1'b0)
        conf_cnt <= 4'd0;
    else if(dds_en == 1'b1 && set_flag == 1'b1)
        begin
            if(conf_cnt == DDS_CONF_MAX_NUM)
                conf_cnt <= conf_cnt;
            else
                conf_cnt <= conf_cnt + 1'b1;
        end
    else 
        conf_cnt <= conf_cnt;

//*f_word,p_word,wave_type:配置数据寄存
always@(posedge axi_clk or negedge rst)
    if(!rst)
        begin
            f_word <= 32'd0;
            p_word <= 12'd0;
            wave_type <= 2'd0;
        end
    else if(dds_en == 1'b1 && set_flag == 1'b1)
        case(conf_cnt)
            4'd0        :   f_word <= conf_data;
            4'd1        :   p_word <= conf_data[11:0];
            4'd2        :   wave_type <= conf_data[1:0];
            default     :   begin
                                f_word <= f_word;
                                p_word <= p_word;
                                wave_type <= wave_type;
                            end
        endcase
    else
        begin
            f_word <= f_word;
            p_word <= p_word;
            wave_type <= wave_type;
        end

endmodule
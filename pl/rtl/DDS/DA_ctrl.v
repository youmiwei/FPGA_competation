module  DA_ctrl
(
    input   wire            clk_dds         ,
    input   wire            rst             ,
    input   wire    [7:0]   dds_out         ,
    output  wire            clk_da          ,
    output  reg     [7:0]   da_data 
);

assign clk_da = clk_dds;

always@(negedge clk_dds or negedge rst)
    if(!rst)
        da_data <= 8'd0;
    else
        da_data <= 8'd255 - dds_out;

endmodule
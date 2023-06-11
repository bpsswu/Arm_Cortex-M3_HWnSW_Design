`timescale 1ns/1ns

module TB_rsa16;

reg i_clk;
reg i_rstn;
reg i_start;
reg [15 : 0] i_base;
reg [15 : 0] i_exp;
reg [15 : 0] i_N;

wire [15 : 0] o_result;
wire o_end;

rsa16 DUT
(
	.i_clk(i_clk),
	.i_rstn(i_rstn),
	.i_start(i_start),
	.i_base(i_base),
    .i_exp(i_exp),
    .i_N(i_N),
    .o_result(o_result),
    .o_end(o_end)
);

always #100 i_clk = ~i_clk;

initial begin
    
#0
i_clk = 0;
i_rstn = 1;
i_start = 0;
i_base = 0;
i_exp = 0;
i_N = 0;

#6
i_rstn = 0;

#17
i_rstn = 1;

#20
i_base = 1234;
i_exp = 4321;
i_N = 61455;

#13
i_start = 1;

#20
i_start = 0;

#420
i_base = 28601;
i_exp = 23456;
i_N = 61455;

#13
i_start = 1;

#17
i_start = 0;

#350

$stop;

end

endmodule

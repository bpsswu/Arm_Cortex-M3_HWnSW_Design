`timescale 1ns/1ns

module TB_rsa32;

reg i_clk;
reg i_rstn;
reg i_start;
reg [31 : 0] i_base;
reg [31 : 0] i_exp;
reg [31 : 0] i_N;

wire [31 : 0] o_result;
wire o_end;

rsa32 DUT
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

always #5 i_clk = ~i_clk;

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
i_base = 1234567;
i_exp = 7654321;
i_N = 1234567891;

#13
i_start = 1;

#20
i_start = 0;

#420
i_base = 7654321;
i_exp = 1234567;
i_N = 87654321;

#13
i_start = 1;

#17
i_start = 0;

#350

$stop;

end

endmodule

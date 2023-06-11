/*
	module name 	: rsa16
	@ input			: clk, rst, start, base, exp, N
	@ output		: result, end
	@ description	: calculate 16-bit modular exponentiation (result = (base ^ exp) mod N)
*/
module rsa16
(
	input wire i_clk,
	input wire i_rstn,
    input wire i_start,
	input wire [15 : 0] i_base,
    input wire [15 : 0] i_exp,
    input wire [15 : 0] i_N,

	output reg [15 : 0] o_result,
	output wire o_end
);

/* Local variables */

wire i_start_p;
reg [15 : 0] buf_exp;
reg [15 : 0] buf_N;
reg [31 : 0] buf_r;
reg [31 : 0] buf_x;
reg [1 : 0] state, next;
parameter IDLE = 0, START = 1, CALC = 2, DONE = 3;

/* Instantiation */

ltp inst_ltp_1
(
	.i_clk(i_clk),
	.i_rstn(i_rstn),
	.i_level(i_start),
	.o_pulse(i_start_p)
);

/* Logic */

// FSM
always @ (posedge i_clk or negedge i_rstn) begin
	if (!i_rstn) state <= IDLE;
	else state <= next;
end

always @ (*) begin
	case (state)
		IDLE : begin
			if (i_start_p) next = START;
			else next = IDLE;
		end
		START : begin
			next = CALC;
		end
		CALC : begin
			if (buf_exp <= 0) next = DONE;
			else next = CALC;
		end
		DONE : begin
			next = IDLE;
		end
	endcase
end

// [0 : 0] o_end
assign o_end = (state == IDLE || state == DONE) ? 1'b1 : 1'b0;

// [15 : 0] buf_exp
always @ (posedge i_clk or negedge i_rstn) begin
	if (!i_rstn) begin
		buf_exp <= 16'h0;
	end
	else begin
		if (state == START) begin
			buf_exp <= i_exp;
		end
		else if (state == CALC) begin
			buf_exp <= (buf_exp >> 1);
		end
	end
end

// [15 : 0] buf_N
always @ (posedge i_clk or negedge i_rstn) begin
	if (!i_rstn) begin
		buf_N <= 16'h0;
	end
	else begin
		if (state == START) begin
			buf_N <= i_N;
		end
	end
end

// [31 : 0] buf_r
wire [31 : 0] temp1, temp2;
assign temp1 = (buf_r * buf_r);
assign temp2 = temp1 % buf_N;
always @ (posedge i_clk or negedge i_rstn) begin
	if (!i_rstn) begin
		buf_r <= 32'h0;
	end
	else begin
		if (state == START) begin
			buf_r <= {16'h0, i_base};
		end
		else if (state == CALC) begin
			buf_r <= temp2;
		end
	end
end

// [31 : 0] buf_x
wire [31 : 0] temp3, temp4;
assign temp3 = (buf_x * buf_r);
assign temp4 = temp3 % buf_N;
always @ (posedge i_clk or negedge i_rstn) begin
	if (!i_rstn) begin
		buf_x <= 32'h0;
	end
	else begin
		if (state == START) begin
			buf_x <= 32'h1;
		end
		else if ((state == CALC) && (buf_exp[0] == 1)) begin
			buf_x <= temp4;
		end
	end
end

// [15 : 0] o_result
always @ (posedge i_clk or negedge i_rstn) begin
	if (!i_rstn) begin
		o_result <= 16'h0;
	end
	else begin
		if (state == DONE) begin
			o_result <= buf_x;
		end
	end
end

endmodule

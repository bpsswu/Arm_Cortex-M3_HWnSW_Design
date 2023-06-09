/*
	module name 	: rsa32
	@ input			: clk, rst, start, base, exp, N
	@ output		: result, end
	@ description	: calculate 32-bit modular exponentiation (result = (base ^ exp) mod N)
*/
module rsa32
(
	input wire i_clk,
	input wire i_rstn,
    input wire i_start,
	input wire [31 : 0] i_base,
    input wire [31 : 0] i_exp,
    input wire [31 : 0] i_N,

	output reg [31 : 0] o_result,
	output wire o_end
);

/* Local variables */

wire i_start_p;
reg [31 : 0] buf_exp;
reg [31 : 0] buf_N;
reg [63 : 0] buf_r;
reg [63 : 0] buf_x;
reg [3 : 0] cnt_done;
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
			if (cnt_done == 5) next = IDLE;
			else next = DONE;
		end
	endcase
end

// [0 : 0] o_end
assign o_end = (state == DONE) ? 1'b1 : 1'b0;

// [31 : 0] buf_exp
always @ (posedge i_clk or negedge i_rstn) begin
	if (!i_rstn) begin
		buf_exp <= 32'h0;
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

// [31 : 0] buf_N
always @ (posedge i_clk or negedge i_rstn) begin
	if (!i_rstn) begin
		buf_N <= 32'h0;
	end
	else begin
		if (state == START) begin
			buf_N <= i_N;
		end
	end
end

// [63 : 0] buf_r
always @ (posedge i_clk or negedge i_rstn) begin
	if (!i_rstn) begin
		buf_r <= 64'h0;
	end
	else begin
		if (state == START) begin
			buf_r <= {32'h0, i_base};
		end
		else if (state == CALC) begin
			buf_r <= (buf_r * buf_r) % buf_N;
		end
	end
end

// [63 : 0] buf_x
always @ (posedge i_clk or negedge i_rstn) begin
	if (!i_rstn) begin
		buf_x <= 64'h0;
	end
	else begin
		if (state == START) begin
			buf_x <= 64'h1;
		end
		else if ((state == CALC) && (buf_exp[0] == 1)) begin
			buf_x <= (buf_x * buf_r) % buf_N;
		end
	end
end

// [31 : 0] o_result
always @ (posedge i_clk or negedge i_rstn) begin
	if (!i_rstn) begin
		o_result <= 32'h0;
	end
	else begin
		if (state == DONE) begin
			o_result <= buf_x;
		end
	end
end

// [3 : 0] cnt_done
always @ (posedge i_clk or negedge i_rstn) begin
	if (!i_rstn) begin
		cnt_done <= 4'h0;
	end
	else begin
		if (state == IDLE) begin
			cnt_done <= 4'h0;
		end
		else if (state == DONE) begin
			cnt_done <= cnt_done + 1;
		end
	end
end

endmodule

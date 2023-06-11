/*
	module name 	: ltp
	@ input			: i_level (level signal)
	@ output		: o_pulse (pulse_signal)
	@ description	: level to pulse converter (moore fsm)
*/
module ltp
(
	input wire i_clk,
	input wire i_rstn,
	input wire i_level,
    
	output reg o_pulse
);
	
// Local variables
reg [1:0] state, next;
parameter IDLE = 0, ACT = 1, LONG = 2;

// Logic
always @ (posedge i_clk or negedge i_rstn) begin
	if (!i_rstn) state <= IDLE;
	else state <= next;
end

always @ (*) begin
	case (state)
		IDLE : begin
			o_pulse = 0;
			if (!i_level) next = IDLE;
			else next = ACT;
		end
		ACT : begin
			o_pulse = 1;
			if (!i_level) next = IDLE;
			else next = LONG;
		end
		LONG : begin
			o_pulse = 0;
			if (!i_level) next = IDLE;
			else next = LONG;
		end
		default : begin
			next = IDLE;
			o_pulse = 0;
		end
	endcase
end

endmodule

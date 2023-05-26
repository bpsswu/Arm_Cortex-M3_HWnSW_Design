module counter (
    input aclk,
    input aresetn,
    input enable,
    input inc_dec,
    input [7:0] start_value,
    output reg [7:0] count_out
    );

    reg [7:0] prev_start_value;
    
    always @ (posedge aclk or negedge aresetn)
    begin
        if (aresetn == 0 || prev_start_value != start_value)
        begin
            count_out <= start_value;
            prev_start_value <= start_value;
        end
        else
        begin
            if (enable == 1)
            begin
                if (inc_dec == 0)
                begin
                    count_out <= count_out + 1;
                end
                else if (inc_dec == 1)
                begin
                    count_out <= count_out - 1;
                end
            end
            else
            begin
                count_out <= count_out;
            end
        end
    end
endmodule



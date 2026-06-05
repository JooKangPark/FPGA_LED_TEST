module top (
    input  wire clk,     // 100 MHz
    input  wire btn0,
    input  wire btn1,
    output reg  ja1
);

    localparam integer PULSE0_LEN = 2;   // 16ns
    localparam integer PULSE1_LEN = 3;   // 24ns

    reg btn0_sync0, btn0_sync1, btn0_prev;
    reg btn1_sync0, btn1_sync1, btn1_prev;

    wire btn0_rise;
    wire btn1_rise;

    assign btn0_rise = btn0_sync1 & ~btn0_prev;
    assign btn1_rise = btn1_sync1 & ~btn1_prev;

    reg [15:0] pulse_cnt;

    always @(posedge clk) begin
        // button synchronizer
        btn0_sync0 <= btn0;
        btn0_sync1 <= btn0_sync0;
        btn0_prev  <= btn0_sync1;

        btn1_sync0 <= btn1;
        btn1_sync1 <= btn1_sync0;
        btn1_prev  <= btn1_sync1;

        // pulse generator
        if (btn0_rise) begin
            pulse_cnt <= PULSE0_LEN;
            ja1 <= 1'b1;
        end else if (btn1_rise) begin
            pulse_cnt <= PULSE1_LEN;
            ja1 <= 1'b1;
        end else if (pulse_cnt > 0) begin
            pulse_cnt <= pulse_cnt - 1'b1;
            ja1 <= 1'b1;
        end else begin
            ja1 <= 1'b0;
        end
    end

endmodule
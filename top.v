
module top (
	input	wire	clk,
	input	wire	btn0,
	input	wire	btn1,
	output	reg     ja1,
	output  reg     ja2
);

	wire	clk_100m, clk_50m;
	wire	locked;

	clk_wiz_0 u_clk_wiz_0 (
		.clk_in1	(clk),
		.clk_out1	(clk_100m),
		.clk_out2	(clk_50m),
		.locked		(locked)
	);
	
	reg btn0_sync0, btn0_sync1;
	reg btn0_prev;
	
	reg btn1_sync0, btn1_sync1;
	reg btn1_prev;

	always @(posedge clk_100m) begin
	// always @(posedge clk) begin
		if (!locked) begin
			btn0_sync0 <= 1'b0;
			btn0_sync1 <= 1'b0;
			btn0_prev  <= 1'b0;
			ja1	  <= 1'b0;
		end else begin
			btn0_sync0 <= btn0;
			btn0_sync1 <= btn0_sync0;
			btn0_prev  <= btn0_sync1;
			ja1	  <= btn0_sync1 & ~btn0_prev;
		end
	end
	
	always @(posedge clk_50m) begin
	// always @(posedge clk) begin
		if (!locked) begin
			btn1_sync0 <= 1'b0;
			btn1_sync1 <= 1'b0;
			btn1_prev  <= 1'b0;
			ja2	  <= 1'b0;
		end else begin
			btn1_sync0 <= btn1;
			btn1_sync1 <= btn1_sync0;
			btn1_prev  <= btn1_sync1;
			ja2	  <= btn1_sync1 & ~btn1_prev;
		end
	end
	// assign ja2 = btn1;
endmodule

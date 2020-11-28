module top(
	output	[17:0] pins
);
	reg		[23:0]	div;
	wire			clk;
	reg				sysclk = 0;
	reg		[17:0]	leds = 1;


	OSCH #(
		.NOM_FREQ("2.08")
	) internal_oscillator_inst (
		.STDBY(1'b0), 
		.OSC(clk)
	);

	always @(posedge clk) begin
		if (div < 500000) div <= div + 1;
		else begin
			div <= 0;
			sysclk = ~sysclk;
		end
	end

	always @(posedge sysclk) begin
		if (leds[17]) leds <= 1;
		else begin
			leds[17:1] <= leds[16:0];
			leds[0] <= 0;
		end
	end

	assign pins = leds;

endmodule

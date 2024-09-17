// Differs from Structural Verilog lecture by adding a synchronous
// preset input
module dflipflop (input clk, input reset, input preset, 
		  input enable, input d, output q);

   reg state;

   assign q = state;

   always @(posedge clk) begin
      if (reset)
	state <= 0;
      else if (preset)
	state <= 1;
      else if (enable)
	state <= d;
   end
   
endmodule // dff

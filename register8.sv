/*
 Module: register8
 Company: UW-Madison
 Designer: Prof. lipasti
 Number: 1
 Revision: A 
 Date: 4/2/2024
 */
module register8(input clk, input reset, input load, input clear, input [7:0] d, output [7:0] q);

   logic enable;
   logic [7:0] loadvalue;
   
   assign enable = load | clear;
   assign loadvalue = clear ? 8'h00 : d;
   
   dflipflop ff[7:0] (.clk(clk),.reset(reset),.preset(1'b0),
		       .enable(enable),.d(loadvalue),.q(q));
   
endmodule // register

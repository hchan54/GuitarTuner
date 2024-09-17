/*
Module: register0
 Company: UW-Madison
 Designer: Hunter Chan & David Uk 
 Number: 
 Revision: A 
 Date: 4/22/2024

*/

module register0(
   input clk,
   input reset,
   input load, 
   input clear,
   input d,
   output q
);
   logic enable;
   logic loadvalue;

   assign enable = load | clear;
   assign loadvalue = clear? 1'b0 : d;

   dflipflop ff1 (
      .clk(clk),
      .reset(reset),
      .preset(1'b0),
      .enable(enable), 
      .d(loadvalue),
      .q(q)
   );

endmodule 
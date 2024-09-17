/*
 Module: ha (half adder)
 Company: UW-Madison
 Designer: Prof. lipasti
 Number: 1
 Revision: A 
 Date: 4/2/2024
 */
module ha(input logic a,
	  input logic  b,
	  output logic ps,
	  output logic sc);

   assign ps = a^b;
   assign sc = a&b;

endmodule // ha

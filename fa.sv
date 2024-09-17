/*
 Module: fa (full adder)
 Company: UW-Madison
 Designer: Prof. lipasti
 Number: 1
 Revision: A 
 Date: 4/2/2024
 */
// --sums three bits and generates partial sum and shifted carry
module fa(input logic a,   // early if possible
	   input logic 	b, // early if possible
	   input logic 	c, // late if possible
	   output logic ps,
	   output logic sc);

   assign ps = a^b^c;
   assign sc = a&b | b&c | a&c;
   
endmodule // csa


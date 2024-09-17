/*
 Module: multiplier_pipelined_tb
 Company: UW-Madison
 Designer: Prof. lipasti
 Number: 1
 Revision: A 
 Date: 4/2/2024
 */
module multiplier_pipelined_tb();

   logic clk, reset;
   logic [3:0] a,b;
   logic [7:0] p;
   logic       error;
   logic [7:0] gold_p, prev_gold_p; // prev handles pipeline delay
  
   ///////////////////////////////////////////////////////////
   // Instantiate DUT                                       //
   // This testbench passes only if the multiplier          //
   // is pipelined into two stages                          //
   ///////////////////////////////////////////////////////////
   multiplier mDUT(.*); // wildcard matches ports a,b,p to signals a,b,p
  
   // set up clk 
   always #5 clk = !clk;

   initial begin
      clk = 0'b0; 
      a = 4'b0;
      b = 4'b0;
      error = 1'b0;	// innnocent till proven guilty
      reset = 1'b1;
      #10
      reset = 1'b0;
      #10
      gold_p = 0; // first result is 0 due to resetting of output reg
      for(integer av=0;av<16;++av) begin
        for(integer bv=0;bv<16;++bv) begin
          a = av;
          b = bv;
          #10;
	  prev_gold_p = gold_p; // result from previous multiply is saved here
          gold_p = a * b;
          if (p!==prev_gold_p) begin // compare against prev b/c of pipeline delay
            error = 1'b1;			// guilty
            $display("ERROR: expected prev_gold_p=%h with a=%h, b=%h, instead p=%h",prev_gold_p,a,b,p);
         end else begin
            //$display("NOERR: expected prev_gold_p=%h with a=%h, b=%h, got p=%h",prev_gold_p,a,b,p);
         end
       end
      end
      if (!error)
	$display("YAHOO!! test passed");
      $stop();
   end
  
endmodule

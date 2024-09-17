/*
 Module: multiplier_tb
 Company: UW-Madison
 Designer: Prof. lipasti
 Number: 1
 Revision: A 
 Date: 4/2/2024
 */
module multiplier_tb();

   logic clk, reset;
   logic [3:0] a,b;
   logic [7:0] p;
   logic       error;
   logic [7:0] gold_p;
  
   //////////////////////
   // Instantiate DUT //
   ////////////////////
   multiplier mDUT(.*); // wildcard matches ports a,b,p to signals a,b,p
  
   // set up clk 
   always #5 clk = !clk;

   initial begin
      clk = 0'b0;
      error = 1'b0;	// innnocent till proven guilty
      reset = 1'b1;
      #10
      reset = 1'b0;
      #10
      for(integer av=0;av<16;++av) begin
        for(integer bv=0;bv<16;++bv) begin
          a = av;
          b = bv;
          #20;
          gold_p = a * b;
          if (p!==gold_p) begin
            error = 1'b1;			// guilty
            $display("ERROR: expected gold_p=%h with a=%h, b=%h, instead p=%h",gold_p,a,b,p);
         end else begin
            //$display("NOERR: expected gold_p=%h with a=%h, b=%h, got p=%h",gold_p,a,b,p);
         end
       end
      end
      if (!error)
	$display("YAHOO!! test passed");
      $stop();
   end
  
endmodule

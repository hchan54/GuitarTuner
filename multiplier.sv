/*
 Module: multiplier
 Company: UW-Madison
 Designer: Hunter Chan & Bawi Uk 
 Number: 1
 Revision: A 
 Date: 4/2/2024
 */
module multiplier(input logic clk, reset,
                  input logic [3:0] a,
		  input logic [3:0] b,
		  output logic [7:0] p);

   // output is registered
   logic [7:0] p_next;
   register8 regout(.clk(clk),.reset(reset),.load(1'b1),.clear(1'b0),.d(p_next),.q(p));
   
   // pipelined registers
   logic ppl0, ppl1, ppl2, ppl3, ppl4, ppl5, ppl6, ppl7, ppl8, ppl9 ,ppl10 ,ppl11 ,ppl12; 

   // 4x4 parallelogram of partial products
   logic [3:0][3:0] 		      pp;

   assign pp[0] = {4{a[0]}} & b; // delay 1ns to gen all 16 PPs
   assign pp[1] = {4{a[1]}} & b;
   assign pp[2] = {4{a[2]}} & b;
   assign pp[3] = {4{a[3]}} & b;

   // diagonal carries across columns
   logic [2:0][2:0] 		      dc;
   // horizontal carry-propagate in last row
   logic [1:0] 			      hc;
   // partial sums between rows
   logic [2:0][1:0] 		      ps;
   
   // P0 is just a wire
   assign p_next[0] = ppl10;
   
   // P1 needs HA
   ha ha1(.a(pp[0][1]),.b(pp[1][0]),.ps(ppl11),.sc(dc[0][0]));
   
   // P2 needs HA and FA
   ha ha2(.a(pp[0][2]),.b(pp[1][1]),.ps(ps[0][0]),.sc(dc[0][1]));
   fa fa2(.a(pp[2][0]),.b(dc[0][0]),.c(ps[0][0]),.ps(ppl1),.sc(ppl2));
   
   // P3 needs HA and 2xFA
   ha ha3(.a(pp[0][3]),.b(pp[1][2]),.ps(ps[0][1]),.sc(dc[0][2]));
   fa fa30(.a(pp[2][1]),.b(dc[0][1]),.c(ps[0][1]),.ps(ppl3),.sc(ppl4));
   fa fa31(.a(ppl12),.b(dc[1][0]),.c(ps[1][0]),.ps(p_next[3]),.sc(dc[2][0]));
   
   // P4 needs 2xFA and HA
   fa fa40(.a(pp[2][2]),.b(pp[1][3]),.c(dc[0][2]),.ps(ppl5),.sc(ppl6));
   fa fa41(.a(ppl13),.b(dc[1][1]),.c(ps[1][1]),.ps(ps[2][0]),.sc(dc[2][1]));
   ha ha4(.a(dc[2][0]),.b(ps[2][0]),.ps(p_next[4]),.sc(hc[0]));
   
   // P5 needs 2xFA
   fa fa50(.a(ppl7),.b(ppl8),.c(dc[1][2]),.ps(ps[2][1]),.sc(dc[2][2]));
   fa fa51(.a(ps[2][1]),.b(dc[2][1]),.c(hc[0]),.ps(p_next[5]),.sc(hc[1]));
   
   // P6 and P7 need FA
   fa fa67(.a(ppl9),.b(dc[2][2]),.c(hc[1]),.ps(p_next[6]),.sc(p_next[7]));
   
   //added pipelining registers
   
   register0 pipe0(.clk(clk), .reset(reset), .load(1'b1), .clear(1'b0), .d(ppl1), .q(p_next[2]));
   register0 pipe1(.clk(clk), .reset(reset), .load(1'b1), .clear(1'b0), .d(ppl2), .q(dc[1][0]));
   register0 pipe2(.clk(clk), .reset(reset), .load(1'b1), .clear(1'b0), .d(ppl3), .q(ps[1][0]));
   register0 pipe3(.clk(clk), .reset(reset), .load(1'b1), .clear(1'b0), .d(ppl4), .q(dc[1][1]));
   register0 pipe4(.clk(clk), .reset(reset), .load(1'b1), .clear(1'b0), .d(ppl5), .q(ps[1][1]));
   register0 pipe5(.clk(clk), .reset(reset), .load(1'b1), .clear(1'b0), .d(ppl6), .q(dc[1][2]));
   register0 pipe6(.clk(clk), .reset(reset), .load(1'b1), .clear(1'b0), .d(pp[2][3]), .q(ppl7));
   register0 pipe7(.clk(clk), .reset(reset), .load(1'b1), .clear(1'b0), .d(pp[3][2]), .q(ppl8));
   register0 pipe8(.clk(clk), .reset(reset), .load(1'b1), .clear(1'b0), .d(pp[3][3]), .q(ppl9));
   register0 pipe9(.clk(clk), .reset(reset), .load(1'b1), .clear(1'b0), .d(pp[0][0]), .q(ppl10));
   register0 pipe10(.clk(clk), .reset(reset), .load(1'b1), .clear(1'b0), .d(ppl11), .q(p_next[1]));
   register0 pipe11(.clk(clk), .reset(reset), .load(1'b1), .clear(1'b0), .d(pp[3][0]), .q(ppl12));
   register0 pipe12(.clk(clk), .reset(reset), .load(1'b1), .clear(1'b0), .d(pp[3][1]), .q(ppl13));
   
endmodule // multiplier